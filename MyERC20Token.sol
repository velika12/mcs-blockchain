pragma solidity ^0.4.11;

contract MyERC20Token {

	string public name = 'MyERC20Token';
	string public symbol = 'MT';
	uint8 public decimals = 8;
	
	uint256 public totalSupply;
	
	address public owner;
	
	mapping (address => uint256) public balanceOf;
	mapping (address => mapping (address => uint256)) public allowance;
	
	event Transfer(address _from, address _to, uint256 _value);
	event Approval(address _from, address _to, uint256 _value);
	
	string public message;
	uint256 public minCost = 5 * 1 ether;
	
	uint256 public unblockingTimestamp;
	
	function MyERC20Token() {
		owner = msg.sender;
		totalSupply = 10000000 * (10 ** uint256(decimals));
	}
	
	function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != address(0));
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        balanceOf[_to] += _value;
        balanceOf[_from] -= _value;

        Transfer(_from, _to, _value);
    }
	
	function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }
	
	function approve(address _to, uint256 _value) public {
		allowance[msg.sender][_to] = _value;
		Approval(msg.sender, _to, _value);
	}
	
	function setMessageAndBlock(string _message, address _to, uint256 _value, uint256 _minutesToBlock) {
		require(now > unblockingTimestamp);
		require(_value >= minCost);
		
		message = _message;
		
		approve(_to, _value);
		transferFrom(msg.sender, _to, _value);
		
		unblockingTimestamp = now + _minutesToBlock;
	}

}