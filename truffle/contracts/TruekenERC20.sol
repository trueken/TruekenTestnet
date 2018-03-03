pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "./TruekenERC20Proxy.sol";

contract TruekenERC20 is Ownable{
	
	TruekenERC20Proxy proxy;
	address direccionProxy;
	address misMonedas;
	address propietario;
	/**
	 * @dev constructor
	 */
	function TruekenERC20 (address _misMonedas, address _direccionProxy) public{
		/*
		proxy = Proxy(_direccionProxy);
		
		proxy.setMisMonedas(_misMonedas);
		proxy.setPropietario(owner);
		*/
		direccionProxy = _direccionProxy;
		misMonedas = _misMonedas;
	}
	
	
	function init() private{
		proxy = TruekenERC20Proxy(direccionProxy);
		
		proxy.setMisMonedas(misMonedas);
		proxy.setPropietario(owner);
		
	}
	
	/**
    @dev Fallback function, payable. Calls `buyTokens`
	 */
	function () public payable {
		init();
		proxy.comprarMonedas(msg.sender);
	}
	
	
}
/*
contract TruekenERC20Proxy is Ownable{
	address private misMonedas;
	address private propietario;
	function comprarMonedas(address _beneficiario) public;
	
	function setPropietario(address _propietario) public {
		propietario = _propietario;
	}
	function setMisMonedas(address _misMonedas) public{
		misMonedas = _misMonedas;
	}
}
*/