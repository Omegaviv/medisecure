// Solidity program 

// SPDX-License-Identifier: MIT
pragma solidity ^0.8;
contract Doctor {

    address private doctorAddress;

    address[] private listOfPatientAddress;
    mapping(address=> uint) private patientIndex;
    uint private referanceKey;



    constructor(address creator) {
        doctorAddress = creator;
        referanceKey = 1;
    }

    function addPatientAddress(address patientAddress) public{

        require(msg.sender == doctorAddress);
        if(patientIndex[patientAddress]!=0){
            listOfPatientAddress[patientIndex[patientAddress]-1] = patientAddress;
        }
        else {
            listOfPatientAddress.push(patientAddress);
            patientIndex[patientAddress]  = referanceKey;
            referanceKey = referanceKey+1;
        }

    }

    function getPatientAddress()public view returns(address[] memory){

         require(msg.sender == doctorAddress);
         return listOfPatientAddress;
    }

    function removePatientAddress(address patientAddress) public {

        require(msg.sender == doctorAddress);

        listOfPatientAddress[patientIndex[patientAddress]] = address(0);
    }
    
}