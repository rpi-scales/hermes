/* Person.sol */

pragma solidity >=0.4.0 <0.7.0;

/* <Summary> 
	This contract repersents a user on the network
*/

contract Person {
	address public ID;			// The address of the user
	uint public balance;		// The balance of that user
	uint public vetoTime;		// Time required before this account can be recovered

	constructor(address _ID, uint _balance, uint _vetoTime) public {
		ID = _ID;
		balance = _balance;
		vetoTime = _vetoTime;
	}

	// Increase the balance of the user
	function increaseBalance(uint amount) external {
		balance += amount;
	}

	// Decrease the balance of the user
	function decreaseBalance(uint amount) external {
		balance -= amount;
	}

	// Change the time desinated to vetoing
	function setVetoTime(uint time) external {
		vetoTime = time;
	}
}