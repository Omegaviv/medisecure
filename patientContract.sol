// Solidity program 

// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract Patient {
    
    struct MedicalRecord {
      string title;
      string description;
      address doctor;
      string dateUploaded;
      string[] types;
      string ipfsDocumentAddress;
   }

    address private patientAddress;
    
    mapping(address=> bool) private hasAccessToRecords;
    address[] private authorizedUsers;
    uint private referanceKey;
    mapping(address=> uint) private authorizedIndex;

    MedicalRecord[] private patientMedicalRecords;

    constructor(address creator) {
        patientAddress = creator;
        hasAccessToRecords[creator] = true;
        authorizedUsers.push(creator);
        referanceKey = 1;
        authorizedIndex[creator] = 0;
    }

    function addUserToHaveAccess(address userAddress) public{

        // check for only patient to access

        require(msg.sender == patientAddress);

        if(authorizedIndex[userAddress]!=0){
            hasAccessToRecords[userAddress] = true;
            authorizedUsers[authorizedIndex[userAddress]] = userAddress;
        }
        else {
            hasAccessToRecords[userAddress] = true;
            authorizedUsers.push(userAddress);
            authorizedIndex[userAddress] = referanceKey;
            referanceKey = referanceKey +1;
        }
        
    }

    function removeUserToHaveAccess(address userAddress) public{

        // check for only patient to access

         require(msg.sender == patientAddress);

        hasAccessToRecords[userAddress] = false;
        authorizedUsers[authorizedIndex[userAddress]] = address(0);

    }

    function addMedicalRecord(string memory title, string memory description, address doctor, string memory dateUploaded, string memory documentAddress, string[] memory types) public { 

        // check for only authorized user to have add access

        require(hasAccessToRecords[msg.sender] == true && msg.sender!=patientAddress);

        patientMedicalRecords.push(MedicalRecord(title,description,doctor,dateUploaded,types,documentAddress));

    }


    function getPatientMedicalRecords() public view returns (MedicalRecord[] memory) {
        
        // check for only patient itself
        require(hasAccessToRecords[msg.sender] == true);
        return patientMedicalRecords;

    }

    function getAuthorizedUserList()public view returns (address[] memory){

        require(msg.sender == patientAddress);
        return authorizedUsers;

    }

}