#!/bin/bash

# taking the inputs
domain=$1
output_dir=""
subdomains_dir=""

# Interface of the sustem
show_interface() {
    echo "==========================================="
    echo "          🔍 RED TEAM RECON SCRIPT         "
    echo "==========================================="
    echo "Author  : Abhilov"
    echo "Purpose : Automate reconnaissance for red teaming"
    echo "==========================================="
}

# Display Help Menu
show_help() {
    echo ""
    echo "Usage: $0 <domain> [options]"
    echo ""
    echo "Options:"
    echo "  -h, --help                Show this help message"
    echo "  -d, --domain <domain>     Specify the target domain"
    echo "  -s, --subdomains          Perform subdomain discovery using all tools"
    echo "  -p, --ports               Perform port scanning"
    echo "  -w, --whois               Perform WHOIS lookup"
    echo "  -c, --combine             Combine subdomains from all tools"
    echo "  -a, --all                 Run all recon tasks"
    echo ""
}

# Function to set up directories
setup_directories() {
    echo "Setting up directories..."
    output_dir="recon_results/$domain"
    subdomains_dir="$output_dir/subdomains"
    mkdir -p $subdomains_dir
    echo "Directories created at: $output_dir"
}

# WHOIS Lookup
whois_lookup() {
    echo "Performing WHOIS lookup..."
    whois $domain > "$output_dir/whois.txt"
    echo "WHOIS results saved to $output_dir/whois.txt"
}

# DNS Enumeration
dns_enum() {
    echo "Performing DNS enumeration..."
    dig $domain any > "$output_dir/dns.txt"
    host $domain >> "$output_dir/dns.txt"
    echo "DNS enumeration results saved to $output_dir/dns.txt"
}

# Sublist3r Subdomain Discovery
sublist3r_enum() {
    echo "Running Sublist3r..."
    sublist3r -d $domain -o "$subdomains_dir/sublist3r.txt"
    echo "Sublist3r results saved to $subdomains_dir/sublist3r.txt"
}

# Subdomainer Subdomain Discovery
subdomainer_enum() {
    echo "Running Subdomainer..."
    python3 SubDomainer.py -d $domain -o "$subdomains_dir/subdomainer.txt"
    echo "Subdomainer results saved to $subdomains_dir/subdomainer.txt"
}

# Subfinder Subdomain Discovery
subfinder_enum() {
    echo "Running Subfinder..."
    subfinder -d $domain -o "$subdomains_dir/subfinder.txt"
    echo "Subfinder results saved to $subdomains_dir/subfinder.txt"
}

# Assetfinder Subdomain Discovery
assetfinder_enum() {
    echo "Running Assetfinder..."
    assetfinder --subs-only $domain > "$subdomains_dir/assetfinder.txt"
    echo "Assetfinder results saved to $subdomains_dir/assetfinder.txt"
}

# Amass Subdomain Discovery
amass_enum() {
    echo "Running Amass..."
    amass enum -d $domain -o "$subdomains_dir/amass.txt"
    echo "Amass results saved to $subdomains_dir/amass.txt"
}

# Port Scanning
port_scan() {
    echo "Scanning open ports..."
    nmap -Pn -p- $domain > "$output_dir/ports.txt"
    echo "Port scan results saved to $output_dir/ports.txt"
}

# Combine Subdomains from Tools
combine_subdomains() {
    echo "Combining and sorting subdomains..."
    cat "$subdomains_dir"/*.txt | sort -u > "$output_dir/all_subdomains.txt"
    echo "Combined subdomains saved to $output_dir/all_subdomains.txt"
}

# executing the main function
main() {
    show_interface

    # passing all the cli arguments 
    case $2 in
        -h|--help)
            show_help
            ;;
        -s|--subdomains)
            setup_directories
            sublist3r_enum
            subdomainer_enum
            subfinder_enum
            assetfinder_enum
            amass_enum
            ;;
        -p|--ports)
            setup_directories
            port_scan
            ;;
        -w|--whois)
            setup_directories
            whois_lookup
            ;;
        -c|--combine)
            setup_directories
            combine_subdomains
            ;;
        -a|--all)
            setup_directories
            whois_lookup
            dns_enum
            sublist3r_enum
            subdomainer_enum
            subfinder_enum
            assetfinder_enum
            amass_enum
            combine_subdomains
            port_scan
            ;;
        *)
            echo "Invalid option! Use -h or --help for usage instructions."
            ;;
    esac
}


if [ -z "$domain" ]; then #checking if the domain is provided
    show_interface
    echo "Error: Domain not specified!"
    show_help
    exit 1
fi


main $@ #calling the main function using the arguments
