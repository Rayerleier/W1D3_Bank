// Write a Bank contract to achieve the following functionalities:

// Allow deposit to the Bank contract address directly through wallets like Metamask
// Keep track of the deposit amount for each address in the Bank contract
// Implement a withdraw() method that allows only the administrator to withdraw funds
// Use an array to record the deposit amounts for the top 3 users
// Please submit the completed project code or the GitHub repository address.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank{
    address private admin;
    mapping (address => uint256) amounts;
    address [3]  private   top3;

    constructor() payable {
        admin = msg.sender;
    }

    // users deposit
    receive() external  payable {
        amounts[msg.sender] += msg.value;
        comparator(msg.sender, amounts[msg.sender]);
        
    }

    // withdraw for administrator
    function withdraw(uint256 _amount)external payable  {
        require(msg.sender == admin, "Only Admin can withdraw");
        require(_amount<= address(this).balance, "Not enough balance");
        payable(admin).transfer(_amount);


    }

    

    // Comparator for top3 depositors
    function comparator(address user, uint256 balance) private {
        for (uint i = 0; i < 3; i++) {
            if (balance > amounts[top3[i]]) {
                for (uint j = 2; j > i; j--) {
                    top3[j] = top3[j - 1];
                }
                top3[i] = user;
                break;
            }
        }
    }


    // show top3
    function show_top3() public view returns (address[3] memory) {
        return top3;
    }

    fallback() external payable {

    }
}