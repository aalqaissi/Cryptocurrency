const HDWalletProvider = require('truffle-hdwallet-provider');

const Web3 = require('web3');
const { interface, bytecode } = require('./compile');

const provider = new HDWalletProvider(
  'mystery cross dwarf expire curve able dilemma cost drink fire essence mix',
  'https://rinkeby.infura.io/v3/21eeedb81aa642c1a39fcb2bf4d357a4'
);
const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();
  console.log('Attempting to deploy from account', accounts[0]); // address of the deployer

  const result = await new web3.eth.Contract(JSON.parse(interface))
  .deploy({ data: '0x' + bytecode, arguments:['100', 'BCCoint','2','BCC','1']})
  .send({ gas: '1000000', from: accounts[0] });

  console.log('Contract deployed to', result.options.address); //address of the deployed contract
};
deploy();
