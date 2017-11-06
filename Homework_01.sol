pragma solidity ^0.4.11;

contract Homework_01 {

	uint256 public number;
	uint256 public limitEtherNum;
	string public message;
	
	uint256 public blockingTimestamp;
	uint256 public periodInMinutes;
	
	function Homework_01(uint256 _limitEtherNum) {
		limitEtherNum = _limitEtherNum;
	}

	// Level 1 function
	function setNumber(uint256 _number) {
		number = _number;
	}
	
	// Level 2 function
	function setNumberForAPrice(uint256 _number) payable {
		if (msg.value >= limitEtherNum * 1 ether) {
			setNumber(_number);
		} else {
			msg.sender.transfer(msg.value);
		}
	}
	
	// Level 3 function
	function setMessageForAPriceAndTransfer(string _message, address _to) payable {
		if (msg.value >= limitEtherNum * 1 ether) {
			message = _message;
			_to.transfer(msg.value);
		} else {
			msg.sender.transfer(msg.value);
		}
	}
	
	// Level 4 function
	function setMessageForAPriceAndTransferAndBlockMessageChange(string _message, address _to, uint256 _periodInMinutes) payable {
		if (msg.value >= limitEtherNum * 1 ether) {
			if (blockingTimestamp == 0 || ((now - blockingTimestamp) >= _periodInMinutes * 1 minutes)) {
				message = _message;
				_to.transfer(msg.value);
				
				periodInMinutes = _periodInMinutes;
				blockingTimestamp = now;
			} else {
				msg.sender.transfer(msg.value);
			}
		} else {
			msg.sender.transfer(msg.value);
		}
	}
	
}