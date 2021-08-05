pragma solidity ^0.4.0;

contract zhongchou {
    
    struct funder {
        address funderAddress;
        uint tomoney;
    }
    
    struct needer {
        address neederAddress;
        uint goal;
        uint amount;
        uint funderNumber;
        mapping(uint => funder) map;
    }
    uint neederNumber;
    mapping(uint => needer) needmap;
    function newNeeder(address _needAddress,uint _goal) {
        neederNumber++;
        needmap[neederNumber] = needer(_needAddress,_goal,0,0);
        
    }
    
    function contribute(address _funderAddress,uint _neederNumber) payable{
        needer storage _needer = needmap[_neederNumber];
        _needer.amount += msg.value;
        _needer.funderNumber++;
        _needer.map[_needer.funderNumber] = funder(_funderAddress,msg.value);
    }
    
    function isComplete(uint _neederNumber) {
        needer storage _needer = needmap[_neederNumber];
        if(_needer.amount >= _needer.goal) {
            _needer.neederAddress.transfer(_needer.amount);
        }
    }

}
