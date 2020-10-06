#include "OperandFactory.hpp"
#include "OperandControler.hpp"

OperandFactory::OperandFactory(void){

}

OperandFactory::~OperandFactory(void) {

}

OperandFactory::OperandFactory(OperandFactory const &src){
    (void)src;
}

OperandFactory & OperandFactory::operator=(OperandFactory const & src){
    (void)src;
    return *this;
}

IOperand const * OperandFactory::createOperand(eOperandType type, std::string const & value){
    switch(type) {
        case eOperandType::enum_int8:return createInt8(value);
        case eOperandType::enum_int16: return createInt16(value);
        case eOperandType::enum_int32: return createInt32(value);
        case eOperandType::enum_float: return createFloat(value);
        case eOperandType::enum_double: return createDouble(value);
   }
   return NULL;
}


IOperand const * OperandFactory::createInt8(std::string const & value) const {
	return new OperandControler<int8_t>(std::stoi(value), eOperandType::enum_int8);
}

IOperand const * OperandFactory::createInt16(std::string const & value) const {
	return new OperandControler<int16_t>(std::stoi(value), eOperandType::enum_int16);
}

IOperand const * OperandFactory::createInt32(std::string const & value) const {
	return new OperandControler<int32_t>(std::stoi(value), eOperandType::enum_int32);
}

IOperand const * OperandFactory::createFloat(std::string const & value) const {
	return new OperandControler<float>(std::stof(value), eOperandType::enum_float);
}

IOperand const * OperandFactory::createDouble(std::string const & value) const {
	return new OperandControler<double>(std::stod(value), eOperandType::enum_double);
}