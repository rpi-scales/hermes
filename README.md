# Hermes

Back in the time of ancient Greece, it was a common occurrence for traders to sacrifice to the god of trade, Hermes because they believed it would increase the likelihood their good would make it to buyers. In a sense, they were putting some of their trust in Hermes. While traders no longer sacrifice to Hermes, distributed ledger technology has provided a medium in which two mutually untrusting parties can engage in non-repudiable transactions. Unfortunately, Hermes is also the god of trickery and would often steal and trick the other gods. Therefore Hermes is the best title of an asset recovery protocol that is focused around security.

For our research, we have designed and implemented an asset recovery protocol for the Ethereum blockchain networks. To start our protocol the owner of a lost account must create a new account and create an asset recovery proposal. After paying for the proposal, the new account will indicate accounts that they remember having traded with their lost account. Our system then goes through and makes sure that each of these accounts is, in fact, trade partners with the lost account. After checking these trade partners, the system randomly finds several other trade partners from the public records. The new account will then have to provide transaction data for each of their indicated trade partners as well as the randomly selected trade partners. As soon as the new account has created at least one transaction data set for each voter, trade partners will weigh in on the genuineness of this proposal. To do this, they may view the transaction data provided by the new account and compare it to their recollection of the transactions. After a majority of voters have responded and a designated amount of time has passed, the new account can conclude the vote. The votes will then be tallied, and if the vote was successful, then the balance of the lost account will be transferred to the new account. No matter the outcome of the vote, the original price of the asset recover procedure will be broken up and given to the voters as a reward. 

Documentation for Truffle and Ganche: https://www.trufflesuite.com/docs

Documentation for Solidity: https://solidity.readthedocs.io/en/v0.5.11/index.html
