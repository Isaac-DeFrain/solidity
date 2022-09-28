# Global Variables in Solidity

There are many [special variables](./special_variables.md) in Solidity

```solidity
contract GlobalVariables {
  function globalVar() external view returns (address, uint, uint) {
    address sender = msg.sender;
    uint timestamp = block.timestamp;
    unit blockNum = block.number;
    return (sender, timestamp, blockNum);
  }
}
```

TODO
