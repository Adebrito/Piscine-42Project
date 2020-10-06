#ifndef ErrorParser_HPP
#define ErrorParser_HPP

#include <string>
#include <list>
#include <regex>
#include <iostream>
#include <sstream>
#include <limits>
#include <cmath>

#include "IOperand.hpp"
#define SYNTAX_ERROR "Syntax error on this instruction >> "
#define FALSE_INST_ERROR "This instruction is false >>  "
#define EXIT_ERROR "Exit must be the last instruction >> "
#define END_OF_FILE "You must have an exit at the end of instructions"
#define STACK_SIZE "Need 2 value to exec "
#define VALUE_ZERO "Can't do DIV / MOD if the value is 0 bro"
#define ERR_UF "Underflow detected"
#define ERR_OF "Overflow detected"
#define EMPTY "Can't POP / DUMP / ASSERT if Stack empty"
#define ASSERT_ERROR "Error on Assert"


class ErrorParser {

    public:
    ErrorParser(void);
    virtual ~ErrorParser(void);
    ErrorParser(ErrorParser const & obj);
    ErrorParser & operator=(ErrorParser const & rhs);

    		class EndOfFile : public std::exception {
			public:
				EndOfFile(void);
				virtual ~EndOfFile(void) throw();
				EndOfFile(EndOfFile const & rhs);
				EndOfFile & operator=(EndOfFile const & rhs);
				virtual const char* what() const throw();
		};
			class StackSize : public std::exception {
			public:
				StackSize(void);
				virtual ~StackSize(void) throw();
				StackSize(StackSize const & rhs);
				StackSize & operator=(StackSize const & rhs);
				virtual const char* what() const throw();
		};
			class ErrorByZero : public std::exception {
			public:
				ErrorByZero(void);
				virtual ~ErrorByZero(void) throw();
				ErrorByZero(ErrorByZero const & rhs);
				ErrorByZero & operator=(ErrorByZero const & rhs);
				virtual const char* what() const throw();
		};

					class Underflow : public std::exception {
			public:
				Underflow(void);
				virtual ~Underflow(void) throw();
				Underflow(Underflow const & rhs);
				Underflow & operator=(Underflow const & rhs);
				virtual const char* what() const throw();
		};

					class Overflow : public std::exception {
			public:
				Overflow(void);
				virtual ~Overflow(void) throw();
				Overflow(Overflow const & rhs);
				Overflow & operator=(Overflow const & rhs);
				virtual const char* what() const throw();
		};

					class Empty : public std::exception {
			public:
				Empty(void);
				virtual ~Empty(void) throw();
				Empty(Empty const & rhs);
				Empty & operator=(Empty const & rhs);
				virtual const char* what() const throw();
		};

					class AssertError : public std::exception {
			public:
				AssertError(void);
				virtual ~AssertError(void) throw();
				AssertError(AssertError const & rhs);
				AssertError & operator=(AssertError const & rhs);
				virtual const char* what() const throw();
		};

	void 				endOfFile(bool isExit);
    int     			CheckReturnRegex(int, bool, int, int, bool);
    int 				putError(int line, std::string const & error) const;
	static 		void	underflow(IOperand  const *op, IOperand const *op2, std::string type);
	static		void	overflow(IOperand const *op, IOperand const *op2, std::string type);

};

#endif