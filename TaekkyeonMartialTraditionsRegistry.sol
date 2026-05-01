// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract TaekkyeonMartialTraditionsRegistry {

    struct TaekkyeonTradition {
        string styleName;           // gyeongdang, hwalgaejil, etc.
        string techniques;          // kicks, sweeps, pumbalki, circular motions
        string footwork;            // pumbalki stepping patterns
        string region;              // Seoul, Jeolla, Gyeonggi
        string culturalContext;     // festivals, competitions, rituals
        string historicalNotes;     // suppression, revival, lineage
        string uniqueness;          // UNESCO status, fluidity, rhythm
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct TaekkyeonInput {
        string styleName;
        string techniques;
        string footwork;
        string region;
        string culturalContext;
        string historicalNotes;
        string uniqueness;
    }

    TaekkyeonTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event TaekkyeonRecorded(uint256 indexed id, string styleName, address indexed creator);
    event TaekkyeonVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            TaekkyeonTradition({
                styleName: "Example (replace manually)",
                techniques: "example",
                footwork: "example",
                region: "example",
                culturalContext: "example",
                historicalNotes: "example",
                uniqueness: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordTaekkyeon(TaekkyeonInput calldata t) external {
        traditions.push(
            TaekkyeonTradition({
                styleName: t.styleName,
                techniques: t.techniques,
                footwork: t.footwork,
                region: t.region,
                culturalContext: t.culturalContext,
                historicalNotes: t.historicalNotes,
                uniqueness: t.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit TaekkyeonRecorded(traditions.length - 1, t.styleName, msg.sender);
    }

    function voteTaekkyeon(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        TaekkyeonTradition storage t = traditions[id];

        if (like) t.likes++;
        else t.dislikes++;

        emit TaekkyeonVoted(id, like, t.likes, t.dislikes);
    }

    function totalTaekkyeon() external view returns (uint256) {
        return traditions.length;
    }
}
