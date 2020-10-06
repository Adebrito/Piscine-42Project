.PHONY: re all clean fclean

CPP= clang++ -std=c++11

NAME = avm

INC     = -I include

SRC = src/Error.cpp \
                src/Parser.cpp \
				src/OperandFactory.cpp \
				src/Exec.cpp \
				src/main.cpp 

OBJ     = $(SRC:%.cpp=%.o)

FLAG = -Wall -Werror -Wextra

all: $(NAME)

$(NAME): $(OBJ)
		@$(CPP) -o $@ $^ $(INC) $(FLAG)

%.o: %.cpp
		@$(CPP) -o $@ -c $< $(INC) $(FLAG)

clean:
		@rm -fr $(OBJ)

fclean: clean
		@rm -rf $(NAME) 

re: fclean all%   