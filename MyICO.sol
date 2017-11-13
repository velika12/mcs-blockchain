pragma solidity ^0.4.11;

interface MyERC20Token {
	function transfer(address _receiver, uint256 amount);
}

contract MyICO {
	
	MyERC20Token public token;
	
	uint8 public tokenPrice = 10000; // in wei
	
	function MyICO(MyERC20Token _token) {
		token = _token;
	}
	
	function _buy(address _sender, uint256 _amount) internal returns (uint256) {
		uint256 tokensNumber = _amount / tokenPrice;
		token.transfer(_sender, tokensNumber);
		return tokensNumber;
	}
	
	function() payable {
		_buy(msg.sender, msg.value);
	}
	
	function buy() payable returns (uint256) {
		return _buy(msg.sender, msg.value); 
	}
	
}