#!/usr/bin/env bash
# 公開ドメイン（と任意で問い合わせメール）を一括置換するヘルパー
#   使い方:  ./set-domain.sh <ドメイン> [メールアドレス]
#   例:      ./set-domain.sh example-apps.pages.dev
#            ./set-domain.sh example.com contact@example.com
#            ./set-domain.sh username.github.io/repo-name
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "使い方: ./set-domain.sh <ドメイン> [メールアドレス]" >&2
  exit 1
fi

DOMAIN="${1#http://}"; DOMAIN="${DOMAIN#https://}"; DOMAIN="${DOMAIN%/}"
EMAIL="${2:-}"
DIR="$(cd "$(dirname "$0")" && pwd)"

FILES=(index.html sitemap.xml robots.txt)
for f in "${FILES[@]}"; do
  perl -pi -e "s{REPLACE-WITH-YOUR-DOMAIN}{$DOMAIN}g" "$DIR/$f"
done
echo "ドメインを設定しました: https://$DOMAIN/"

if [ -n "$EMAIL" ]; then
  perl -pi -e "s{REPLACE-WITH-YOUR-EMAIL}{$EMAIL}g" "$DIR/index.html"
  echo "問い合わせメールを設定しました: $EMAIL"
else
  echo "（メール未指定：フッターの REPLACE-WITH-YOUR-EMAIL は手動で編集/削除してください）"
fi

REMAIN=$(grep -rl "REPLACE-WITH-YOUR" "$DIR" --include='*.html' --include='*.xml' --include='*.txt' || true)
[ -n "$REMAIN" ] && echo "まだ置換が残っているファイル:" && echo "$REMAIN"
echo "完了。"
