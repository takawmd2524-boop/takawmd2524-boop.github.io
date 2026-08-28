# 道場シリーズ 宣伝サイト

TAKAHIKO SOMA さんのアプリ（iOS 公開中 8本 ＋ Android クローズドテスト中 4本）を紹介し、
Android版のテスターを募集する静的サイトです。検索エンジンにインデックスされる形で無料公開できます。

```
apps-promo-site/
├── index.html        … サイト本体（1ファイル完結・CSS内蔵）
├── sitemap.xml       … 検索エンジン用サイトマップ
├── robots.txt        … クローラー設定
├── _headers          … Cloudflare Pages / Netlify 用のキャッシュ・セキュリティヘッダ
├── set-domain.sh     … 公開ドメインを一括置換するヘルパー
└── assets/
    ├── og.png        … SNS シェア用画像（1200×630）
    ├── icons/*.webp  … 各アプリのアイコン（App Store 由来）
    └── shots/*.webp  … スクリーンショット（道場4本=Google Play由来 / その他=App Store由来）
```

---

## 1. 公開前に必ずやること：ドメインの置き換え

`index.html` / `sitemap.xml` / `robots.txt` に `REPLACE-WITH-YOUR-DOMAIN` という文字列が入っています。
公開先の URL（例：`example-apps.pages.dev` や独自ドメイン `example.com`）が決まったら置き換えてください。

**かんたんな方法（ターミナル）:**

```bash
cd apps-promo-site
./set-domain.sh example-apps.pages.dev            # ← 自分のドメインに
./set-domain.sh example-apps.pages.dev your@email # ← 問い合わせメールも設定する場合
```

`your@email` を省略すると、フッターの問い合わせ先は `REPLACE-WITH-YOUR-EMAIL` のまま残ります。
メールアドレスを載せたくない場合は、`index.html` のフッター内 `お問い合わせ：…` の行を削除するか、
X（旧Twitter）などの問い合わせ用リンクに書き換えてください。

---

## 2. 無料で公開する（おすすめ：Cloudflare Pages）

検索表示を狙うなら、独立した静的サイトを無料ホスティングに置くのが最適です。

### 方法A. Cloudflare Pages（GitHub 不要・ドラッグ＆ドロップ）

1. <https://dash.cloudflare.com/> でアカウント作成（無料）
2. 左メニュー **Workers & Pages** → **Create** → **Pages** → **Upload assets**
3. プロジェクト名を入力（これが `プロジェクト名.pages.dev` になります）
4. `apps-promo-site` フォルダの**中身**をまとめてドラッグ＆ドロップ → **Deploy**
5. 発行された `https://プロジェクト名.pages.dev` を控え、`./set-domain.sh` で置換 → もう一度アップロードして再デプロイ

> `pages.dev` のサブドメインでも Google / Yahoo! にインデックスされます。独自ドメインは後から無料で追加できます（Cloudflare の Custom domains）。

### 方法B. Netlify Drop（登録なしで即公開）

1. <https://app.netlify.com/drop> を開く
2. `apps-promo-site` フォルダをドラッグ＆ドロップ
3. すぐに `ランダム名.netlify.app` が発行される（アカウントを作ると名前を変更可）
4. 発行 URL で `./set-domain.sh` を実行し、再アップロード

### 方法C. GitHub Pages（GitHub を使う場合）

1. 新規リポジトリを作成し、このフォルダの中身を push
2. リポジトリの **Settings → Pages** → Source を `Deploy from a branch` → `main` / `/(root)`
3. `https://ユーザー名.github.io/リポジトリ名/` で公開
   - サブディレクトリ公開になるため、`set-domain.sh` には `ユーザー名.github.io/リポジトリ名` のように**パスまで**指定してください

---

## 3. 公開後にやること（検索に載せる）

1. **Google Search Console**（<https://search.google.com/search-console>）にサイトを登録
   - 「URL プレフィックス」で公開 URL を入力 → DNS またはHTMLタグで所有権確認
   - **サイトマップ** に `sitemap.xml` を送信
   - 「URL 検査」でトップページを **インデックス登録をリクエスト**
2. **Bing Webmaster Tools**（<https://www.bing.com/webmasters>）にも登録し、`sitemap.xml` を送信
   - **Yahoo! JAPAN の検索結果は Google の索引を使用**しているため、Google に登録されれば Yahoo! にも出ます
3. 反映まで数日〜2週間ほどかかります。`site:あなたのドメイン` で検索して確認

---

## 4. テスター募集の数字を更新する

`index.html` 内の「Android版テスター募集中」セクションに、オプトイン人数（例：`9 / 12 人`）と
プログレスバーの `width` を直書きしています。Play Console の各アプリのダッシュボードで最新の人数を確認し、
`<span>オプトイン 9 / 12 人…</span>` と `<i style="width:75%">` の2か所を書き換えてください。
日付表記（`2026年8月28日時点`）も忘れずに。

Googleグループの参加リンクは `https://groups.google.com/g/dojo-series-testers` を指しています。
グループ名が違う場合や、承認制で別の入口を用意する場合は、同セクション内のリンクを差し替えてください。

---

## 掲載データの出典

- **iOS アプリ情報・アイコン・一部スクリーンショット**：Apple の App Store 公開情報（開発者 TAKAHIKO SOMA / id6793002000）
- **道場4アプリの説明文・スクリーンショット**：Google Play Console のストア掲載情報（2026年8月28日時点）
- **テスター人数**：Google Play Console 各アプリのダッシュボード（2026年8月28日時点）

価格・仕様・募集状況は変わることがあります。公開前に一度ご確認ください。
