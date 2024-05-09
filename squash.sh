#!/bin/bash

OUTPUT_DIR="output"
WORKSPACE_DIR="workspace"

COMPRESSION="zstd"

rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

mksquashfs "$WORKSPACE_DIR" "$OUTPUT_DIR/rootfs.sqsh" -comp "$COMPRESSION"
