
pragma ton-solidity >= 0.35.0;
pragma AbiHeader expire;

contract Names_in_Queue {
    mapping(uint256 => string) queue;
    uint256 first = 1;
    uint256 last = 0;

    constructor() public {
		// check that contract's public key is set
		require(tvm.pubkey() != 0, 101);
		// Check that message has signature (msg.pubkey() is not zero) and message is signed with the owner's private key
		require(msg.pubkey() == tvm.pubkey(), 102);
		tvm.accept();
	}

    function enqueue(string data) public {
        last += 1;
        queue[last] = data;
    }

    function dequeue() public returns (string data) {
        require(last >= first);  

        data = queue[first];

        delete queue[first];
        first += 1;
    }
}