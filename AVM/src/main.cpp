#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
#include <vector>
#include <iomanip>
#include <stdlib.h>
#include <regex>
#include <algorithm>
#include<stdio.h> 

#include "Parser.hpp"
#include "Error.hpp"
#include "Exec.hpp"

std::string randomName(int length) {


 srand(time(NULL));
  
  char consonents[] = {'b','c','d','f','g','h','j','k','l','m','n','p','q','r','s','t','v','w','x','z'};
  char vowels[] = {'a','e','i','o','u','y'};

  std::string name = "";

  int random = rand() % 2;
  int count = 0;

  for(int i = 0; i < length; i++) {

    if(random < 2 && count < 2) {
      name = name + consonents[rand() % 19];
      count++;
    }
    else {
      name = name + vowels[rand() % 5];
      count = 0;
    }

    random = rand() % 2;

  }

  return name;

}

void            StartParsingFile(std::string file){
        Parser *parse = new Parser();
        ErrorParser *err = new ErrorParser();
        Exec *e = new Exec();
        std::ifstream fs(file);
        std::string val;
        int after = 0;        
        int needToStop = 0;
        try {
        while (!fs.eof()){
            std::getline(fs, val);
            parse->setIndexLine();
            if (parse->getExit()){
              after = 1;
            }
              if (val != ""){
              if (err->CheckReturnRegex(parse->RegexLine(val), parse->getExit(), parse->getIndexLine(), after, !fs.eof()) == 1){
                  std::cout << val << std::endl;
                  needToStop = 1;
              }; 
            }
        }
        if (needToStop == 1) {
          fs.close();
        }
        else {
          fs.close();
          err->endOfFile(parse->getExit());
          e->ExecVm(parse);
        }
        } catch (const std::exception & e) { std::cerr << "\033[1;33m" << e.what() << "\033[0m\n"; }
}



std::string CreateFile(std::stringstream & ss){
  std::string  NewFile = (randomName(7) + "_avm");
  std::string File = ("./test/" + NewFile);
  std::ofstream ofs(File);
  ofs << ss.str();
  ofs.close();
  return (File);
}

int main (int argc, char **argv) {


    if (argc == 2){
       
       std::string file = argv[1];
       std::ifstream fs(file);
       
       if(!fs.good()){
            std::cout << "Bad File !! >> " << file << std::endl;
            return (1);   
        }
        StartParsingFile(file);
    }
    else {
        Parser *parser = new Parser();
        std::string command;
        std::stringstream ss;
        while(true){
            std::getline(std::cin, command);
            command = parser->EraseSomeSpace(command);
            if (command.compare(";;") != 0){
                ss << command << std::endl;
            }
            if ((command.compare(";;") == 0)) {
                int response = 0;
                while (response == 0){
                    std::cout << "Do you want to save ur input in a file ? Yes/No : ";
                    std::getline(std::cin, command);
                    std::transform (command.begin(), command.end(), command.begin(), ::tolower);
                      if (command.compare("yes") == 0){
                        std::string file = CreateFile(ss);
                        StartParsingFile(file);
                        std::cout << "We saved ur input in this file >> " << file << std::endl;
                        response = 1;
                      }
                      else if (command.compare("no") == 0) {
                          std::string file = CreateFile(ss);
                        StartParsingFile(file);
                          if (remove(file.c_str())){
                            std::cout << "No problem MY FRIEEEND ! " << std::endl;
                          }
                          response = 1;
                      }
                      else {
                        std::cout << "\033[1;31mPlease just write Yes or No at the QUESTION !!\033[0m  " << std::endl;
                      }
                }
                return (0);
        }
        }   
    }
     return (0);
}