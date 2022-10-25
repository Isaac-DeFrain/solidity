// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0; 

contract Degree {
    // *****************
    // *** variables ***
    // *****************

    address public immutable registrar;
    struct Course{
        string name;
        uint gpa;
    }
    struct Student{
        address studentPerson;
        uint hashOfDegreeDetails;
        uint overallGPA;
        bool graduationStatus;
    }
    Student private defaultStudent;
    mapping(address => Student) public students;
    mapping(address => mapping(string => uint)) public courseIndex;
    mapping(address => Course[]) public studentCourses;

    // *****************
    // *** modifiers ***
    // *****************

    modifier onlyRegistrar{
        require(msg.sender == registrar);
        _;
    }

    modifier onlyStudent{
        require(msg.sender == students[msg.sender].studentPerson);
        _;
    }

    // constructor function
    constructor() {
        registrar = msg.sender;
    }

    // **********************
    // *** public methods ***
    // **********************

    function setStudent(address studentPerson) onlyRegistrar public {
        Student memory temp = defaultStudent;
        temp.studentPerson = studentPerson;
        students[studentPerson] = temp;
    }

    function setGraduated(address studentPerson) onlyRegistrar public {
        students[studentPerson].graduationStatus = true;
    }

    function setCourse(address studentPerson, string memory courseName, uint courseGPA) onlyRegistrar public {
        Course[] storage cs = studentCourses[studentPerson];
        uint newIndex = cs.length;
        cs.push(Course({name : courseName, gpa : courseGPA}));
        courseIndex[studentPerson][courseName] = newIndex;
    }

    // *********************
    // *** other methods ***
    // *********************

    // receive()
    // fallback()
}
