pragma solidity ^0.8.7;

contract CronTest {

    bytes32 public currentPrice; 

    // this function is called by the chainlink cron job (see: jobs - CronTest.toml)
    function someFunction(bytes32 _price) public {
        currentPrice = _price;
    }
}