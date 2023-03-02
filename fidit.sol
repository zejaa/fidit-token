pragma solidity ^0.5.16;

contract FIDIT {
    string public constant name = "FIDIT";
    string public constant symbol = "FDT";
    uint8 public constant decimals = 18; // 1 FDT is divisible by 10^18
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balanceOf;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Burn(address indexed from, uint256 value);

    constructor(uint256 initialSupply) public {
        owner = msg.sender;
        totalSupply = initialSupply;
        balanceOf[owner] = totalSupply;
    }

    function transfer(address to, uint256 value) public returns (bool success) {
        require(value <= balanceOf[msg.sender], "Insufficient balance");
        require(to != address(0), "Invalid address");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

   

    function transferFrom(address from, address to, uint256 value) public returns (bool success) {
    require(value <= balanceOf[from], "Insufficient balance");

    balanceOf[from] -= value;
    balanceOf[to] += value;

    emit Transfer(from, to, value);
    return true;
}

    function mint(address to, uint256 value) public {
        require(msg.sender == owner, "Only the owner can mint tokens");

        totalSupply += value;
        balanceOf[to] += value;

        emit Mint(to, value);
    }

    function burn(uint256 value) public {
        require(msg.sender == owner, "Only the owner can burn tokens");
        require(value <= balanceOf[owner], "Insufficient balance");

        totalSupply -= value;
        balanceOf[owner] -= value;

        emit Burn(owner, value);
    }
}