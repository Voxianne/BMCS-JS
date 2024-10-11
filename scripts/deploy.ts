const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log('Deploying contracts with the account: ' + deployer.address);

    // Deploy UserInformation
    const First = await ethers.getContractFactory('UserInformation');
    const first = await First.deploy();
    await first.waitForDeployment();
    console.log( "First: ",await first.getAddress());

    // Deploy Task_Initialization
    const Second = await ethers.getContractFactory('Task_Initialization');
    const second = await Second.deploy();
    await second.waitForDeployment();
    console.log( "Second: ", await second.getAddress() ); 

    // Deploy Task_Selection_Process
    const Third = await ethers.getContractFactory('Task_Selection_Process');
    const third = await Third.deploy();
    await third.waitForDeployment();
    console.log( "Third: ", await third.getAddress())
   
    // Deploy Reward_penalty_System
    const Fourth = await ethers.getContractFactory('Reward_Penalty_System');
    const fourth = await Fourth.deploy();
    await fourth.waitForDeployment();
    console.log( "Fourth: ", await fourth.getAddress());

}

main()
    .then(() => process.exit())
    .catch(error => {
        console.error(error);
        process.exit(1);
})