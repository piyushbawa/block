// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract voting {
    address public owner;
    address[] public candidates;
    mapping(address => uint) public votes;
    address public winner;
    uint public winVotes;
    uint flag = 0;

    constructor() {
        owner = msg.sender;
    }

    modifier OnlyOwner() {
        require(msg.sender == owner);
        _;
    }

    enum votingStatus {NotStarted, GoingOn, Finished}
    votingStatus public status;

    function setStatus() public OnlyOwner{
        if(status == votingStatus.NotStarted){
            status = votingStatus.GoingOn;
        }
        if(flag == 1){
            if(status == votingStatus.GoingOn){
                status = votingStatus.Finished;
            }
        }
        flag = 1;
    }

    function addcandidate(address _candi) public OnlyOwner {
        candidates.push(_candi);
    }

    function getVotes(address _candi) public {
        require(checkCandidate(_candi), "Candidate Not Valid");
        require(status == votingStatus.GoingOn, "Voting Not Started or Finished");
        votes[candi] = votes[candi] + 1;
    }

    function checkCandidate(address candi) view public returns(bool) {
        for (uint i = 0; i < candidates.length; i++){
            if(candidates[i] == candi){
                return true;
            }
        }
        return false;
    }

    function voteCount(address candi) public view returns(uint){
        require(checkCandidate(candi), "Candidate not valid");
        return votes[candi];
    }

    function result() public {
        require(status == votingStatus.Finished, "Voting Not Finished");
        for(uint i = 0; i < candidates.length; i++)
        {
            if(votes[candidates[i]] > winVotes){
                winVotes = votes[candidates[i]];
                winner = candidates[i];
            }
        }
    }
}
