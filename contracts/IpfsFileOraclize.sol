pragma solidity ^0.4.24;


import "./Oraclize.sol";

contract IpfsFileOraclize is usingOraclize {

    string public fileContent;
    bytes32 public oraclizeId;
    mapping(bytes32=>bool) validOraclizeIds;
    
    constructor() public {
    }

    function getContent(string _fileHash) public payable {
        oraclizeId = oraclize_query("IPFS", _fileHash);
        validOraclizeIds[oraclizeId] = true;
    }

    function __callback(bytes32 _oraclizeId, string _fileContent) public {
        //check that the address sender is the oraclizer
        require(msg.sender == oraclize_cbAddress(), "Not authorized");
        //check that query id is valid
        require(validOraclizeIds[_oraclizeId] == true, "invalid oraclize id");

        //Update file content
        fileContent = _fileContent;

        delete validOraclizeIds[_oraclizeId];
    }
}
