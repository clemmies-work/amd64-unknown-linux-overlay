#!/bin/bash

BTM_URL="https://github.com/ClementTsang/bottom/releases/download/nightly/bottom_aarch64-unknown-linux-gnu.tar.gz"
BTM_SRC_PATH="btm"
BTM_DST_PATH="usr/bin/"
RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-aarch64-unknown-linux-gnu.tar.gz"
RG_SRC_PATH="ripgrep-14.1.0-aarch64-unknown-linux-gnu/rg"
RG_DST_PATH="usr/bin/"
RSYNC_URL="https://github.com/jbruechert/rsync-static/releases/download/continuous/rsync-aarch64"
RSYNC_DST_PATH="usr/bin/"
OPENSSH_URL="https://output.circle-artifacts.com/output/job/b8abcdd8-bada-49f2-899e-eeb6d1c0cb24/artifacts/0/artifacts/openssh-aarch64.tgz"
OPENSSH_SRC_PATH="opt/openssh/libexec/sftp-server"
OPENSSH_DST_PATH="usr/libexec/"
PYTHON_URL="https://github.com/indygreg/python-build-standalone/releases/download/20240415/cpython-3.12.3+20240415-aarch64-unknown-linux-gnu-install_only.tar.gz"

WORKSPACE_DIR="workspace"
WORKSPACE_PREV_DIR="workspace_prev"
OVERLAY_DIR="overlay"

rm -rf "$WORKSPACE_DIR"
rm -rf "$WORKSPACE_PREV_DIR"

mkdir -p "$WORKSPACE_DIR"
pushd "$WORKSPACE_DIR" || exit

SOURCES_DIR="sources"
mkdir -p "$SOURCES_DIR"
pushd "$SOURCES_DIR" || exit
wget -O "openssh.tar.gz" "$OPENSSH_URL"
wget -O "btm.tar.gz" "$BTM_URL"
wget -O "rg.tar.gz" "$RG_URL"
wget -O "rsync" "$RSYNC_URL"
wget -O "python.tar.gz" "$PYTHON_URL"

tar xf "openssh.tar.gz" "$OPENSSH_SRC_PATH"
tar xf "btm.tar.gz" "$BTM_SRC_PATH"
tar xf "rg.tar.gz" "$RG_SRC_PATH"
chmod +x "rsync"
tar xf "python.tar.gz"
popd

mkdir -p "usr/bin"
mkdir -p "usr/libexec"

mv "$SOURCES_DIR/$OPENSSH_SRC_PATH" "$OPENSSH_DST_PATH/"
mv "$SOURCES_DIR/$BTM_SRC_PATH" "$BTM_DST_PATH/"
mv "$SOURCES_DIR/$RG_SRC_PATH" "$RG_DST_PATH/"
mv "$SOURCES_DIR/rsync" "$RSYNC_DST_PATH/"
rsync -auP "$SOURCES_DIR/python"/* "usr/"

rm -rf "$SOURCES_DIR"

popd

cp -R "$OVERLAY_DIR"/* "$WORKSPACE_DIR"
tar czvf rootfs.tar.gz "$WORKSPACE_DIR"/*
