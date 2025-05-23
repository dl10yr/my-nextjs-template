# nextjs-with-api-template

`Next.js` + `Prisma.js` + `PlanetScale` +`Firebase Auth（匿名ログイン）` による Todo アプリのテンプレートです。

## 詳しい説明

こちらの記事で説明してます
https://zenn.dev/dl10yr/articles/nextjs-with-api-template

`2024/12`に更新しました。
https://zenn.dev/dl10yr/articles/nextjs-with-api-template2024

## ページ構成

- `/`: index
- `/todo/ssr`: SSR で DB から Todo を取得して表示してます
- `/todo/csr`: CSR で DB から Todo を取得して表示、フォームを使って投稿。

## API

Next.js でバックエンドの API も構築しています。firebase の`idToken`で`Bearer認証`しています。

- `GET /api/todos`
- `POST /api/todos`
- `DELETE /api/todos/{id}`

## 構築手順

```
1. git clone
2. yarn
3. firebaseClient.tsのCLIENT_CONFIGを変更
4. .env.sampleを.envにして内容変更
5. yarn prisma:push
6. yarn dev
```

## terraformによるAWSリソース構築
以下の構成図のリソースをterraformにより構築

<div align="center">
    <img src="./docs/my-nextjs-template-aws-architecture.png" alt="AWS構成図" width="80%" />
</div>

### AWSリソース構築手順
1. `terraform/envs/dev`のlocals.tf.sampleをコピーして、locals.tfを作り値を埋める
2. `terraform init`, `terraform plan`、`terraform apply`
3. GitHubの権限許可
    - AWS上でGitHubへの接続を許可 デベロッパー用ツール>設定>接続
        - https://ap-northeast-1.console.aws.amazon.com/codesuite/settings/connections?region=ap-northeast-1
    - GitHubでのリポジトリへのアクセス許可
        - https://github.com/settings/installations