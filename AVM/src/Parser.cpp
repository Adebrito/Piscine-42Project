#include "../include/Parser.hpp"

Parser::Parser(void){
}

Parser::~Parser(void){

}

Parser::Parser(Parser const & obj) {
    *this = obj;
    return;
}

Parser &Parser::operator=(Parser const & rhs) {
    if (this != &rhs)
    *this = rhs;
    return *this;
}

int         Parser::getIndexLine(void) {
    return this->indexLine;
}

void         Parser::setIndexLine(void){
    this->indexLine += 1;
}

bool        Parser::getExit(void){
    return this->exit;
}

void        Parser::setExit(void){
    this->exit = true;
}

std::string       Parser::EraseSomeSpace(std::string command) {

    for(int i = command.length(); i >= 0; i--)
    {
        if (command[i - 1] != ' '){
         command = command.erase(i, command.length() - i);
         i = -1;
        }
    }
    return command;
}

int         Parser::RegexLine(std::string  value){

  	std::stringstream split;
  	char char_split = ';';
	split << value;
	std::getline(split, value, char_split);
	std::regex regexContent("(push (?![ ]{1,})|pop|dump|assert (?![ ]{1,})|add|sub|mul|div|mod|print|pow|exit|while (\\([0-9]*\\)))((?=\\n|$)|int8(\\([0-9]*\\)|\\(-[0-9]*\\))|int16(\\([0-9]*\\)|\\(-[0-9]*\\))|int32(\\([0-9]*\\)|\\(-[0-9]*\\))|float((\\([0-9]*\\)|\\(-[0-9]*\\))|(\\(-\\d+(\\.[0-9]\\d*?\\))|\\.[0-9]\\d+|\\(\\d+(\\.[0-9]\\d*?\\))|\\.[0-9]\\d+))|double((\\([0-9]*\\)|\\(-[0-9]*\\))|(\\(-\\d+(\\.[0-9]\\d*?\\))|\\.[0-9]\\d+|\\(\\d+(\\.[0-9]\\d*?\\))|\\.[0-9]\\d+)))");
	value = EraseSomeSpace(value);

if (value.empty())
{
    return (0);
}
  if (regex_match(value, regexContent) && value != "exit") {
    size_t pos = 0;
	std::string info;
	std::string type;
	AVM_List tmp;
	std::string delimiter = " ";
	while ((pos = value.find(delimiter)) != std::string::npos) {
		info = value.substr(0, pos);
		value.erase(0, pos + delimiter.length());
	}
	if (info != "" && value != "") {
		pos = 0;
		delimiter= "(";
		while ((pos = value.find(delimiter)) != std::string::npos) {
			type = value.substr(0, pos);
			value.erase(0, pos + delimiter.length());
			value = value.substr(0, value.size()-1);
		}
		tmp.info = info;
		tmp.type = type;
		tmp.value = value;
		if (value.empty()){ throw std::logic_error("\033[1;31mThis instruction is false: value empty \033[0m");}
		long double val = std::stold(value);
		if (tmp.type == "int8" && (val <  std::numeric_limits<int8_t>::lowest() || val > std::numeric_limits<int8_t>::max())) { return 3; }
		if (tmp.type == "int16" && (val <  std::numeric_limits<int16_t>::lowest() || val > std::numeric_limits<int16_t>::max())) { return 3; }
		if (tmp.type == "int32" && (val <  std::numeric_limits<int32_t>::lowest() || val > std::numeric_limits<int32_t>::max() )) { return 3; }
		if (tmp.type == "float" && (val < std::numeric_limits<float>::lowest() || val > std::numeric_limits<float>::max() )) { return 3; }
		if (tmp.type == "double" && (val < std::numeric_limits<double>::lowest() || val > std::numeric_limits<double>::max() )) { return 3; }
	} else {
		tmp.type = "null";
		tmp.value = "null";
		tmp.info = value;
	}

	this->avmList.push_back(tmp);
	return 0;
      return (0);
  }
  else if (value == "exit"){
    this->exit = true;
    this->end = this->avmList.end();
    this->start = this->avmList.begin();
    return (0);
  }
  return (1);
}


