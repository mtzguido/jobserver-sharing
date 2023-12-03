SHELL=/bin/bash

all: $(patsubst %,j-%, $(shell seq 1 20))

FAC?=1

j-%:
	@N=$$(echo $@ | sed 's/j-//') && FAC=$(FAC) && ./waste.sh $$((${FAC} * $$N))
	@echo "done: $@-$(FAC)"
