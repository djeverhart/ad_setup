import os
import subprocess
import pam

p = pam.pam()

def authenticate(username):
    return p.authenticate(username, "")

def main():
    username = os.getenv('PAM_USER')
    if not username or username in ["sddm", "lightdm", "cnadmin", "root"]:
        return

    if authenticate(username):
        subprocess.run(['sudo', 'rm', '-f', '/etc/resolv.conf'])
        with open('/etc/resolv.conf', 'w') as f:
            f.write("nameserver 10.8.10.100\n")

        with open('/opt/test.log', 'a') as f:
            f.write(f"admins {username}\n")

        subprocess.run(['sudo', 'usermod', '-aG', 'admins', username])
        subprocess.run(['sshpass', '-p', 'Snowsuit9-Breath0-Karaoke7-Frightful3', 'ssh', 'fowner@10.8.10.199', f'mkdir -p /mnt/Primary/Users/{username}'])
        subprocess.run(['sudo', 'umount', '/mnt/Sync'])
        subprocess.run(['sudo', 'mount', '-t', 'cifs', f'//10.8.10.199/Users/{username}', '/mnt/Sync', '-o', 'username=fowner,password=Snowsuit9-Breath0-Karaoke7-Frightful3,file_mode=0777,dir_mode=0777'], stderr=subprocess.PIPE)

if __name__ == "__main__":
    main()
