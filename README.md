# Hermes

<img align="right" src=/Images/New_System_Flowchart.png width="300">

Back in the time of the ancient Greeks, it was a common occurrence for traders to sacrifice to the god of trade, Hermes because they believed it would increase the likelihood their good would make it to buyers. In a sense, they were putting their trust in Hermes. While traders no longer sacrifice to Hermes, distributed ledger technology has provided a medium in which two mutually untrusting parties can engage in non-repudiable transactions. Unfortunately, Hermes is also the god of trickery and would often steal and trick the other gods. Therefore Hermes is the best title of an asset recovery protocol that is focused around security.

## Our Research

For our research, we have designed and implemented an asset recovery protocol for the Ethereum blockchain networks. To start our protocol the owner of a lost account must create a new account and create an asset recovery proposal. After paying for the proposal, the new account will indicate accounts that they remember having traded with their lost account. Our system then goes through and makes sure that each of these accounts is, in fact, trade partners with the lost account. After checking these trade partners, the system randomly finds several other trade partners from the public records. The new account will then have to provide transaction data for each of their indicated trade partners as well as the randomly selected trade partners. As soon as the new account has created at least one transaction data set for each voter, trade partners will weigh in on the genuineness of this proposal. To do this, they may view the transaction data provided by the new account and compare it to their recollection of the transactions. After a majority of voters have responded and a designated amount of time has passed, the new account can conclude the vote. The votes will then be tallied, and if the vote was successful, then the balance of the lost account will be transferred to the new account. No matter the outcome of the vote, the original price of the asset recover procedure will be broken up and given to the voters as a reward. 

<img align="right" src=/Images/Sequence_Diagram.png width="400">


When designing our new system, we focused mainly on defending against different attack vectors that could abuse the weaknesses of other systems. Most notably we worked to limit our protocol's vulnerability to bribery and spam. To clamp down on bribery, our system selects extra voters at random to offset the number of indicated voters. Without enough randomly selected voters, then a majority of indicated voters could be bribed by an attacker. We limited spam proposals by making the asset recovery processes more tedious to complete. We want to make the process tedious enough to discourage spam attempts while not making it too tedious that it is agitating to complete for a genuine user. To do this, our system fact checks all public data provided by the new account.

To encourage users to vote, we reward voters for participating and for voting correctly (a.k.a. votes the same as the majority). On top of these two factors, voters will also be rewarded based on how long they took to vote compared to the average voter. In the end, we are looking to promote genuine votes that are placed promptly.


## Implementation

<img align="left" src=/Images/Contract_Flowchart.png width="500">

For our research, we developed and tested on the Ethereum network. Due to Ethereum's smart contracts, we were able to make our new system much easier to use for our users. Given smart contracts' greater scalability, privacy, and programmability, Ethereum was the best network for our research and future iterations of this research. For our implementation, we used a hierarchy of smart contracts and libraries for our system. At the top of the hierarchy, 3 manager smart contracts manage the overall network: UserManager.sol, TransactionManager.sol, and ProposalManager.sol. UserManager.sol manages the users on the network while TransactionManager.sol manages the making and recording of transactions and ProposalManager.sol manages all active asset recovery proposals. To create and manage asset recovery proposals these 3 manager contracts call functions from the ProposalCreator.sol and Proposal.sol files. ProposalCreator.sol is used to create the proposals and add voters while Proposal.sol is used to represent the actual proposal. On the lowest level of the hierarchy, there are 2 smart contracts (Person.sol, Transaction.sol) and 2 libraries (VotingToken.sol, TransactionDataSet.sol). Person.sol and Transaction.sol are used to represent users and transactions on the network respectively. VotingToken.sol is used to keep track of votes while TransactionDataSet.sol is used to keep track of provided public and private transaction data. In the end, all of these files work together to manage the network.

## Running

To test our protocol you must first install [Truffle](https://www.trufflesuite.com/docs/truffle/getting-started/installation) and [Ganache](https://www.trufflesuite.com/ganache). After uploading our project into Ganache you can test our protocol by using the $ truffle test command from a command line. This will run through three test files that simulate successful usage of our protocol and one test file that simulates misusage of our protocol.

