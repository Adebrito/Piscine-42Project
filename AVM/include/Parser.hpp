#ifndef PARSER_HPP
#define PARSER_HPP

#include <string>
#include <list>
#include <regex>
#include <iostream>
#include <sstream>
#include <limits>

struct AVM_List{
    std::string info;
    std::string type;
    std::string value;
};

class Parser {
    public:

    std::list<AVM_List> avmList;
    std::list<AVM_List>::const_iterator start;
    std::list<AVM_List>::const_iterator end;

    Parser(void);
    virtual ~Parser(void);
    Parser(Parser const & obj);

    Parser & operator=(Parser const & rhs);

    int        RegexLine(std::string value);
    int        getIndexLine(void);
    void       setIndexLine(void);
    void       setExit(void);
    bool       getExit(void);
    std::string     EraseSomeSpace(std::string);


    private :
    int  indexLine = 0;
    bool exit = false;

};

#endif