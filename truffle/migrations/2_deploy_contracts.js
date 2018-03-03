var ConvertLib = artifacts.require("./ConvertLib.sol");
var MetaCoin = artifacts.require("./MetaCoin.sol");
var TruekenERC20Proxy = artifacts.require("./TruekenERC20Proxy.sol");
var TruekenERC20BitDegree = artifacts.require("./TruekenERC20.sol");
var TruekenERC20FidentiaX = artifacts.require("./TruekenERC20.sol");

var BitDegreeToken = artifacts.require("./BitDegreeToken.sol");
var FidentiaXToken = artifacts.require("./FidentiaXToken.sol")




module.exports = function(deployer) {
  //deployer.deploy(ConvertLib);
  //deployer.link(ConvertLib, MetaCoin);
  //deployer.deploy(MetaCoin);
  //BitDegree
  //deployer.link(TruekenERC20Proxy, TruekenERC20BitDegree);
  //deployer.deploy(TruekenERC20BitDegree, "0xf4e2c0bb35a767fcadaa0830c5ff34107a0f61ec");
  //FidentiaX
  //deployer.link(TruekenERC20Proxy, TruekenERC20FidentiaX);
  //deployer.deploy(TruekenERC20FidentiaX, "0xf1f2ff08c674ac0c0f61bb2c055a62113a894fea");
	
	
	contratoBDG = '0x9c1e398dfbd4dd8dec34e86d7fa0fe796bd3ea7c';
	contratoFDX = '0xf1f2ff08c674ac0c0f61bb2c055a62113a894fea';
	
	//deploys
	trueke = TruekenERC20Proxy.deployed()
	bit = BitDegreeToken.deployed()
	fdx = FidentiaXToken.deployed()
	
	//cargar BDGs a Alice
	bit.then(instance => {return instance.transfer(web3.eth.accounts[1], web3.toWei(1000))})
	
	

};
