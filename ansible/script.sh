#/bin/bash
sudo apt update
sudo apt install -y python3-pip python3-venv bash-completion
source /etc/profile.d/bash_completion.sh

cd ./ansible
python3 -m venv py3_env
source py3_env/bin/activate

pip install -r requirements.txt

ansible control_plan -m ping -vv