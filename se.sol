pragma solidity >=0.4.22 <0.6.0;

contract zhongchou {
    
    struct funder {
        address funderAddress;
        uint tomoney;
    }
    
    struct needer {
        address neederAddress;
        uint goal;
        string reasons;
        uint amount;
        uint funderNumber;
        mapping(uint => funder) fundermap;
    }
    uint8 neederNumber;
    mapping(uint8 => needer) needermap;
    function newNeeder(address _needAddress,uint _goal,string memory reasons) public {
        neederNumber++;
        needermap[neederNumber] = needer(_needAddress,_goal,reasons,0,0);
        
    }
    
    function getNeederNumber() public view returns(uint8) {
        return neederNumber;
    }
    
    function contribute(address _funderAddress,uint8 _neederNumber) payable public{
        needer storage _needer = needermap[_neederNumber];
        _needer.amount += msg.value;
        _needer.funderNumber++;
        _needer.fundermap[_needer.funderNumber] = funder(_funderAddress,msg.value);
    }
    
    function isComplete(uint8 _neederNumber) public returns(string memory) {
        needer storage _needer = needermap[_neederNumber];
        if(_needer.amount >= _needer.goal) {
            address(uint160(_needer.neederAddress)).transfer(_needer.amount);
            _needer.amount = 0;
            return "transfer completed!";
        }else{
            return "Your fundraising has not reached the target value.";
        }
        
    }
    
    function getNeederAmount(uint8 _neederNumber) public view returns(uint){
        needer storage _needer = needermap[_neederNumber];
        return _needer.amount;
    }
    function getNeederGoal(uint8 _neederNumber) public view returns(uint){
        needer storage _needer = needermap[_neederNumber];
        return _needer.goal;
    }

}
