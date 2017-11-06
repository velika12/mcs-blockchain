pragma solidity ^0.4.11;

// Changed ERC20Token
contract Homework_02 {

    string public name;
    string public symbol;
    uint8 public decimals;
	
    uint256 public totalSupply;
	
	address creator;
	
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    event Transfer(address from, address to, uint256 value);
    event Approval(address from, address to, uint256 value);
	
	uint256 public number;
	uint256 public limitTokenNum;
	string public message;
	
	uint256 public blockingTimestamp;
	uint256 public periodInMinutes;
	
    function Homework_02(){
        decimals = 8;
        
        totalSupply = 10000000 * (10 ** uint256(decimals));
		
        balanceOf[msg.sender] = totalSupply;
		creator = msg.sender;
		
        name = "MyToken";
        symbol = "MY";
		
		limitTokenNum = 2;
    }
	
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_to != 0x0);
        require(balanceOf[_from] >= _value);
        require(balanceOf[_to] + _value >= balanceOf[_to]);

        balanceOf[_to] += _value;
        balanceOf[_from] -= _value;

        Transfer(_from, _to, _value);
    }
	
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }
	
    function transferFrom(address _from, address _to, uint256 _value) public {
        require(_value <= allowance[_from][_to]);
		
        allowance[_from][_to] -= _value;
        
        _transfer(_from, _to, _value);
    }
	
    function approve(address _to, uint256 _value) {
        allowance[msg.sender][_to] = _value;
		
        Approval(msg.sender, _to, _value);
    }
	
	// Level 1 function
	function setNumber(uint256 _number) {
		number = _number;
	}
	
	// Level 2 function
	function setNumberForTokens(uint256 _number, uint256 _value) {
		require(_value >= limitTokenNum);
		
		setNumber(_number);
		
		approve(creator, _value);
		transferFrom(msg.sender, creator, _value);
	}
	
	// Level 3 function
	function setMessageForTokensAndTransfer(string _message, address _to, uint256 _value) {
		require(_value >= limitTokenNum);
		
		message = _message;
		
		approve(_to, _value);
		transferFrom(msg.sender, _to, _value);
	}
	
	// Level 4 function
	function setMessageForTokensAndTransferAndBlockMessageChange(string _message, address _to, uint256 _value, uint256 _periodInMinutes) {
		require((now - blockingTimestamp) >= (periodInMinutes * 1 minutes));
		
		setMessageForTokensAndTransfer(_message, _to, _value);
		
		periodInMinutes = _periodInMinutes;
		blockingTimestamp = now;
	}
}