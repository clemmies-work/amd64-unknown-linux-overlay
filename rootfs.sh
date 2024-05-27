#!/bin/bash

BTM_URL="https://github.com/ClementTsang/bottom/releases/download/nightly/bottom_x86_64-unknown-linux-gnu.tar.gz"
BTM_SRC_PATH="btm"
BTM_DST_PATH="usr/bin/"
RG_URL="https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz"
RG_SRC_PATH="ripgrep-14.1.0-x86_64-unknown-linux-musl/rg"
RG_DST_PATH="usr/bin/"


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
wget -O "btm.tar.gz" "$BTM_URL"
wget -O "rg.tar.gz" "$RG_URL"

tar xf "btm.tar.gz" "$BTM_SRC_PATH"
tar xf "rg.tar.gz" "$RG_SRC_PATH"
popd || exit

mkdir -p "usr/bin"
mkdir -p "usr/libexec"

mv "$SOURCES_DIR/$BTM_SRC_PATH" "$BTM_DST_PATH/"
mv "$SOURCES_DIR/$RG_SRC_PATH" "$RG_DST_PATH/"

rm -rf "$SOURCES_DIR"

popd || exit

cp -R "$OVERLAY_DIR"/* "$WORKSPACE_DIR"
