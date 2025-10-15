pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";
import "@chainlink/contracts/src/v0.8/ConfirmedOwner.sol";

contract ProxyProbabilityTest is ChainlinkClient, ConfirmedOwner {

    using Chainlink for Chainlink.Request;

    uint256 constant private ORACLE_PAYMENT = 0; // 0 LINK for testing
    uint public probabilityDelay;


    event RequestProbabilityDelayFulfilled(
        bytes32 indexed requestId,
        uint256 indexed probabilityDelay
    );


    constructor() ConfirmedOwner(msg.sender){
        setPublicChainlinkToken();
    }

    function requestProbabilityDelay(address _oracle, string memory _jobId, string memory _encoded)
        public
        onlyOwner
    {
        Chainlink.Request memory req = buildChainlinkRequest(stringToBytes32(_jobId), address(this), this.fulfillProbabilityDelay.selector);
        req.add("encoded", _encoded);
        sendChainlinkRequestTo(_oracle, req, ORACLE_PAYMENT);
    }


    function fulfillProbabilityDelay(bytes32 _requestId, uint256 _probabilityDelay)
        public
        recordChainlinkFulfillment(_requestId)
    {
        emit RequestProbabilityDelayFulfilled(_requestId, _probabilityDelay);
        probabilityDelay = _probabilityDelay;
    }

    function getChainlinkToken() public view returns (address) {
        return chainlinkTokenAddress();
    }

    function withdrawLink() public onlyOwner {
        LinkTokenInterface link = LinkTokenInterface(chainlinkTokenAddress());
        require(link.transfer(msg.sender, link.balanceOf(address(this))), "Unable to transfer");
    }

    function cancelRequest(
        bytes32 _requestId,
        uint256 _payment,
        bytes4 _callbackFunctionId,
        uint256 _expiration
    ) public onlyOwner {
        cancelChainlinkRequest(
            _requestId,
            _payment,
            _callbackFunctionId,
            _expiration
        );
    }

    function stringToBytes32(string memory source)
        private
        pure
        returns (bytes32 result)
    {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            // solhint-disable-line no-inline-assembly
            result := mload(add(source, 32))
        }
    }
}