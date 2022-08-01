# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cfabian <cfabian@student.42wolfsburg.de>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/01 11:39:00 by cfabian           #+#    #+#              #
#    Updated: 2022/08/01 12:21:41 by cfabian          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = aws-green-spot
SRC = main.go
red=\033[0;31m
ccyellow=$(shell echo -e "\033[0;33m")
end=\033[0m

#handle different systems
OS = $(shell uname | tr '[:upper:]' '[:lower:]')

all: $(NAME)

$(SRC):
	@echo "$(red)Couldn't find $(SRC)$(end)"

$(NAME): $(SRC)
	GOARCH=amd64 GOOS=$(OS) go build -o $(NAME) $(SRC)

run: $(NAME)
	./$(NAME)

clean:
	go clean

fclean: clean
	$(RM) $(NAME)

re: clean all

format:
	gofmt -w $(SRC)

lint:
	golangci-lint run --enable-all

test: lint

#dep:
#	go mod download

# add .PHONY so that the non-targetfile - rules work even if a file with the same name exists.
.PHONY: all clean fclean lint test re
