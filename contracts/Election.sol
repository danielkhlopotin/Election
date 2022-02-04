pragma solidity 0.5.16;

contract Election {
    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;

    uint public candidatesCount;

    function addCandidate (string memory _name) private {
        candidatesCount ++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    constructor () public {
        addCandidate("Jimbo");
        addCandidate("Leeroy Mckibbins");
    }

    mapping(address => bool) public voters;

    event votedEvent (
        uint indexed _candidateId
    );

    // an external account will call this (hence public keyword), which is how we're able to get the voter address (via msg.sender)
    // address gets passed via a second hidden variable { from: accounts[0] }
    function vote (uint _candidateId) public {
        // check that the voter hasn't yet votes and has a valid id before processing their vote
        require(!voters[msg.sender]);
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        voters[msg.sender] = true;

        candidates[_candidateId].voteCount ++;

        emit votedEvent(_candidateId);
    }

    
}
