// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import 'bloackchain/contracts/SimpleStorage.sol'; 

contract StorageFactory { 
/* In this contract variables are: Simple_Storage_var, store_var
functions are: createSimpleStorageContract, SFstore
Inputs are: _simpleStorageIndex, _simpleStorageNumber
parameters are: Simple_Storage_var (object), SimpleStorage_arr, _simpleStorageIndex 
EVERYTIME  WE HAVE TO FIRST RUN 'CREATESIMPLESTORAGECONTRACT' */

//Creating an Array of data-type SimpleStorage(previous contract)
  SimpleStorage[] public SimpleStorage_arr;

//Creating function to Append SimpleStorage_arr
  function createSimpleStorageContract() public {
//creating first variable (object) Simple_Storage_var of type (SimpleStorage contract) to create its own Simple Storage contract 
//using this variable Simple_Storage_var for calling simpleStorage contract
    SimpleStorage Simple_Storage_var = new SimpleStorage();//no parameters

//Appending SimpleStorage_arr with Simple_Storage_var (object)
    SimpleStorage_arr.push(Simple_Storage_var);
  }

//SF_store: StorageFactorystore
  function SFstore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public{
//To interact with contract we NEED
//Address which we get from SimpleStorage_arr
//ABI: Application Binary Interface which we get ny importing
//creating second variable store_var of type (SimpleStorage contract)
    SimpleStorage store_var = SimpleStorage(address(SimpleStorage_arr[_simpleStorageIndex])); //passing address and index as parameter
    store_var.store(_simpleStorageNumber);
  }

//Creating SFretrieve function to retrieve the information
  function SFretrieve(uint256 _simpleStorageIndex) public view returns(uint256) {
//Retrieveing the info of contract of Simple_Storage_var (object) in SimpleStorage_arr at index _simpleStorageIndex
    SimpleStorage retrieve_var = SimpleStorage(address(SimpleStorage_arr[_simpleStorageIndex]));
    return retrieve_var.retrieve();
  }
}
//Inheritance
//contract StorageFactory is SimpleStorage{}
//new_contract is (of type) old_contract