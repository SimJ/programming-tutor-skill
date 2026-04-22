#!/usr/bin/env bash
# check_env.sh — programming-tutor skill
#
# 学習対象技術のランタイムが入っているかをまとめて確認するスクリプト。
# 使い方:
#   bash check_env.sh            # すべての共通ランタイムを確認
#   bash check_env.sh dotnet     # 指定カテゴリのみ
#
# 対応カテゴリ: node, python, dotnet, java, rust, go, all (デフォルト)

set -u

TARGET="${1:-all}"

# 色つき出力（対応していなければ空文字）
if [ -t 1 ]; then
  GREEN='\033[0;32m'
  RED='\033[0;31m'
  YELLOW='\033[0;33m'
  CYAN='\033[0;36m'
  NC='\033[0m'
else
  GREEN=''
  RED=''
  YELLOW=''
  CYAN=''
  NC=''
fi

check_cmd() {
  local label="$1"
  local cmd="$2"
  local version_flag="$3"

  if command -v "$cmd" >/dev/null 2>&1; then
    local ver
    ver="$("$cmd" "$version_flag" 2>&1 | head -n 1)"
    printf "${GREEN}✓${NC} %-16s %s\n" "$label" "$ver"
  else
    printf "${RED}✗${NC} %-16s not installed\n" "$label"
  fi
}

check_node() {
  echo -e "${CYAN}[Node.js / NestJS / React]${NC}"
  check_cmd "node"  node  --version
  check_cmd "npm"   npm   --version
  command -v pnpm >/dev/null 2>&1 && check_cmd "pnpm" pnpm --version
  command -v yarn >/dev/null 2>&1 && check_cmd "yarn" yarn --version
  echo
}

check_python() {
  echo -e "${CYAN}[Python]${NC}"
  if command -v python3 >/dev/null 2>&1; then
    check_cmd "python3" python3 --version
  else
    check_cmd "python" python --version
  fi
  check_cmd "pip3" pip3 --version || check_cmd "pip" pip --version
  echo
}

check_dotnet() {
  echo -e "${CYAN}[.NET / C#]${NC}"
  check_cmd "dotnet" dotnet --version
  echo
}

check_java() {
  echo -e "${CYAN}[Java / Spring Boot]${NC}"
  check_cmd "java"   java   --version
  check_cmd "javac"  javac  --version
  command -v mvn    >/dev/null 2>&1 && check_cmd "mvn"    mvn    --version
  command -v gradle >/dev/null 2>&1 && check_cmd "gradle" gradle --version
  echo
}

check_rust() {
  echo -e "${CYAN}[Rust]${NC}"
  check_cmd "rustc" rustc --version
  check_cmd "cargo" cargo --version
  echo
}

check_go() {
  echo -e "${CYAN}[Go]${NC}"
  check_cmd "go" go version
  echo
}

check_common() {
  echo -e "${CYAN}[Common]${NC}"
  check_cmd "git"  git  --version
  check_cmd "code" code --version
  echo
}

echo "=== programming-tutor environment check ==="
echo

case "$TARGET" in
  node)   check_node ;;
  python) check_python ;;
  dotnet) check_dotnet ;;
  java)   check_java ;;
  rust)   check_rust ;;
  go)     check_go ;;
  all)
    check_common
    check_node
    check_python
    check_dotnet
    check_java
    check_rust
    check_go
    ;;
  *)
    echo -e "${YELLOW}Unknown target: $TARGET${NC}"
    echo "Use one of: node, python, dotnet, java, rust, go, all"
    exit 1
    ;;
esac

echo "Done."
