#!/bin/bash

echo "Select Component"
echo "1) INGESTOR"
echo "2) JOINER"
echo "3) WRANGLER"
echo "4) VALIDATOR"
read choice 

case $choice in 
    1) comp="INGESTOR" ;;
    2) comp="JOINER" ;;
    3) comp="WRANGLER" ;;
    4) comp="VALIDATOR" ;;
    *) echo "Invalid choice"; exit 1 ;;
esac

echo "Selected: $comp"


echo "Select Scale"
echo "1) MID"
echo "2) HIGH"
echo "3) LOW"
read choice

case $choice in 
    1) scale="MID" ;;
    2) scale="HIGH" ;;
    3) scale="LOW" ;;
    *) echo "Invalid choice"; exit 1 ;;
esac

echo "Selected: $scale"


echo "Select View"
echo "1) Auction"
echo "2) Bid" 
read choice

case $choice in 
    1) view="Auction" ;;
    2) view="Bid" ;;
    *) echo "Invalid choice"; exit 1 ;;
esac

echo "Selected: $view"


read -p "Enter Count (0-9): " count

case $count in
    [0-9]) ;;
    *) echo "Invalid count"; exit 1 ;;
esac


# View mapping
case $view in
    Auction) view_name="vdopiasample" ;;
    Bid) view_name="vdopiasample-bid" ;;
esac


# Create new line
new_line="$view_name ; $scale ; $comp ; ETL ; vdopia-etl=$count"

echo "New line will be:"
echo "$new_line"


# File check
FILE="sig.conf"

if [ ! -f "$FILE" ]; then
    echo "Error: $FILE not found!"
    exit 1
fi


# Update only first ETL line
sed -i "0,/ETL/s/.*/$new_line/" "$FILE"

echo "File updated successfully!"
