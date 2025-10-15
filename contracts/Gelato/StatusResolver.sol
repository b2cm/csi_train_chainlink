pragma solidity ^0.8.0;

import "./IStatusContract.sol";

contract StatusResolver {

    IStatusContract public statusContract;

    uint256 public constant OFFSET = 5 minutes;


    constructor(address _addressStatusContract) {
        statusContract = IStatusContract(_addressStatusContract);
    }

    function checker() external view returns (bool canExec, bytes memory execPayload) {
        uint256 timestamp = roundOffOffset(block.timestamp);
        canExec = statusContract.getScheduleLength(timestamp) > 0;
        execPayload = abi.encodeWithSelector (
            IStatusContract.performUpkeep.selector,
            abi.encode(timestamp)
        );
        return (canExec, execPayload);
    } 

    // round off a timestamp to a timestamp that is in the schedule map
    function roundOffOffset(uint256 _time) public pure returns(uint256) {
        return _time - (_time % OFFSET);
    }
}