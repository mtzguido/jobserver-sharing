#!/bin/bash

N=$((100000 * $1))
while [ $N -gt 0 ]; do
	N=$((N-1))
done

exit 0
