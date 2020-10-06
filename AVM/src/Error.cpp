#include "../include/Error.hpp"

ErrorParser::ErrorParser(void){
}

ErrorParser::~ErrorParser(void){
}

ErrorParser::ErrorParser(ErrorParser const & obj) {
    *this = obj;
}

ErrorParser &ErrorParser::operator=(ErrorParser const & rhs) {
    if (this != &rhs)
    *this = rhs;
    return *this;
}

void       ErrorParser::underflow(IOperand const *op, IOperand const *op2, std::string type) {
        long double min;
        op->getPrecision() < op2->getPrecision() ? min = op2->getMin() : min = op->getMin();

        if (type == "add") {
            if (std::stod(op->toString()) + std::stod(op2->toString()) < min)
                throw Underflow();
            else
                return ;
        }
        else if (type == "sub"){
                        if (std::stod(op->toString()) - std::stod(op2->toString()) < min)
                throw Underflow();
            else
                return ;
        }
        else if (type == "mul"){
                        if (std::stod(op->toString()) * std::stod(op2->toString()) < min)
                throw Underflow();
            else
                return ;

        }
        else{
            if (pow(std::stod(op->toString()),std::stod(op2->toString())) < min)
                throw Underflow();
            else
                return ;
        }
}
 void       ErrorParser::overflow(IOperand const *op, IOperand const * op2, std::string type) {
        long double max;
        op->getPrecision() < op2->getPrecision() ? max = op2->getMax() : max = op->getMax();

        if (type == "add") {
            if (std::stod(op->toString()) + std::stod(op2->toString()) > max)
                throw Overflow();
            else
                return ;
        }
        else if (type == "sub"){
                        if (std::stod(op->toString()) - std::stod(op2->toString()) > max)
                throw Overflow();
            else
                return ;
        }
        else if (type == "mul"){
                        if (std::stod(op->toString()) * std::stod(op2->toString()) > max)
                throw Overflow();
            else
                return ;

        }
        else{
            if (pow(std::stod(op->toString()),std::stod(op2->toString())) > max)
                throw Overflow();
            else
                return ;
        }
 }

int         ErrorParser::CheckReturnRegex(int ErrorParserNb, bool isExit, int line, int after, bool fs){
    (void)fs;
    
    if (ErrorParserNb == 1){
        return this->putError(line, SYNTAX_ERROR);
    }
    else if(isExit && after == 1) {
        return this->putError(line, EXIT_ERROR);
    }
    else if (ErrorParserNb == 3){
        return this->putError(line, FALSE_INST_ERROR); 
    }
    return 0;
}


void        ErrorParser::endOfFile(bool isExit) {
      	if (!isExit) {
		    throw EndOfFile();
  	}

}
int ErrorParser::putError(int line, std::string const & error) const {
  std::cerr << "\033[1;31mLine\033[0m " <<"\033[1;32m" << line << "\033[0m" << "\033[1;31m : " << error <<"\033[0m";
  return 1;
}



ErrorParser::EndOfFile::EndOfFile(void) { return; }

ErrorParser::EndOfFile::~EndOfFile(void) throw() { return; }

ErrorParser::EndOfFile::EndOfFile(EndOfFile const & rhs) {
    *this = rhs;
    return;
}

const char* ErrorParser::EndOfFile::what(void) const throw() { return(END_OF_FILE); }

ErrorParser::EndOfFile & ErrorParser::EndOfFile::operator=(EndOfFile const & rhs) {
    (std::exception)*this = std::exception::operator=(rhs);
    return *this;
}

ErrorParser::StackSize::StackSize(void) { return; }

ErrorParser::StackSize::~StackSize(void) throw() { return; }

ErrorParser::StackSize::StackSize(StackSize const & rhs) {
    *this = rhs;
    return;
}

const char* ErrorParser::StackSize::what(void) const throw() { return(STACK_SIZE); }

ErrorParser::StackSize & ErrorParser::StackSize::operator=(StackSize const & rhs) {
    (std::exception)*this = std::exception::operator=(rhs);
    return *this;
}

ErrorParser::ErrorByZero::ErrorByZero(void) { return; }

ErrorParser::ErrorByZero::~ErrorByZero(void) throw() { return; }

ErrorParser::ErrorByZero::ErrorByZero(ErrorByZero const & rhs) {
    *this = rhs;
    return;
}

const char* ErrorParser::ErrorByZero::what(void) const throw() { return(VALUE_ZERO); }

ErrorParser::ErrorByZero & ErrorParser::ErrorByZero::operator=(ErrorByZero const & rhs) {
    (std::exception)*this = std::exception::operator=(rhs);
    return *this;
}

ErrorParser::Underflow::Underflow(void) { return; }

ErrorParser::Underflow::~Underflow(void) throw() { return; }

ErrorParser::Underflow::Underflow(Underflow const & rhs) {
    *this = rhs;
    return;
}

const char* ErrorParser::Underflow::what(void) const throw() { return(ERR_UF); }

ErrorParser::Underflow & ErrorParser::Underflow::operator=(Underflow const & rhs) {
    (std::exception)*this = std::exception::operator=(rhs);
    return *this;
}

ErrorParser::Overflow::Overflow(void) { return; }

ErrorParser::Overflow::~Overflow(void) throw() { return; }

ErrorParser::Overflow::Overflow(Overflow const & rhs) {
    *this = rhs;
    return;
}

const char* ErrorParser::Overflow::what(void) const throw() { return(ERR_OF); }

ErrorParser::Overflow & ErrorParser::Overflow::operator=(Overflow const & rhs) {
    (std::exception)*this = std::exception::operator=(rhs);
    return *this;
}

ErrorParser::Empty::Empty(void) { return; }

ErrorParser::Empty::~Empty(void) throw() { return; }

ErrorParser::Empty::Empty(Empty const & rhs) {
    *this = rhs;
    return;
}

const char* ErrorParser::Empty::what(void) const throw() { return(EMPTY); }

ErrorParser::Empty & ErrorParser::Empty::operator=(Empty const & rhs) {
    (std::exception)*this = std::exception::operator=(rhs);
    return *this;
}

ErrorParser::AssertError::AssertError(void) { return; }

ErrorParser::AssertError::~AssertError(void) throw() { return; }

ErrorParser::AssertError::AssertError(AssertError const & rhs) {
    *this = rhs;
    return;
}

const char* ErrorParser::AssertError::what(void) const throw() { return(ASSERT_ERROR); }

ErrorParser::AssertError & ErrorParser::AssertError::operator=(AssertError const & rhs) {
    (std::exception)*this = std::exception::operator=(rhs);
    return *this;
}