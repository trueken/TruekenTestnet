pragma solidity ^0.4.18;

import "zeppelin-solidity/contracts/ownership/Ownable.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
//import "zeppelin-solidity/contracts/token/ERC20/ERC20Basic.sol";
//import "zeppelin-solidity/contracts/token/ERC20/BasicToken.sol";
//import "zeppelin-solidity/contracts/token/ERC20/ERC20.sol";
//import "zeppelin-solidity/contracts/token/ERC20/StandardToken.sol";
//import "zeppelin-solidity/contracts/token/ERC20/MintableToken.sol";
//import "zeppelin-solidity/contracts/lifecycle/Pausable.sol";
//import "zeppelin-solidity/contracts/token/ERC20/PausableToken.sol";


contract TruekenERC20Proxy is Ownable{
	using SafeMath for uint256;
	
	/**
	 * Direccion donde esta el contrato que gestiona las monedas que queremos vender
	 */
	address misMonedas;
	 
	/**
	 * cartera del creador de este contrato
	 */
	address propietario;
	
	uint256 rate = 1;
	
	function TruekenERC20Proxy (address _misMonedas) public{
		misMonedas = _misMonedas;
		propietario = owner;
	}
	
	function toWei(uint256 ethers) private returns (uint256 output){
		output = ethers * 10**18;
	}
	
	/**
     @dev Modifier
     ok if the transaction can buy tokens on TGE
     */
	modifier validPurchase() {
    	/*bool withinPeriod = now >= startTimestamp && now <= end2Timestamp;*/
		bool nonZeroPurchase = msg.value != 0;
		assert(nonZeroPurchase);
		_;
	}
	
	/**
     @dev Fallback function, payable. Calls `buyTokens`
	 */
	function () public payable {
		comprarMonedas(msg.sender);
	}
	
	/**
     @dev Envia la cantidad equivalente (mediante `getRate()`) a cambio de los wei recibidos.

     @param _beneficiario Direccion donde se enviaran las monedas
	 */
	function comprarMonedas(address _beneficiario) public payable validPurchase {
		//TODO asserts and requires
		assert(_beneficiario != propietario);
		require(msg.value > 0);
		
		A miA = A(misMonedas);
		require( 0 < miA.balanceOf(this));
		
		uint256 weis = msg.value;
		
		miA.transfer(_beneficiario, weis.mul(rate));
		//enviar los ethers a la cartera
		propietario.transfer(weis);
		
	}
	
	/**
	 @dev El propietario recupera todas las monedas que todavia no ha vendido
	 */
	function retirarTodo() onlyOwner public{
		A miA = A(misMonedas);
		require ( miA.balanceOf(this) > 0 );
		miA.transfer(propietario, miA.balanceOf(this));
	}
	
	/**
	 @dev El propietario recupera una cantidad determinada de las monedas que todavia no ha vendido
	 
	 @param cantidad la cantidad de monedas a retirar, debe ser inferior o igual al disponible
	 */
	function retirar(uint256 cantidad) onlyOwner public{
		A miA = A(misMonedas);
		require ( miA.balanceOf(this) >= cantidad );
		miA.transfer(propietario, cantidad);
	}
	
	/**
	 * setters
	 */
	function setPropietario(address _propietario) onlyOwner public {
		propietario = _propietario;
	}
	
	function setMisMonedas(address _misMonedas) onlyOwner public{
		misMonedas = _misMonedas;
	}
}

/**
 * contrato abstracto para crear la signature
 */
contract A { // This doesn't have to match the real contract name. Call it what you like.
	// No implementation, just the function signature. This is just so Solidity can work out how to call it.
   	function balanceOf(address direccion) public view returns (uint256 balance);
   	function transferFrom(address from, address to, uint256 value) public returns (bool);
   	function transfer(address _to, uint256 _value) public returns (bool);
   	/*
   	function miTransfer(address _to, uint256 _value) public returns (bool){
   		return super.transfer(_to, _value);
   	}
   	*/
   	function approve(address spender, uint256 value) public returns (bool);
   	function allowance(address _owner, address _spender) public view returns (uint256);
}