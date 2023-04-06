#!/bin/sh
if command -v doas >> /dev/null; then
  root=doas
else 
  root=sudo
fi



if [ "$(uname)" == "Darwin" ]; then
  curl -L "https://github.com/pine64/blisp/releases/download/v0.0.3/blisp-macos64-v0.0.3.zip" -o "blisp-macos64-v0.0.3.zip"
  unzip "blisp-macos64-v0.0.3.zip"
  $root cp ./blisp /usr/bin/blisp
else if [ "$(uname -m)" == "x86_64" ]
  curl -L "https://github.com/pine64/blisp/releases/download/v0.0.3/blisp-linux64-v0.0.3.zip" -o "blisp-linux64-v0.0.3.zip"
  unzip "blisp-linux64-v0.0.3.zip"
  $root cp ./blisp /usr/bin/blisp
  $root cp ./Pineflash.desktop /usr/share/applications/Pineflash.desktop
  $root cp ./assets/pine64logo.png /usr/share/pixmaps/pine64logo.png
else 
  git clone --recursive "https://github.com/pine64/blisp.git"
  cd blisp
  git submodule update --init --recursive
  mkdir build && cd build
  cmake -DBLISP_BUILD_CLI=ON ..
  cmake --build .
  $root cp ./blisp/build/tools/blisp/blisp /usr/bin/blisp
  cd ../..
  $root cp ./Pineflash.desktop /usr/share/applications/Pineflash.desktop
  $root cp ./assets/pine64logo.png /usr/share/pixmaps/pine64logo.png

fi


$root cp ./target/release/pineflash /usr/bin/pineflash
