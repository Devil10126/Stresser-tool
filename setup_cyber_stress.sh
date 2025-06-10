#!/data/data/com.termux/files/usr/bin/bash

echo -e "\033[1;36m[*] Starting Cyber Stress Tool Setup...\033[0m"

pkg update -y && pkg upgrade -y

echo -e "\033[1;32m[+] Installing dependencies...\033[0m"
pkg install -y tor tsocks clang net-tools iproute2 nc jq || {
    echo -e "\033[1;31m[!] Failed to install packages. Trying again...\033[0m"
    sleep 2
    pkg install -y tor tsocks clang net-tools iproute2 nc jq
}

echo -e "\033[1;36m[*] Configuring tsocks...\033[0m"
mkdir -p ~/.termux
cat > ~/.tsocks.conf <<EOF
server = 127.0.0.1
server_type = 5
server_port = 9050
EOF

echo -e "\033[1;32m[+] Starting Tor service...\033[0m"
(pkill tor || true) && tor &

echo -e "\033[1;33m[!] Optional: For identity rotation, edit ~/.torrc and enable ControlPort & password.\033[0m"
echo -e "\033[1;33m    Add this to ~/.torrc:\033[0m"
echo "ControlPort 9051"
echo "HashedControlPassword <your-hashed-password>"

echo -e "\033[1;32m[✔] Setup complete. You can now compile and run the cyber_stress_tor tool.\033[0m"
echo -e "\033[1;34mUse: tsocks ./cyber_stress_tor\033[0m"
