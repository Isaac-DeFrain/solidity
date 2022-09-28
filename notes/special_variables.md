# Special Variables

## Block Properties

| method call | return type | semantics |
|:---|:---:|:---|
| `now` | `uint` | Current block timestamp (alias for block.timestamp) |
| `block.difficulty` | `uint` |	Current block difficulty |
| `block.gaslimit` | `uint` | Current block gas limit |
| `blockhash(uint)` | `bytes32` |	Gives hash of the block with given number; only works for 256 most recent blocks |
| `block.number` | `uint` |	Current block number |
| `block.timestamp` | `uint` | Current block timestamp as seconds since unix epoch |

## Transaction Properties

| method call | return type | semantics |
|:---|:---:|:---|
| `msg.data` | `bytes` `calldata` |	Complete calldata |
| `msg.sender` | `address` `payable` | Sender of the message (current call) |
| `msg.sig` | `bytes4` | First four bytes of the calldata (i.e. function identifier) |
| `msg.value` | `uint` | Amount of Wei sent with the message |
| `gasleft()` | `uint` |	Remaining gas |
| `tx.gasprice` | `uint` | Gas price of the transaction |
| `tx.origin` | `address` `payable` | Sender of the transaction (full call chain) |

## ABI encoding

| method / description | return type | semantics |
|:---|:---:|:---|
| `abi.decode(bytes memory encodedData, (...))` | `(...)` | Decodes the given data, types are given in parentheses as the second argument |
| `abi.encode(...)` | `bytes` `memory` | Encodes the given arguments |
| `abi.encodePacked(...)` | `bytes` `memory` | Performs packed encoding of the arguments |
| `abi.encodeWithSelector(bytes4 selector, ...)` | `bytes` `memory` | Encodes the given arguments starting from the second and prepends the given four-byte `selector` |
| `abi.encodeWithSignature(string memory signature, ...)` | `bytes` `memory` | Equivalent to `abi.encodeWithSelector(bytes4(keccak256(bytes(signature))), ...)` |
