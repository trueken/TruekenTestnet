var Migrations = artifacts.require("./Migrations.sol");
var Geekt = artifacts.require("./Geekt.sol");
var BitDegree = artifacts.require("./BitDegreeToken.sol");
var TruekenERC20Proxy = artifacts.require("./TruekenERC20Proxy.sol");
var FidentiaXToken = artifacts.require("./FidentiaXToken.sol")
var TruekenERC20 = artifacts.require("./TruekenERC20.sol");

var proxyAddress = '0x9c1e398dfbd4dd8dec34e86d7fa0fe796bd3ea7c';
var bitDegreeContract = '0xf79b0c90bd9e5fc60d8d7a11f69f718ebb02d837';

module.exports = function(deployer) {
  //deployer.deploy(Migrations);
  //deployer.deploy(Geekt);
  deployer.deploy(BitDegree);
  //proxy trueken
  deployer.deploy(TruekenERC20Proxy, bitDegreeContract);
  
  deployer.deploy(FidentiaXToken);
  //BitDegree
  //deployer.deploy(TruekenERC20, "0xf79b0c90bd9e5fc60d8d7a11f69f718ebb02d837", proxyAddress);
  //FidentiaX
  //deployer.link(TruekenERC20Proxy, TruekenERC20FidentiaX);
  //deployer.deploy(TruekenERC20, "0xf4e2c0bb35a767fcadaa0830c5ff34107a0f61ec", proxyAddress);
};
