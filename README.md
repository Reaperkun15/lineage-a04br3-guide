# LineageOS 14.1 for TAB-A04-BR3 Build guide

## 1. 前提条件
- Windows 10 22H2 以上
- DDR3 16GB 以上            
- i5-4690, i7-4790　程度の少なくとも4コアCPU
- 500GB~1TBのSSD　またはHDD

## 2. 必要OS
- [Ubuntu 16.04 LTS](https://releases.ubuntu.com/16.04/ubuntu-16.04.7-desktop-amd64.iso)
- Virtualbox 7.2.18 以上

## 3. 必要パッケージ
```
sudo apt install autoconf automake bc bison build-essential curl flex g++ g++-multilib gawk gcc gcc-multilib git-core gnupg gperf imagemagick lib32ncurses5-dev lib32readline6-dev lib32z1-dev libc6-dev libesd0-dev libexpat1-dev liblz4-1 liblz4-tool liblzma5 liblzma-dev libncurses5-dev libsdl1.2-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop maven openjdk-8-jdk openjdk-8-jre patch pkg-config pngcrush python schedtool squashfs-tools texinfo xsltproc zip zlib1g-dev python python3
```

## 4. 設定

```
mkdir ~/bin -p
mkdir ~/lineage-builder -p

curl https://storage.googleapis.com/git-repo-downloads/repo-1 > ~/bin/repo

sudo cp /etc/java-8-openjdk/security/java.security{,.bak}

sudo sed -i 's/, TLSv1, TLSv1.1//g; s/TLSv1, TLSv1.1, //g' /etc/java-8-openjdk/security/java.security

git config --global user.name "android"
git config --global user.email "android"


```

## 5. ソースコードの取得

```
yes y | sh -c 'repo init -u https://github.com/LineageOS/android.git -b cm-14.1 --depth=1'
repo sync -j"$(nproc)" -f --force-sync --no-clone-bundle