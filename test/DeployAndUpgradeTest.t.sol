// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgradeTest is Test {
    DeployBox public deployer;
    UpgradeBox public upgrader;
    address public OWNER = makeAddr("OWNER");

    address public proxy;
    BoxV2 public boxV2;

    function setUp() public {
        deployer = new DeployBox();
        upgrader = new UpgradeBox();
        proxy = deployer.run(); //* Points to BoxV1 for now.
    }

    function testRevertsWhenImplementationIsNotCorrect() public {
        vm.expectRevert();
        BoxV2(proxy).setNumber(7);
    }

    function testProxyStartsAsBoxV1() public {
        uint256 expectedValue = 1;
        assertEq(expectedValue, BoxV1(proxy).version());
    }

    function testUpgrades(uint256 _number) public {
        boxV2 = new BoxV2();
        upgrader.upgradeBox(proxy, address(boxV2));
        uint256 expectedValue = 2;
        BoxV2(proxy).setNumber(_number);
        assertEq(expectedValue, BoxV2(proxy).version());
        assertEq(_number, BoxV2(proxy).getNumber());
    }
}