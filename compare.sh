#!/bin/bash

if which ramon &>/dev/null; then
	PAR=true  ramon -o log_par.ramon ./sc.sh
	PAR=false ramon -o log_seq.ramon ./sc.sh

	ramon-render.py log_par.ramon
	ramon-render.py log_seq.ramon
else
	PAR=true  time -o log_par.ramon ./sc.sh
	PAR=false time -o log_seq.ramon ./sc.sh

	echo Sharing:
	cat log_par.ramon
	echo Nonsharing:
	cat log_seq.ramon
fi
