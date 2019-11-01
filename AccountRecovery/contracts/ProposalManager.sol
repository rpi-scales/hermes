/* ProposalManager.sol */

pragma solidity >=0.4.0 <0.7.0;

import "../contracts/UserManager.sol";
import "../contracts/Proposal.sol";

import "../contracts/Person.sol";

/* <Summary> 
	This contract manages all active proposal as well as makes and concludes proposals.
*/

contract ProposalManager {

	struct ProposalPair {
		Proposal proposal;
		bool exists;
	}

	UserManager UserManagerInstance;				// Connects to the list of users on the network

	mapping (address => mapping (address => ProposalPair) ) activeProposals; // Map of active proposals
													// Old Account -> New Account -> Proposal
	mapping (address => mapping (address => address[]) ) archivedVoters; 	// Map of active proposals
													// Old Account -> New Account -> bool
	mapping (address => mapping (address => bool) ) invalidProposal; 	// If true then there has already been a proposal
													// Old Account -> New Account -> bool

	// Used to originally deploy the contract
	constructor(address UserManagerAddress ) public {
		UserManagerInstance = UserManager(UserManagerAddress);
	}

	function VetoAccountRecovery(address _newAccount) external{
		archiveProposal(msg.sender, _newAccount);
	}
	
	// Counts up votes and distriputes the reward
	function ConcludeAccountRecovery(address _oldAccount) external {
		Proposal temp = getActiveProposal(_oldAccount, msg.sender);
		
		int outcome = temp.ConcludeAccountRecovery(UserManagerInstance);

		require (outcome != -1, "You must wait more time until you can conclude the vote");

		if (outcome >= 66){											// Successful vote
			// Finds old account and new account on the network
			Person oldAccount = UserManagerInstance.getUser(_oldAccount);
			Person newAccount = UserManagerInstance.getUser(msg.sender);

			// Transfers balance
			newAccount.increaseBalance(oldAccount.balance());	// Increase new accounts balance
			oldAccount.decreaseBalance(oldAccount.balance());	// Decrease old accounts balance

		}
		archiveProposal(_oldAccount, msg.sender);

		if (outcome >= 60 && outcome < 66){								// Vote failed. No revote
			invalidProposal[_oldAccount][msg.sender] = false;
		}
	}

	// Allows a voter to cast a vote on a proposal
	function CastVote(address oldAccount, address newAccount, bool choice) external {
		getActiveProposal(oldAccount, newAccount).CastVote(msg.sender, choice);
	}

	// View public information on a set of data for a transaction
	function ViewPublicInformation(address oldAccount, address newAccount, uint i) external view returns (uint, uint, address, address)	{
		return getActiveProposal(oldAccount, newAccount).ViewPublicInformation( msg.sender, i );
	}

	// View private information on a set of data for a transaction
	function ViewPrivateInformation(address oldAccount, address newAccount, uint i) external view returns (string memory, string memory)	{
		return getActiveProposal(oldAccount, newAccount).ViewPrivateInformation( msg.sender, i );
	}

	// Find the active proposal between _oldAccount and _newAccount
	function getActiveProposalExists(address _oldAccount, address _newAccount) public view returns (bool) {
		return activeProposals[_oldAccount][_newAccount].exists;
	}
	
	// Find the active proposal between _oldAccount and _newAccount
	function getActiveProposal(address _oldAccount, address _newAccount) public view returns (Proposal) {
		require(getActiveProposalExists(_oldAccount, _newAccount), "There is no active Proposal");
		return activeProposals[_oldAccount][_newAccount].proposal;
	}
	
	// Adds an active proposal between _oldAccount and _newAccount
	function AddActiveProposal(address _oldAccount, address _newAccount, Proposal temp) external {
		invalidProposal[_oldAccount][_newAccount] = true;

		ProposalPair memory tempPair;
		tempPair.proposal = temp;
		tempPair.exists = true;

		activeProposals[_oldAccount][_newAccount] = tempPair;
	}
	
	// Find the archived proposal between _oldAccount and _newAccount
	function getArchivedVoter(address _oldAccount, address _newAccount) external view returns (address[] memory) {
		return archivedVoters[_oldAccount][_newAccount];
	}

	function archiveProposal(address _oldAccount, address _newAccount) public {
		Proposal temp = getActiveProposal(_oldAccount, _newAccount);

		address[] memory voters = temp.getVoters();

		for (uint i = 0; i < voters.length; i++){
			archivedVoters[_oldAccount][_newAccount].push(voters[i]);
		}

		delete activeProposals[_oldAccount][_newAccount];
	}

	function validProposal(address _oldAccount, address _newAccount) external view returns (bool) {
		return !invalidProposal[_oldAccount][_newAccount];
	}
}
