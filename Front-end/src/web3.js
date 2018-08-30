import Web3 from 'web3';

const web3  = new Web3(window.web3.currentProvider);
// const web3  = new Web3(new Web3.providers.HttpProvider("https://rinkeby.infura.io/v3/21eeedb81aa642c1a39fcb2bf4d357a4"));
export default web3;