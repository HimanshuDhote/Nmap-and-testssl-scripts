#!/bin/bash
# Author : Himanshu Dhote

echo "
=====================================================
=                                                   =
=    The Http Headers,clickjacking, cookies Tester  =
=                                                   =  
=                -By Himanshu Dhote                 = 
====================================================="

read -p 'Enter Target Address:' target

url="$target"  # Replace with the URL of the website you want to test

response=$(curl -sSL -D - "$url" -o /dev/null)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'
# Check X-Frame-Options header
echo -e "${YELLOW}Result for Clickjacking:.${NC}"
if grep -q -i "X-Frame-Options" <<< "$response"; then
    echo -e "X-Frame-Options header is ${GREEN}present${NC}. Website is protected against clickjacking."
else
    echo -e  "X-Frame-Options header is ${RED}missing${NC}. Website may be vulnerable to clickjacking."
fi
# Check Content-Security-Policy header
if grep -q -i "Content-Security-Policy" <<< "$response"; then
    echo -e "Content-Security-Policy header is ${GREEN}present${NC}. Website is protected against clickjacking."
else
    echo -e "Content-Security-Policy header is ${RED}missing${NC}. Website may be vulnerable to clickjacking."
fi

echo -e "${BLUE}======================================================================================================================${NC}"

# check Http Headers implemented
echo -e "${YELLOW}Result for Which HTTP Headers are Implemented:.${NC}"
headers=$(curl -sSL -D - "$url" -o /dev/null)

echo -e "HTTP Headers for ${GREEN}$url:${NC}"
echo "$headers"

echo -e "${BLUE}======================================================================================================================${NC}"

# check cookies names used in web application
echo -e "${YELLOW}Result for Cookies Names:.${NC}"
response_headers=$(curl -sSL -D - "$url" -o /dev/null)
echo -e "${GREEN}Cookie names found in the response headers:${NC}"
echo -e "${GREEN}$response_headers${NC}" | grep -i "Set-Cookie" | awk -F'[:;]' '{print $2}'

# Check cookies Flag
echo -e "${BLUE}======================================================================================================================${NC}"
echo -e "${YELLOW}Result for cookies Flag is set:.${NC}"
cookie_name="$response_headers"  

response_headers=$(curl -sSL -D - "$url" -o /dev/null)

#echo -e "${BLUE}======================================================================================================================${NC}"

# Check if the cookie flag is set in the response headers
if grep -q -i "${cookie_name};[[:space:]]*Secure" <<< "$response_headers"; then
    echo -e "${GREEN}The Secure flag is set for the cookie${NC} ${cookie_name}."
else
    echo -e "${GREEN}The Secure flag is not set for the cookie${NC} ${cookie_name}."
fi

if grep -q -i "${cookie_name};[[:space:]]*HttpOnly" <<< "$response_headers"; then
    echo -e "${GREEN}The HttpOnly flag is set for the cookie${NC} ${cookie_name}."
else
    echo -e "The HttpOnly flag is not set for the cookie${NC} ${cookie_name}."
fi


