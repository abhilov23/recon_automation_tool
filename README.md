# 🔍 Red Team Recon Script

An automated Bash script designed for red teaming. This tool performs reconnaissance tasks on a target domain, leveraging various popular tools to provide comprehensive information, including subdomains, WHOIS details, DNS records, and open ports.

---

## 📜 Features

- **WHOIS Lookup**: Fetch domain registration and ownership details.
- **DNS Enumeration**: Retrieve DNS records for the target domain.
- **Subdomain Discovery**: Identify subdomains using multiple tools:
  - Sublist3r
  - Subdomainer
  - Subfinder
  - Assetfinder
  - Amass
- **Port Scanning**: Detect open ports using `nmap`.
- **Output Management**: Saves organized results for easy review.
- **Combined Subdomains**: Consolidates results from all tools into a single file.
- **Interactive Help**: Displays all available options and commands.

---

## 🎯 Usage

### **1. Prerequisites**

Ensure the following tools are installed:

- **Sublist3r**:  
  ```bash
  pip install sublist3r

⚠️ Disclaimer
This script is intended for educational and ethical hacking purposes only. Use it responsibly and only on domains you own or have explicit permission to test.
