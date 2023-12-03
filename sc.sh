#!/bin/bash

rm -f pipe
mkfifo pipe
exec 100<>pipe

J=${J:-$(nproc)}
PAR=${PAR:-true}

echo "J=$J"
echo "PAR=$PAR"

take () {
	while ! read -n1 <&100 2>/dev/null; do
		sleep 1
	done
}

put () {
	echo -n '+' >&100
}

export MAKEFLAGS="-j${J}"

if ${PAR}; then
	for i in $(seq 1 ${J}); do
		echo -n '+' > pipe
	done
	export MAKEFLAGS="${MAKEFLAGS} --jobserver-fds=100,100"
fi

for n in $(seq 1 16); do
	if ${PAR}; then
		take
		(make FAC=$n ; rc=$?; put; exit $rc) &
	else
		make FAC=$n
	fi
done

wait
