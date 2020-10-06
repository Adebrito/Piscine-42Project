#include "Exec.hpp"

Exec::Exec(void){
}

Exec::Exec(Exec const & rhs){
    (void)rhs;
}

Exec & Exec::operator=(Exec const & rhs){
    (void)rhs;
    return *this;
}

Exec::~Exec(void){

}


void        Exec::ExecVm(Parser *p){
    std::list<AVM_List>::const_iterator start;
    eOperandType enumId = eOperandType::enum_double;

    for (start = p->avmList.begin(); start != p->avmList.end(); ++start){
        if (start->type != "null"){
            enumId = this->getEnumId(start->type);
        }
        if (start->info == "push") {
            this->push(enumId, start->value);
        }
        if (start->info == "assert") {
            this->assertE(enumId, start->value);
        }
        if (start->type == "null"){
        this->call(start->info);
        }
    }
}

void        Exec::call(std::string info){
    if (info == "add"){
        add();
    }
    else if (info == "pop"){
        pop();
    }
    else if (info == "sub"){
        sub();
    }
    else if (info == "mul"){
        mul();
    }
    else if (info == "pow"){
        pow();
    }
    else if (info == "div"){
        div();
    }
    else if (info == "dump"){
        dump();
    }
    else if (info == "print"){
        print();
    }
    else if (info == "exit"){
        exitE();
    }
    else {
        mod();
    }

}


eOperandType Exec::getEnumId(std::string t){
    if (t == "int8"){
        return eOperandType::enum_int8;
    }
    else if (t == "int16"){
         return eOperandType::enum_int16;
    }
    else if (t == "int32"){
         return eOperandType::enum_int32;
    }
    else if (t == "float"){
        return eOperandType::enum_float;
    }
    else {
        return eOperandType::enum_double;
    }
}

void       Exec::add(void){
    if (stack.size() < 2) {
            throw ErrorParser::StackSize();
    }
    else {
    IOperand const  * rhs = this->getLast();
    this->stack.pop_back();
    IOperand const * lhs = this->getLast();
    this->stack.pop_back();
    this->stack.push_back(*lhs + *rhs);
    }
}
void       Exec::pop(void){
    if (stack.size() == 0){
        throw ErrorParser::Empty();
    }
    else {
         this->stack.pop_back();        
    }
}
void       Exec::sub(void){
        if (stack.size() < 2) {
            throw ErrorParser::StackSize();
    }
    else {
    IOperand const  * rhs = this->getLast();
    pop();
    IOperand const * lhs = this->getLast();
    pop();
    this->stack.push_back(*lhs - *rhs);
    }
}
void       Exec::mul(void){
    if (stack.size() < 2) {
        throw ErrorParser::StackSize();
    }

    else {
        IOperand const  * rhs = this->getLast();
        pop();
        IOperand const * lhs = this->getLast();
        pop();
        this->stack.push_back(*lhs * *rhs);
    }
}

void       Exec::mod(void){
    if (stack.size() < 2)
    {
        throw ErrorParser::StackSize();
    }
        IOperand const  * rhs = this->getLast();
        pop();
        IOperand const * lhs = this->getLast();
        pop();
        if (std::stod(rhs->toString()) == static_cast<double>(0)){
            throw ErrorParser::ErrorByZero();
        }
         this->stack.push_back(*lhs % *rhs);
}

void       Exec::div(void){
        if (stack.size() < 2)
    {
        throw ErrorParser::StackSize();
    }
        IOperand const  * rhs = this->getLast();
        pop();    
        IOperand const * lhs = this->getLast();
        pop();
        if (std::stod(rhs->toString()) == static_cast<double>(0)){
            throw ErrorParser::ErrorByZero();
        }
        else
        {
            this->stack.push_back(*lhs / *rhs);

        }
        
}

void       Exec::dump(void){
    if (stack.size() == 0) {
        throw ErrorParser::Empty();
    }
    std::list<IOperand const *>:: iterator end = this->stack.end();
		end--;
		std::cout << "\033[1;33mDump: \033[0m" << std::endl;
		while (end != this->stack.begin()) {
			std::cout << "\033[1;36m"<<(*end)->toString() << "\033[0m" << std::endl;
			end--;
		}
		std::cout << "\033[1;36m" << this->stack.front()->toString() << "\033[0m" << std::endl;
}

void       Exec::print(void){
  	if (stack.size() == 0) {
		throw ErrorParser::Empty();
	} else {
  		IOperand const * nb = this->getLast();
  		if (nb->getType()!= 0) {
			throw std::logic_error("Value need to be int8 TYPE");
		} else {
  			int value = std::stoi(nb->toString());
			if (value < 0) {
				throw std::logic_error("Only value between 0 & 127 can be print");
			} else {
				std::cout << static_cast<char>(value) << std::endl;
			}
		}
	}
}

void       Exec::pow(void){
        if (stack.size() < 2) {
        throw ErrorParser::StackSize();
    }

    else {
        IOperand const  * rhs = this->getLast();
        pop();
        IOperand const * lhs = this->getLast();
        pop();
        this->stack.push_back(*lhs + *rhs);
    }
}

void        Exec::assertE(eOperandType enumId, std::string const & value){
    if (stack.size() == 0 ){
        throw ErrorParser::Empty();
    }
   IOperand const  * rhs = this->getLast();
    if (rhs->toString() != value || rhs->getType() != enumId){
        throw ErrorParser::AssertError();
    }
}

void       Exec::exitE(void){
    std::exit(0);
}

IOperand const *Exec::getLast(){
    return this->stack.back();
}

void       Exec::push(eOperandType enumId, std::string const & value){
     this->stack.push_back(OPfactory.createOperand(enumId, value));
}