# 1. Nix 데몬 중지
sudo launchctl unload /Library/LaunchDaemons/org.nixos.nix-daemon.plist
sudo rm /Library/LaunchDaemons/org.nixos.nix-daemon.plist

# 2. nixbld 그룹/유저 삭제
sudo dscl . -delete /Groups/nixbld
for u in $(sudo dscl . -list /Users | grep _nixbld); do
  sudo dscl . -delete /Users/$u
done

# 3. Nix 관련 파일 삭제
sudo rm -rf /nix
sudo rm -rf /etc/nix
sudo rm -rf ~/.nix-profile
sudo rm -rf ~/.nix-defexpr
sudo rm -rf ~/.nix-channels
sudo rm -rf ~/.config/nix

# 4. /etc 파일 복원
sudo rm /etc/bashrc /etc/zshrc
sudo mv /etc/bashrc.backup-before-nix /etc/bashrc
sudo mv /etc/zshrc.backup-before-nix /etc/zshrc

# 5. fstab에서 nix 항목 제거 (있다면)
sudo vifs
# /nix 관련 줄 삭제 후 :wq
