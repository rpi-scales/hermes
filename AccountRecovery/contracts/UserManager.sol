/* UserManager.sol */

pragma solidity >=0.4.0 <0.7.0;

import "../contracts/Person.sol";
import "../contracts/TransactionManager.sol";

/* <Summary> 
	Manages all the users in the network
*/

contract UserManager {

	mapping (address => Person) Users;					// Map of users on the network
	address[] addresses;								// Addresses on the network

	constructor(address[] memory _addresses) public {
		addresses = _addresses;
		for (uint i = 0; i < addresses.length; i++) {	// Creates users on the network
			Users[addresses[i]] = new Person(addresses[i], 1000);
		}
	}

	// Gets User with the given address
	function getUser(address i) external view returns(Person) {
		require(Users[i].exists() == true, "This user does not exist");
		return Users[i];
	}

	// Gets the list of addresses on the network
	function getAddresses() external view returns(address[] memory) {
		return addresses;
	}

	function getUserBalance(address i) external view returns(uint) {
		require(Users[i].exists() == true, "This user does not exist");
		return Users[i].balance();
	}

	function getUserID(address i) external view returns(address) {
		require(Users[i].exists() == true, "This user does not exist");
		return Users[i].ID();
	}
}
