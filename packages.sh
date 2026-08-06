#!/usr/bin/env bash

set -euo pipefail

# ---- Versions ----
GO_VERSION="1.26.3"
ZIG_VERSION="0.15.2"
LLVM_VERSION="22.1.4"
NVIM_VERSION="0.12.3"
JSON_TUI_VERSION="1.4.1"
ARM_VERSION="15.2"
PROTOBUF_VERSION="3.20.3"

ROOT_DIR="$(pwd)"
PKG_DIR="$ROOT_DIR/packages"
INSTALL_DIR="/usr/local"

mkdir -p "$PKG_DIR"
cd "$PKG_DIR"

download_and_extract() {
	local url="$1"
	local archive="$2"

	if [ ! -f "$archive" ]; then
		wget -q --show-progress "$url"
	fi

	case "$archive" in
	*.tar.gz) tar -xzf "$archive" ;;
	*.tar.xz) tar -xf "$archive" ;;
	*.zip) mkdir "${archive%.*}" && cd "${archive%.*}" && unzip "../$archive" && cd .. ;;
	*) echo "Unknown archive format: $archive" && exit 1 ;;
	esac

	rm "$archive"
}

# ---- Go ----
GO_DIR_VER="go-v${GO_VERSION}"
if [ ! -d "$GO_DIR_VER" ]; then
	download_and_extract \
		"https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" \
		"go${GO_VERSION}.linux-amd64.tar.gz"

	mv "go" "$GO_DIR_VER"
	sudo ln -s "$(pwd)/$GO_DIR_VER" "$INSTALL_DIR/go"
fi

# ---- Zig ----
ZIG_DIR="zig-x86_64-linux-${ZIG_VERSION}"
if [ ! -d "$ZIG_DIR" ]; then
	download_and_extract \
		"https://ziglang.org/download/${ZIG_VERSION}/${ZIG_DIR}.tar.xz" \
		"${ZIG_DIR}.tar.xz"

	sudo ln -s "$(pwd)/$ZIG_DIR/zig" "$INSTALL_DIR/bin/zig"
fi

# ---- LLVM ----
LLVM_DIR="LLVM-${LLVM_VERSION}-Linux-X64"
if [ ! -d "$LLVM_DIR" ]; then
	download_and_extract \
		"https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/${LLVM_DIR}.tar.xz" \
		"${LLVM_DIR}.tar.xz"

	sudo ln -s "$(pwd)/$LLVM_DIR/bin/clang" "$INSTALL_DIR/bin/clang"
	sudo ln -s "$(pwd)/$LLVM_DIR/bin/clang++" "$INSTALL_DIR/bin/clang++"
	sudo ln -s "$(pwd)/$LLVM_DIR/bin/clangd" "$INSTALL_DIR/bin/clangd"
	sudo ln -s "$(pwd)/$LLVM_DIR/bin/clang-format" "$INSTALL_DIR/bin/clang-format"
	sudo ln -s "$(pwd)/$LLVM_DIR/bin/clang-scan-deps" "$INSTALL_DIR/bin/clang-scan-deps"
fi

# ---- Neovim ----
NVIM_DIR="nvim-linux-x86_64"
NVIM_DIR_VER="nvim-linux-x86_64-v${NVIM_VERSION}"
if [ ! -d "$NVIM_DIR_VER" ]; then
	download_and_extract \
		"https://github.com/neovim/neovim/releases/download/v${NVIM_VERSION}/${NVIM_DIR}.tar.gz" \
		"${NVIM_DIR}.tar.gz"

	mv "$NVIM_DIR" "$NVIM_DIR_VER"
	sudo ln -s "$(pwd)/$NVIM_DIR_VER/bin/nvim" "$INSTALL_DIR/bin/nvim"
fi

# ---- json-tui ----
JSON_TUI_DIR="json-tui-${JSON_TUI_VERSION}-Linux"
if [ ! -d "$JSON_TUI_DIR" ]; then
	download_and_extract \
		"https://github.com/ArthurSonzogni/json-tui/releases/download/v${JSON_TUI_VERSION}/${JSON_TUI_DIR}.tar.gz" \
		"${JSON_TUI_DIR}.tar.gz"

	sudo ln -s "$(pwd)/$JSON_TUI_DIR/bin/json-tui" "$INSTALL_DIR/bin/json-tui"
fi

# ---- arm none eabi gnu toolchain ----
ARM_DIR="arm-gnu-toolchain-${ARM_VERSION}.rel1-x86_64-arm-none-eabi"
if [ ! -d "$ARM_DIR" ]; then
	download_and_extract \
		"https://developer.arm.com/-/media/Files/downloads/gnu/${ARM_VERSION}.rel1/binrel/${ARM_DIR}.tar.xz" \
		"${ARM_DIR}.tar.xz"

	sudo ln -s "$(pwd)/$ARM_DIR/bin/arm-none-eabi-g++" "$INSTALL_DIR/bin/arm-none-eabi-g++"
	sudo ln -s "$(pwd)/$ARM_DIR/bin/arm-none-eabi-gcc" "$INSTALL_DIR/bin/arm-none-eabi-gcc"
	sudo ln -s "$(pwd)/$ARM_DIR/bin/arm-none-eabi-objcopy" "$INSTALL_DIR/bin/arm-none-eabi-objcopy"
	sudo ln -s "$(pwd)/$ARM_DIR/bin/arm-none-eabi-objdump" "$INSTALL_DIR/bin/arm-none-eabi-objdump"
	sudo ln -s "$(pwd)/$ARM_DIR/bin/arm-none-eabi-size" "$INSTALL_DIR/bin/arm-none-eabi-size"
fi

PROTOC_DIR="protoc-${PROTOBUF_VERSION}-linux-x86_64"
if [ ! -d "$PROTOC_DIR" ]; then
	download_and_extract \
		"https://github.com/protocolbuffers/protobuf/releases/download/v${PROTOBUF_VERSION}/${PROTOC_DIR}.zip" \
		"${PROTOC_DIR}.zip"

	sudo ln -s "$(pwd)/$PROTOC_DIR/bin/protoc" "$INSTALL_DIR/bin/protoc"
	sudo ln -s "$(pwd)/$PROTOC_DIR/include/google" "$INSTALL_DIR/include/google"
fi

echo "✅ All tools installed successfully"
