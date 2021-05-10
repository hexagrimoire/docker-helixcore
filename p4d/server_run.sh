#!/bin/bash
p4dctl start ${1} 
p4 info

#おまじない…
less -f /dev/null
