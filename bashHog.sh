#!/bin/bash
NC='\033[0m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
GREEN='\033[0;32m'
# Handle Cases without target directory
if [ -z "$1" ]
	then
		echo -e "Usage bashHog.sh <Target Directory> <Output File>"
		echo -e "${RED}[-]Need at least a target directory to get started${NC}"
		echo -e "${YELLOW}[!]If you include an output file, content will be appended to that file after each query, read with \"less -r\" for colour${NC}"
		exit 1
fi

if [ "$1" == "-h" ]
	then
  		echo -e "Usage bashHog.sh <Target Directory> <Output File>"
		echo -e "${RED}[-]Need at least a target directory to get started${NC}"
		echo -e "${YELLOW}[!]If you include an output file, content will be appended to that file after each query, read with \"less -r\" for colour${NC}"
		exit 1
fi

if [ "$1" == "--help" ]
	then
		echo -e "Usage bashHog.sh <Target Directory> <Output File>"
		echo -e "${RED}[-]Need at least a target directory to get started${NC}"
		echo -e "${YELLOW}[!]If you include an output file, content will be appended to that file after each query, read with \"less -r\" for colour${NC}"
		exit 1
fi

# Read in queries from rules.txt
while IFS="" read -r line || [ -n "$line" ]
do
	echo -e "${YELLOW}[!]searching for ${line} in $1${NC}"
	if [ -z "$2" ]
		then
			grep --extended-regexp "$line" -I --no-messages --line-number --recursive $1 2>&-
		else
			echo -e "${YELLOW}[!]Results from ${line} in $1${NC}" >> $2
			grep --extended-regexp "$line" -I --no-messages --line-number --recursive $1 2>&- >> $2
			echo -e "${GREEN}[+]Wrote results to $2${NC}"
	fi
done < rules.txt
