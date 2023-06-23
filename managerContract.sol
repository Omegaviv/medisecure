// Solidity program 

// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

import "./patientContract.sol";
import "./doctorContract.sol";
import "./patientContract.sol";
import "./researchCompanyContract.sol";


contract ManagerContract{

    address private creatorAddress;


    Patient[] private patientsContractAddress;
    Doctor[] private doctorsContractAddress;
    ResearchCompany[] private companysContractAddress;


    uint private patientReferanceKey;
    uint private doctorReferanceKey;
    uint private companyReferanceKey;




    mapping(address => uint) userTopatientAddress;
    mapping(address => uint) userToDoctorAddress;
    mapping(address => uint) userToCompanyAddress;

    constructor(){
        creatorAddress = msg.sender;
        patientReferanceKey=1;
        doctorReferanceKey=1;
        companyReferanceKey=1;
    }


    // creating patient contract

    function createPatientContract() public {
        Patient newPatientContractAddress = new Patient(msg.sender);
        patientsContractAddress.push(newPatientContractAddress);
        userTopatientAddress[msg.sender] = patientReferanceKey;
        patientReferanceKey = patientReferanceKey+1;
    }


    function createDoctorContract() public {
        Doctor newDoctorContractAddress = new Doctor(msg.sender);
        doctorsContractAddress.push(newDoctorContractAddress);
        userToDoctorAddress[msg.sender] = doctorReferanceKey;
        doctorReferanceKey = doctorReferanceKey+1;
    }

    function createCompanyContract() public {
        ResearchCompany newCompanyContractAddress = new ResearchCompany(msg.sender);
        companysContractAddress.push(newCompanyContractAddress);
        userToCompanyAddress[msg.sender] = companyReferanceKey;
        companyReferanceKey = companyReferanceKey+1;
    }



    // reutnn contract address

    function getDeployedPatientContract(address patientAddress) public view returns( Patient){
        require(userTopatientAddress[patientAddress]!=0);
        return patientsContractAddress[userTopatientAddress[patientAddress]-1];
    }

    function getDeployedDoctorContract() public view returns(Doctor){
        require(userToDoctorAddress[msg.sender]!=0);
        return doctorsContractAddress[userToDoctorAddress[msg.sender]-1];
    }

    function getDeployedCompanyContract() public view returns(ResearchCompany){
        require(userToCompanyAddress[msg.sender]!=0);
        return companysContractAddress[userToCompanyAddress[msg.sender]-1];
    }

    function getResearchCompanyAdderss() public view returns (ResearchCompany[] memory){
        return companysContractAddress;
    }

}