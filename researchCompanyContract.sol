// Solidity program 

// SPDX-License-Identifier: MIT
pragma solidity ^0.8;


contract ResearchCompany {

    struct Campaign {
      string title;
      string description;
      string cause;
      string dateStarted;
      string dateFinal;
      string[] types;
      string[] ipfsDocAddress;
      address[] patients;
      uint targetNumber;
      uint standardAmt;
      uint indexOfCampaign;
      address companyAddress;
   }

    address private companyAddress;


    uint private referanceKey;
    Campaign[] campaigns;

    constructor(address creator) {
        companyAddress = creator;
        referanceKey = 0;
    }


    function createNewCampaign(string memory title, 
    string memory description, string memory cause,
    string memory dateStarted, string memory dateFinal,
    string[] memory types, address[] memory patients,
    uint  targetNumber, uint  stardartAmt, address hostedContractAddress ) public payable {

        require(msg.value >= stardartAmt*targetNumber);

        string[] memory ipfsDocumentAddress;
        address[] memory patients;
        
        campaigns.push(Campaign(title,description,cause,dateStarted,dateFinal,types,ipfsDocumentAddress,patients, targetNumber, stardartAmt, referanceKey, hostedContractAddress ));
        referanceKey =referanceKey + 1;

    }

    function getAllCampaigns() public view returns(Campaign[] memory){
        return campaigns;
    }


    function addUsersDataToCampaign(string memory ipfsDoc, address payable _to, uint campaignIndex) public {

        campaigns[campaignIndex].ipfsDocAddress.push(ipfsDoc);
        _to.transfer(campaigns[campaignIndex].standardAmt);

    }

    function returnRemainingCampaignAmt(uint index) public {
        require( msg.sender == companyAddress);

        payable(companyAddress).transfer((campaigns[index].targetNumber - campaigns[index].ipfsDocAddress.length)*campaigns[index].standardAmt - 150);
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }

    
}