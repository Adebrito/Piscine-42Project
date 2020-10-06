#ifndef EXEC_HPP
#define EXEC_HPP

#include <string>
#include <list>
#include <map>
#include <iostream>
#include <sstream>
#include <regex>
#include "Parser.hpp"
#include "Error.hpp"
#include "IOperand.hpp"
#include "OperandFactory.hpp"

class Exec { 

    typedef void (Exec::*Func)(void); 
    public :
    Exec(void);
    virtual ~Exec(void);
    Exec(Exec const & rhs);
    Exec & operator=(Exec const & rhs);
    void    ExecVm(Parser *p);

    private:
    std::map<std::string, Func> val;
    std::map<std::string, Func>::iterator it;
    std::list<IOperand const *> stack;
    std::list<IOperand const*>::const_iterator start;
    std::list<IOperand const *>::const_iterator end;

    eOperandType getEnumId(std::string);
    IOperand const *getLast(void);
    IOperand const *getLastAndPop(void);
    void    call(std::string);
    void    push(eOperandType , std::string const &) ;
    void    assertE(eOperandType , std::string const &);
    void    add();
    void    sub();
    void    mul();
    void    div();
    void    mod();
    void    dump();
    void    pop();
    void    pow();
    void    print();
    void    exitE();

    OperandFactory OPfactory;
};

#endif