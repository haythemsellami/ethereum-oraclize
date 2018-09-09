pragma solidity ^0.4.24;


import "./Oraclize.sol";

contract IpfsFileOraclize is usingOraclize {

    string public fileContent;
    bytes32 public oraclizeID;
    
    constructor() public {
    }

    function getContent(string _fileHash) public payable {
        oraclizeID = oraclize_query("IPFS", _fileHash);
    }

    function __callback(bytes32 _oraclizeID, string _fileContent) public {
        require(msg.sender == oraclize_cbAddress(), "Not authorized");
        fileContent = _fileContent;
    }
}
