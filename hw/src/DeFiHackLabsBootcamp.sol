// SPDX-License-Identifier: MIT
pragma solidity =0.8.25;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DeFiHackLabsBootCamp is Ownable {
    uint256 public constant DURATION = 1 weeks;
    uint256 public immutable DEADLINE;

    mapping(uint256 number => bool) public isRegister;
    mapping(uint256 number => bool) public isSignIn;
    mapping(uint256 number => address student) public students;
    mapping(uint256 number => string name) public studentName;

    event BootCampStudentRegister(uint256 indexed number, address indexed student);
    event BootCampStudentSignIn(
        uint256 indexed number, address indexed student, string indexed name, uint256 timestamp
    );

    error NotRegister(uint256 number);
    error NotBootCampStudent(address student);
    error NotMatchNumber(uint256 number);
    error NotMatchName(string name);
    error AlreadyRegister(uint256 number);
    error AlreadySignIn(uint256 number, string name);
    error FailToSignIn();
    error SignInDeadlinePassed(uint256 timestamp, uint256 deadline);

    constructor() Ownable(msg.sender) {
        DEADLINE = block.timestamp + DURATION;
    }

    modifier onlyBootCampStudent(uint256 number) {
        if (!isRegister[number]) revert NotRegister(number);
        if (msg.sender != students[number]) revert NotMatchNumber(number);
        _;
    }

    function isBootCampStudent(uint256 number, address student) private pure returns (bool) {
        uint256 studentId = uint256(uint160(student));
        studentId = (studentId >> ((1 << 7) | (1 << 3)));

        if (number != (studentId & 0xff) - (6 * (number / 10))) revert NotMatchNumber(number);
        if (studentId < 14610689 || studentId > 14610772) {
            return false;
        }

        return true;
    }

    ///@param number The number in this BootCamp class
    function register(uint256 number) external {
        if (isRegister[number]) revert AlreadyRegister(number);
        if (!isBootCampStudent(number, msg.sender)) {
            revert NotBootCampStudent(msg.sender);
        }

        isRegister[number] = true;
        students[number] = msg.sender;

        emit BootCampStudentRegister(number, msg.sender);
    }

    function signIn(uint256 number, string calldata name, uint256 time, uint8 v, bytes32 r, bytes32 s)
        external
        onlyBootCampStudent(number)
    {
        if (isSignIn[number]) revert AlreadySignIn(number, name);
        if (block.timestamp > DEADLINE) revert SignInDeadlinePassed(block.timestamp, DEADLINE);

        bytes32 hash = keccak256(abi.encode(number, name, time));
        address signer = ecrecover(hash, v, r, s);
        if (msg.sender != signer) revert FailToSignIn();

        isSignIn[number] = true;
        studentName[number] = name;

        emit BootCampStudentSignIn(number, msg.sender, name, time);
    }
}
