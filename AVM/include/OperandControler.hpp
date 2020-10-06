#ifndef OPERANDCONTROLER_HPP
#define OPERANDCONTROLER_HPP


#include "IOperand.hpp"
#include "OperandFactory.hpp"
#include "Error.hpp"
#include <cmath>


template <typename T> class OperandControler : public IOperand { 

        public: 
        OperandControler(void);
        OperandControler(OperandControler const & src);
        OperandControler &operator=(OperandControler const & src); 
        OperandControler(T value, eOperandType type);
        virtual ~OperandControler(void);
        eOperandType getType( void ) const;
        long double getMax(void) const;
		long double getMin(void) const;
        std::string const & toString( void ) const;
        int         getPrecision(void) const ;
        void        setType(eOperandType type);
   		IOperand const * operator+(IOperand const & rhs) const;
  		IOperand const * operator-(IOperand const & rhs) const;
  		IOperand const * operator*(IOperand const & rhs) const;
  		IOperand const * operator/(IOperand const & rhs) const;
  		IOperand const * operator%(IOperand const & rhs) const;
  		IOperand const * operator^(IOperand const & rhs) const;


        private:
		std::string _value;
	 	eOperandType _type;
};

template<typename T> OperandControler<T>::OperandControler(void) {
	this->_value = std::to_string(static_cast<T>(0));
	this->_type = eOperandType::enum_double;
}
template<typename T> OperandControler<T>::OperandControler(T value, eOperandType type) {
	this->_value = std::to_string(value);
	this->_type = type;
}
template<typename T> OperandControler<T>::OperandControler(OperandControler const &src) {
	this->_value = src->_value;
	this->_type = src->_type;
	return this;
}

template<typename T> OperandControler<T>::~OperandControler(void) {
	return;
}

template<typename T> eOperandType OperandControler<T>::getType( void ) const {
	return this->_type;
}

template<typename T> long double OperandControler<T>::getMax( void ) const {
	return static_cast<long double>(std::numeric_limits<T>::max());
}

template<typename T> long double OperandControler<T>::getMin( void ) const {
	return static_cast<long double>(std::numeric_limits<T>::lowest());
}

template<typename T> std::string const & OperandControler<T>::toString( void ) const {
	return this->_value;
}

template <typename T> IOperand const * OperandControler<T>::operator+(IOperand const & rhs) const {
   OperandFactory OPfactory;
    eOperandType t;
	ErrorParser::overflow(&rhs, this, "add");
	ErrorParser::underflow(&rhs, this, "add");
    this->getPrecision() < rhs.getPrecision() ? t = rhs.getType() : t = this->_type;
        return OPfactory.createOperand(t, std::to_string(std::stod(this->_value) + std::stod(rhs.toString())));
}

template <typename T> IOperand const * OperandControler<T>::operator-(IOperand const & rhs) const {
    OperandFactory OPfactory;
    eOperandType t;
	ErrorParser::overflow(&rhs, this, "sub");
	ErrorParser::underflow(&rhs, this, "sub");
    this->getPrecision() < rhs.getPrecision() ? t = rhs.getType() : t = this->_type;
        return OPfactory.createOperand(t, std::to_string(std::stod(this->_value) - std::stod(rhs.toString())));
}

template <typename T> IOperand const * OperandControler<T>::operator/(IOperand const & rhs) const {
    OperandFactory OPfactory;
    eOperandType t;
    this->getPrecision() < rhs.getPrecision() ? t = rhs.getType() : t = this->_type;
        return OPfactory.createOperand(t, std::to_string(std::stod(this->_value) / std::stod(rhs.toString())));
}

template <typename T> IOperand const * OperandControler<T>::operator*(IOperand const & rhs) const {
    OperandFactory OPfactory;
    eOperandType t;

 	ErrorParser::overflow(&rhs, this, "mul");
	ErrorParser::underflow(&rhs, this, "mul");
    this->getPrecision() < rhs.getPrecision() ? t = rhs.getType() : t = this->_type;
        return OPfactory.createOperand(t, std::to_string(std::stod(this->_value) * std::stod(rhs.toString())));
}

template <typename T> IOperand const * OperandControler<T>::operator%(IOperand const & rhs) const {
    OperandFactory OPfactory;
    eOperandType t;
    this->getPrecision() < rhs.getPrecision() ? t = rhs.getType() : t = this->_type;
        return OPfactory.createOperand(t, std::to_string(std::fmod(std::stod(this->_value), std::stod(rhs.toString()))));
}

template <typename T> IOperand const * OperandControler<T>::operator^(IOperand const & rhs) const {
    OperandFactory OPfactory;
    eOperandType t;

 	ErrorParser::overflow(&rhs, this, "pow");
	ErrorParser::underflow(&rhs, this, "pow");
    this->getPrecision() < rhs.getPrecision() ? t = rhs.getType() : t = this->_type;
        return OPfactory.createOperand(t, std::to_string(std::pow(std::stod(this->_value), std::stod(rhs.toString()))));
}

template <typename T> int OperandControler<T>::getPrecision(void) const{
    return static_cast<int>(this->_type);
}
#endif