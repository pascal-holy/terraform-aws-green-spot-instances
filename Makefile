# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: cfabian <cfabian@student.42wolfsburg.de>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/08/01 11:39:00 by cfabian           #+#    #+#              #
#    Updated: 2022/08/01 12:40:04 by cfabian          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = aws-green-spot
SRC_DIRS = .
SRCS = $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.go))
red=\033[0;31m
ccyellow=$(shell echo -e "\033[0;33m")
end=\033[0m

#handle different systems
OS = $(shell uname | tr '[:upper:]' '[:lower:]')

all: $(NAME)

main.go:
	@echo "$(red)Couldn't find main.go$(end)"

$(NAME): main.go
	GOARCH=amd64 GOOS=$(OS) go build -o $(NAME) main.go

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
	golangci-lint run

test: lint

#dep:
#	go mod download

# add .PHONY so that the non-targetfile - rules work even if a file with the same name exists.
.PHONY: all clean fclean lint test re
