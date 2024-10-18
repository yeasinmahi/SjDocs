#!/bin/bash

# MySQL connection details
MYSQL_USER="s3dbuser"
MYSQL_PASSWORD="S3@dpdhl"
MYSQL_DATABASE="dpdhl_db"

# Path to the text file containing client names
CLIENT_NAMES_FILE="client_names2.txt"

# Read the date in YYYYMMDD format from command-line argument
input_date="$1"

input_timestamp=$(date -d "$input_date" +%s)
tomorrow_timestamp=$(date -d "$tomorrow" +%s)

# Check if the date argument is provided
if [[ -z $input_date ]]; then
    echo "Date argument (YYYYMMDD) is missing."
    exit 1
# Check if the command argument is more than one
elif  [ $# -gt 1 ]; then
    echo "The command has more than one argument."
    exit 1
# Check if the input is valid
elif  [ -z "$input_timestamp" ]; then
    exit 1
# Check if the input is existing date or not
elif  ((input_timestamp > tomorrow_timestamp)); then
    echo "The input date is tomorrow or later."
    exit 1
fi

# Convert the date format from YYYYMMDD to YYYY-MM-DD
formatted_date="${input_date:0:4}-${input_date:4:2}-${input_date:6:2}"

# Read client names from the text file
mapfile -t client_names < "$CLIENT_NAMES_FILE"

echo
#echo "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
echo "----------------------------------------------------------------------"
echo "|                        Daily Report                                |"
echo "----------------------------------------------------------------------"

#echo "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
echo "| Sr. No  |  Token (Represent the node)  | # of message processed    |"
echo "----------------------------------------------------------------------"

# Determine the maximum length of the client names
max_length=0

# Iterate over client names and find the maximum length
for name in "${client_names[@]}"; do
    length=${#name}
    if ((length > max_length)); then
        max_length=$length
    fi
done

# Define the format for the client name column
name_format="%-${max_length}s"  # Fixed width for the client name column

# Iterate over client names and display the index along with the result
for ((index=0; index<${#client_names[@]}; index++))
do
    client_name="${client_names[index]}"

    # MySQL query
    QUERY="SELECT COUNT(token) FROM dt_responsetokens WHERE createdate LIKE '$formatted_date%' AND filename LIKE '%$client_name%'"

    # Suppress the MySQL warning for using a password in the command
    export MYSQL_PWD="$MYSQL_PASSWORD"

    # Execute the MySQL command and capture the result (redirecting error output to /dev/null)
    result=$(mysql -u "$MYSQL_USER" -D "$MYSQL_DATABASE" -se "$QUERY" 2>/dev/null)


    # Convert result to integer
    result=$((result))
#echo "$total_count"
    # Print the index, client name, and total tokens with aligned columns
    printf "|  %3d    |  $name_format                      |  %-24d |\n" "$((index+1))" ""$(echo "$client_name" | tr '[:lower:]' '[:upper:]' | cut -c 1-3)"" "$result"

    # Add the current count to the total count
    total_count=$((total_count + result))

done
echo "----------------------------------------------------------------------"
printf "|    Date: %-17s           Total Processed: %-11d  |\n" "$formatted_date" "$total_count"
echo "----------------------------------------------------------------------"

#echo "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII"
echo