/* TransactionManager.sol */

pragma solidity >=0.4.0 <0.7.0;

import "../contracts/UserManager.sol";
import "../contracts/ProposalManager.sol";

import "../contracts/Person.sol";
import "../contracts/Transaction.sol";

/* <Summary> 
	Manages the list of transaction as well as making transactions
*/

contract TransactionManager {
	mapping (address => mapping (address => Transaction[]) ) transactions;
	UserManager UserManagerInstance;			// Connects to the list of users on the network
	ProposalManager ProposalManagerInstance;	// Connects to the list of active proposals on the network


	constructor(address UserManagerAddress, address ProposalManagerAddress) public {
		UserManagerInstance = UserManager(UserManagerAddress);
		ProposalManagerInstance = ProposalManager(ProposalManagerAddress);
	}

	// Makes a transaction between 2 users
	function MakeTransaction(address _reciever, uint _amount) external {
		require (!CheckForBribery(msg.sender, _reciever), "This is Bribery");

		Person sender = UserManagerInstance.getUser(msg.sender); // Finds sender
		Person reciever = UserManagerInstance.getUser(_reciever); // Finds reciever

		// Makes transaction 
		transactions[msg.sender][_reciever].push(new Transaction(sender, reciever, _amount));
	}

	// Gets transacions between 2 addresses
	function getTransactions(address sender, address receiver) external view returns(Transaction[] memory) {
		return transactions[sender][receiver];
	}

	// Get a transaction between 2 address but returns it in parts
	function getTransactionJS(address sender, address receiver, uint i) external view returns(address, address, uint) {
		require(i < transactions[sender][receiver].length && i >= 0, "Invalid Index");
		return transactions[sender][receiver][i].getTransaction();
	}

	function Equal(address sender, address receiver, uint timeStamp, uint _amount) external view returns (bool) {
		Transaction[] storage temp = transactions[sender][receiver];

		for (uint i = 0; i < temp.length; i++){
			if (temp[i].Equal(timeStamp, sender, receiver, _amount)){
				return true;
			}
		}
		return false;
	}

	function CheckForBribery(address _newAccount, address _voter) internal view returns (bool){
		address[] memory addresses = UserManagerInstance.getAddresses(); // List of addresses on the network

		for (uint i = 0; i < addresses.length; i++){					// For each address
			if (_newAccount != addresses[i]){							// The new account can not be a voter
				if (ProposalManagerInstance.ActiveProposalLength(addresses[i], _newAccount)){
					Proposal temp = ProposalManagerInstance.getActiveProposal(addresses[i], _newAccount);
					address[] memory voters = temp.getVoters();
					for(uint j = 0; j < voters.length; j++){
						if (voters[j] == _voter){
							return false;
						}
					}
				}
			}
		}
		return false;
	}

}
