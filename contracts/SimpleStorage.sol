// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//contract is equivalent to class
// contract SimpleStoreage {
// //defining variable in contract
// //this is used in entire contract
//   uint256 public favNumber;
  
// //user define data-type
//   struct People_struct {
// //
//     uint256 favnumber;
// //in solidity strings are basically arrays
//     string name;
//   }
// //creating an Array of data-type People_struct
// //with variable people_arr
//   People_struct[] public people_arr;
  
// //mapping is datastructure to map key value
//   mapping(string => uint256) public nameToFavnumber;
  
// //function to store favNumber 
//   function store(uint256 _favNumber) public {
//     favNumber = _favNumber;
//   }

// //funtion to retrieve data
//   function reterivee() public view returns(uint256){
//     return favNumber;
//   }
// //function to append people_arr by values of 
// //data-type People_struct
//   function addPerson(string memory _name, uint256 _favNumber ) public {

// //memory: data will only be stored during the execution of the function
// //stroage: data will be store even after execution
//     people_arr.push(People_struct({favnumber:_favNumber,name: _name}));
// //using mapping function to map name with favNumber
//     nameToFavnumber[_name] = _favNumber;
//   }

// }


contract SimpleStorage {
    
    // this will get initialized to 0!
    uint256 favoriteNumber;
    bool favoriteBool;
    
    struct People {
        uint256 favoriteNumber;
        string name;
    }
    
    People[] public people;
    mapping(string => uint256) public nameToFavoriteNumber;
    
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }
    
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }
    
    function addPerson(string memory _name, uint256 _favoriteNumber) public{
        people.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }    
    
}