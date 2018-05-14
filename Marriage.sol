pragma solidity ^0.4.23;

/**
 * This contract is a love contract, we will offer marriage 
 and accept it or rejected on the ethereum blockchain.
 @autor: magonicolas
 */
contract Marriage {

	struct Marriage {
		uint id;
		string agreements;
		uint256 proposalDate;
		uint256 answeredDate;
		uint256 endedDate;
		address proposer;
		address proposed;
		bool accepted;
		bool ended;
	}

	event MarriageStatus(string _msg, address _proposer, address _proposed, bool _accepted, uint256 _date);

	mapping (uint => Marriage) public marriages;

	function Marriage () {
		
	}	

	function proposeMarriage(uint _id, string _agreements, address _proposed) payable {
		
		Marriage memory _marriage = Marriage({
			id: _id,
			agreements: _agreements,
			proposalDate: block.timestamp,
			answeredDate: 0,
			endedDate: 0,
			proposer: msg.sender,
			proposed: _proposed,
			accepted: false,
			ended: false
		});
		marriages[_id] = _marriage;
	}

	function answerMarriage(uint _id, bool _accept) {
		Marriage storage _marriage = marriages[_id];

		require (_marriage.proposed == msg.sender);

		_marriage.accepted = _accept;
		_marriage.answeredDate = block.timestamp;
		MarriageStatus('User has answered to Marriage proposal', _marriage.proposer, msg.sender, _accept, block.timestamp);
	}

	function endMarriage(uint _id) {
		Marriage storage _marriage = marriages[_id];

		require (_marriage.proposed == msg.sender || _marriage.proposer == msg.sender);

		_marriage.ended = true;
		_marriage.endedDate = block.timestamp;
	}
}
