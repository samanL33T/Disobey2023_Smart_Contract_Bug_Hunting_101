# Lab 03 - Static Analysis

## Learning Objectives
-------------------
- Manual Code Reviews
- Slither & solhint for static code analysis


### Solhint
1. Install solhint using following command:
```bash
$ sudo npm install -g solhint
$ solhint --version #To check the successfull installation
```

2. Initialize/create the solhint configuration file:
```bash
$ solhint init
```

3. Update the configuration file - `.solhint.json` with following rules:
```bash
{
  "extends": "solhint:recommended",
  "rules": {
    "func-visibility": ["warn",{"ignoreConstructors":true}],
    "avoid-suicide": "error",
    "avoid-sha3": "warn",
    "state-visibility":"warn"
  }
}
```

4. Run solhint on our existing solidity files:

```bash
$ cd contracts/Challenge/
$ solhint '*.sol'
```

Following output shows the identified styling and security errors:

```bash
$ solhint '*.sol'

BugMeOut.sol
   2:1   error    Compiler version ^0.8.0 does not satisfy the ^0.5.8 semver requirement  compiler-version
  14:9   warning  Error message for require is too long                                   reason-string
  26:24  warning  Avoid to use low level calls                                            avoid-low-level-calls
  38:24  warning  Avoid to use low level calls                                            avoid-low-level-calls

✖ 4 problems (1 error, 3 warnings)
```

### Slither
1. Run slither in it's default setting on our existing solidity files:
```bash
$ cd contracts/Challenge
$ slither .

#Output

Reentrancy in BugMeOut.withdrawFunds(uint256) (BugMeOut.sol#24-29):
        External calls:
        - (sent) = msg.sender.call{value: amount}() (BugMeOut.sol#26)
        State variables written after the call(s):
        - balances[msg.sender] -= amount (BugMeOut.sol#28)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities

BugMeOut.changeOwner(address).newOwner (BugMeOut.sol#31) lacks a zero-check on :
                - owner = newOwner (BugMeOut.sol#32)
BugMeOut.transferFunds(address,uint256).recipient (BugMeOut.sol#35) lacks a zero-check on :
                - (sent) = recipient.call{value: amount}() (BugMeOut.sol#38)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-zero-address-validation

Pragma version^0.8.0 (BugMeOut.sol#2) allows old versions
solc-0.8.14 is not recommended for deployment
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
.......

......

Modifier BugMeOut.OnlyOwner() (BugMeOut.sol#13-16) is not in mixedCase
......
```