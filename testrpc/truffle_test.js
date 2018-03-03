
contratoBDG = '0x9c1e398dfbd4dd8dec34e86d7fa0fe796bd3ea7c';
contratoFDX = '0xf1f2ff08c674ac0c0f61bb2c055a62113a894fea';

#balances

web3.eth.getBalance(web3.eth.accounts[0]);
web3.eth.getBalance(web3.eth.accounts[1]);
web3.eth.getBalance(contratoBDG);


#deploys
trueke = TruekenERC20Proxy.deployed()
bit = BitDegreeToken.deployed()
fdx = FidentiaXToken.deployed()

# venedor carrega el tokens al contracte
bit.then(instance => {return instance.transfer(contratoBDG, web3.toWei(1000))})
bit.then(instance => {return instance.balanceOf(web3.eth.accounts[0])})
bit.then(instance => {return instance.balanceOf(contratoBDG)})

fdx.then(instance => {return instance.transfer(contratoFDX, web3.toWei(1000))})
fdx.then(instance => {return instance.balanceOf(web3.eth.accounts[0])})
fdx.then(instance => {return instance.balanceOf(contratoFDX)})

# Alice paga al venedor
web3.eth.sendTransaction({from: web3.eth.accounts[1], to: contratoBDG, value: web3.toWei(10, "ether")})

# venedor retira 100
trueke.then(instance => {return instance.retirar(web3.toWei(100))})
# vendedor retira mas de la cuenta
trueke.then(instance => {return instance.retirar(web3.toWei(1000))})
# vendedor retira el restante
trueke.then(instance => {return instance.retirarTodo()})



#  venedor cobra
trueke.then( instance => {return instance.cobrar()})

# mirem el resultat
# ether i tokens del contracte
web3.eth.getBalance("0x15a53de56f6abee9cee169156190df52aafc3719")
bit.then(instance => {return instance.balanceOf(contratoBDG)})
#tokens de Alice
bit.then(instance => {return instance.balanceOf(web3.eth.accounts[1])})
#tokens del venedor
bit.then(instance => {return instance.balanceOf(web3.eth.accounts[0])})
