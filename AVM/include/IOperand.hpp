#ifndef IOPERAND_HPP
#define IOPERAND_HPP

#include <string>

enum eOperandType { enum_int8 = 0, enum_int16 = 1, enum_int32 = 2, enum_float = 3, enum_double = 4, };

class IOperand {
    public:
        virtual int getPrecision( void ) const = 0;
        
        virtual eOperandType getType( void ) const = 0;
        virtual IOperand const * operator+( IOperand const & rhs ) const = 0;
        virtual IOperand const * operator-( IOperand const & rhs ) const = 0;
        virtual IOperand const * operator*( IOperand const & rhs ) const = 0;
        virtual IOperand const * operator/( IOperand const & rhs ) const = 0;
        virtual IOperand const * operator%( IOperand const & rhs ) const = 0;
        virtual IOperand const * operator^( IOperand const & rhs ) const = 0;
        virtual std::string const & toString( void ) const = 0;

        virtual long double getMax(void) const = 0;
        virtual long double getMin(void) const = 0;
        virtual ~IOperand( void ) {}


};

#endif