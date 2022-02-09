ragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract StakingToken is ERC20, Ownable {
   using SafeMath for uint256;


    constructor()
       public
    {
        
    }
    
     enum LoanStatus {
        DUMMY_DO_NOT_USE,
        CREATED,
        REMOVED,
        ACTIVE,
        REPAID,
        DEFAULTED
    }
    
     struct LoanData {
        LoanStatus loanState;
        address borrower;
        address lender;
        uint256 deadline;
        address payableCurrency;
        uint256 principal;
        uint256 repayment;
        address nftToken;
    }
    
    function createLoan(address _borrower, uint256 _deadline, address _payableCurrency, uint256 _principal, uint256 _repayment, address nftToken)
        public
    {
        uint ID = loans.push(Loan(_borrower, address(0), _deadline, _payableCurrency, _principal, _repayment, nftToken));
        loanToBorrower[id] = msg.sender;
        countOfBorrowerLoan[msg.sender]++;
        emit NewLoan(ID, nftToken);
    }
    
     bytes32 hashStruct = keccak256(
            abi.encode(
                keccak256("set(address borrower,uint principal,uint repayment,address currency,uint deadline,address nft)"),
                borrower,
                principal,
                repayment,
                currency,
                deadline,
                nft
            )
        );

        bytes32 hash = keccak256(abi.encodePacked("\x19\x01", eip712DomainHash, hashStruct));
        address signer = ecrecover(hash, v, r, s);
        require(signer == borrower, "MyFunction: invalid signature");
        require(signer != address(0), "ECDSA: invalid signature");
