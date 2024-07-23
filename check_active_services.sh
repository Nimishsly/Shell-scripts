#!/bin/bash

# Output file for active services
OUTPUT_FILE="active_services.txt"

# Get all active systemd services
if ! active_services=$(systemctl list-units --type=service --state=active --no-pager); then
    echo "Failed to retrieve active services."
    exit 1
fi

# Create or clear the output file
true > "$OUTPUT_FILE"

# Format the output
{
    echo "Active systemd Services"
    echo "======================="
    printf "%-50s %-10s %-10s %-40s\n" "SERVICE NAME" "LOAD" "ACTIVE" "DESCRIPTION"
    echo "======================================================================================================================"
    echo "$active_services" | awk 'NR>1 { printf "%-50s %-10s %-10s %-40s\n", $1, $2, $3, substr($0, index($0,$4)) }'
} >> "$OUTPUT_FILE"

# Display the active services
cat "$OUTPUT_FILE"

# Summary message
echo "Active systemd services have been saved to $OUTPUT_FILE"
