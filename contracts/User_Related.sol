// SPDX-License-Identifier: Unlicense
pragma solidity >=0.7.0 <0.9.0;

contract UserInformation {

    enum User_Type { Worker, Requester }

    struct User_Registration {
        uint256 u_id;
        string full_name;
        address user_address;
        uint zone;
        uint cancelled_tasks;
        uint completed_tasks;
        uint limit_tasks;
        uint reputation;
    }

    uint256[] public u_ids;
    mapping(uint256 => User_Registration) public users;
    mapping(address => uint256) public userAddressToId;  // New mapping from address to user ID

    event User_Created(address user_address, string full_name);

    function Set_User_ID() public view returns(uint) {
        return u_ids.length;
    }

    function setUser_Information(string memory _full_name) public {
        uint256 user_ID = Set_User_ID();

        // Set user's information
        users[user_ID] = User_Registration({
            u_id: user_ID,
            user_address: msg.sender,
            full_name: _full_name,
            zone: Fetch_and_Set_Timezone(),
            cancelled_tasks: 0,
            completed_tasks: 0,
            limit_tasks: 3,  // Default task limit for reputation 50
            reputation: 50   // Default reputation
        });

        u_ids.push(user_ID);  // Store the new user ID
        userAddressToId[msg.sender] = user_ID;  // Map address to user ID

        emit User_Created(msg.sender, _full_name);  // Emit event
    }

    function Return_S(uint user_id) public view returns(User_Registration memory) {
        if (user_id < u_ids.length) {
            return users[user_id];
        } else {
            revert("User not found");
        }
    }

    function Arrange_Limit(uint256 user_ID) public returns (uint) {
        if (users[user_ID].reputation < 30) {
            delete users[user_ID];  // Remove user if reputation is too low
        } else if (users[user_ID].reputation >= 30 && users[user_ID].reputation < 50) {
            users[user_ID].limit_tasks = 1;
        } else if (users[user_ID].reputation >= 50 && users[user_ID].reputation < 70) {
            users[user_ID].limit_tasks = 3;
        } else if (users[user_ID].reputation >= 70 && users[user_ID].reputation < 90) {
            users[user_ID].limit_tasks = 5;
        } else {
            users[user_ID].limit_tasks = 7;
        }
        return users[user_ID].limit_tasks;
    }

    function Fetch_and_Set_Timezone() public view returns(uint32) {
        return uint32(block.timestamp);
    }
}