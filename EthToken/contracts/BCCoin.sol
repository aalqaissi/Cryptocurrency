pragma solidity ^0.4.21;
import "Interface.sol";            // change this line
contract BCCoin is Interface {
    uint256 constant private MAX_UINT256 = 2**256 - 1;
    // declare balances variable here
    mapping (address => mapping (address => uint256)) public allowed;
   
    string public name;                   //fancy name: eg Simon Bucks
    uint8 public decimals;                //How many decimals to show.
    string public symbol;                 //An identifier: eg SBX
    uint8 public tokenValue;              //token value in ethers
    address public Owner;                 //address account who deplyed the contract      
     
    mapping (address => uint256) public balances;
    
    constructor (
        uint256 _initialAmount,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol,
        uint8 _tokenValue
    ) public {
        Owner = msg.sender;
        name = _tokenName;
        decimals = _decimalUnits;
        symbol = _tokenSymbol;
        tokenValue = _tokenValue;
        balances [Owner] = _initialAmount;      
    }
    function transfer(address _to, uint256 _value) public  {
        balances [msg.sender] = balances [msg.sender] - _value;
        balances [_to] = balances [_to] + _value;
        Transfer(msg.sender, _to, _value);
    }
    function transferFrom(address _from, address _to, uint256 _value) public  {
        uint256 allowance = allowed[_from][msg.sender];
        balances [_from] = balances [_from] - _value;
        balances [_to] = balances [_to] + _value;
        Transfer(_from, _to, _value);
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }
     
    }    
   
    function approve(address _spender, uint256 _value) public  {
        allowed[msg.sender][_spender] = _value;
        Approval(msg.sender, _spender, _value);
    }
    function getBalance() public constant returns (uint256 balance) {
        balance = msg.sender.balance;
        return balance;
    }
    function getTokens() public payable {
        require(msg.value > 0);
        require(msg.sender != address(0));
        uint256 token = msg.value / tokenValue;
        balances[Owner] -= token;
        balances[msg.sender] += token;
    }  
    function getEthers(uint256 tokens) public
    {
        uint256 ethers = tokens * tokenValue;
        balances[Owner] += tokens;
        balances[msg.sender] -= tokens;
        msg.sender.transfer(ethers);
    }
}