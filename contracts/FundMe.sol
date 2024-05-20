// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'bloackchain/contracts/AggregatorV4Interface.sol';

contract FundMe {

//mapping address of send to value they send to keep track
  mapping (address=>uint256) public addressToAmountFunded;
  address[] public funders;
  address public owner;
  constructor() public {
    owner = msg.sender;
  }

//payable function to pay value
  function fund() public payable {
//setting Minimum USD value
  uint256 minimumUSD = 50 * 10;
  require(getPriceInUSD(msg.value) >= minimumUSD, 'you need to spend more ETH');
//keywords of function
//msg.sender is address of sender of the function call
//msg.value is valuethat they send
    addressToAmountFunded[msg.sender] += msg.value;
    funders.push(msg.sender);
  }
//converting ETH --> USD
//Getting External Data with chainlink
/* in order to convert ETH to USD we need to know current conversion rate
blockcahins can not be connect with real world events like data feeds, APIs, existing payment system so in order to get this data we use Oravle which are intend to interact with the off-chain world to provide external data or computaion to smart contracts
Oravle should not becentralise (no single enity to handle these tasks)
Chainlink are decentralise oracle network better at this tasks */


  function getVersion () public view returns (uint256){
//here we are deploying this contract on real blockchain of rinckeby
//below line states that we have a contract name AggregatorV3Interface having some functions locateed at address in paranthesis
    AggregatorV4Interface get_version = AggregatorV4Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
//Calling method 'getVersion' with [] from fundMe contract at contract AggregatorV4Interface by its obj get_version
    return get_version.version();
  }

//function to get price of 1 ethereum in USD
//current ether price is USD $119110000000
  function get_ConversionRAte () public view returns (uint256){
      AggregatorV4Interface get_conversionRAte = AggregatorV4Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
      (,int256 answer,,,) = get_conversionRAte.latestRoundData();
      return uint256(answer);
    }
//1 ETH = 1000000000 gwei
//function to get (price in USD) of (ethAmount ethereum) that user funded 
  function getPriceInUSD(uint256 ethAmount) public view returns(uint256) {
//converting Eth ethAmount --> USD ethAmountInUSD 
    uint256 ethPrice = get_ConversionRAte();
    uint256 ethAmountInUSD = (ethPrice * ethAmount); //ethAmount = 1000000000
  //ethAmountInUSD = 119110000000 * 1000000000(1ETH) = 119110000000000000000
    return ethAmountInUSD;
  }

//Modifiers are used to change the behavior of a function in a declarative way.
//only owner has privilageto withdraw Amount
  modifier onlyOwner {
      require(msg.sender == owner);
      _;
    }
  function withdraw() payable public {
//transfering all the money to user who called this function by getting the adress of this(current) contract also balancing their account (withdraw)
    payable(msg.sender).transfer(address(this).balance);
    for(uint256 funderIndex=0; funderIndex < funders.length; funderIndex++){
      address funder = funders[funderIndex];
      addressToAmountFunded[funder] = 0;
    }
    funders = new address[](0);
  }
}
