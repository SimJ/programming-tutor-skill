# NestJS (Node.js + TypeScript) — 学習カリキュラム

対象: Node.js の基礎から NestJS で 1 リソースの REST API を書けるところまで。

## 前提確認

- Node.js 18 以上（推奨 20+）: `node --version`
- パッケージマネージャ: `npm` か `pnpm` か `yarn` 。学習初期は `npm` で統一を推奨
- TypeScript 経験は仮定しない。章 2 で基礎を入れる
- VS Code + ESLint, Prettier

## カリキュラム（全 7 章）

### 第 1 章 Node.js の基礎
- [1.1] `node` 対話シェルでの実行、`.js` ファイルの実行
- [1.2] `package.json`, `npm init`, `npm install`
- [1.3] CommonJS と ESM の違い（NestJS は ESM ではなく CommonJS トランスパイル前提で始める）
- [1.4] 非同期: コールバック → Promise → `async/await`

### 第 2 章 TypeScript の基礎
- [2.1] `tsc --init` と `tsconfig.json` のミニマム設定
- [2.2] 基本型（`string`, `number`, `boolean`, union, `unknown` vs `any`）
- [2.3] インターフェースと型エイリアス
- [2.4] ジェネリクスの基礎（`Array<T>`, 関数のジェネリクス）
- [2.5] `strict` モードで書く習慣

### 第 3 章 NestJS プロジェクトの立ち上げ
- [3.1] `npm i -g @nestjs/cli` と `nest new my-app`
- [3.2] ディレクトリ構成（`src/`, `main.ts`, `AppModule`）
- [3.3] 最初のエンドポイント `/hello`
- [3.4] 開発サーバ `npm run start:dev`

### 第 4 章 NestJS のコアコンセプト
- [4.1] Module / Controller / Service の三層構造
- [4.2] 依存性注入（constructor injection, Provider）
- [4.3] `@Injectable()`, `@Controller()`, `@Module()` のデコレータ
- [4.4] Request ライフサイクルの全体像

### 第 5 章 REST API と DTO / Validation
- [5.1] `@Get()`, `@Post()`, `@Param()`, `@Body()`
- [5.2] DTO を class で書く理由（class-validator を使うため）
- [5.3] `class-validator` + `class-transformer` で入力検証
- [5.4] `ValidationPipe` をグローバル適用
- [5.5] 例外フィルタ（`HttpException`, `@Catch`）

**到達状態**: バリデーション付きの 1 リソース CRUD API が動く

### 第 6 章 永続化（TypeORM or Prisma）
推奨は **Prisma**（学習曲線が緩やか、スキーマ中心）。既に TypeORM 指定なら TypeORM でも可。

#### Prisma の場合
- [6.1] `npx prisma init`、`schema.prisma` の書き方
- [6.2] SQLite で小さく始める、後で PostgreSQL に移行可能と説明
- [6.3] `prisma migrate dev`
- [6.4] `PrismaService` を NestJS の DI に載せる（公式パターン）
- [6.5] CRUD の実装

#### TypeORM の場合
- [6.1] `@nestjs/typeorm` と Data Source の設定
- [6.2] Entity と Repository の書き方
- [6.3] マイグレーション

### 第 7 章 テスト・ログ・仕上げ
- [7.1] Jest (NestJS 標準) でユニットテスト
- [7.2] Service 層は DI を使ってモックできる点を体感
- [7.3] e2e テスト（`supertest`）
- [7.4] Logger の使い方と環境別ログ設定
- [7.5] `dotenv` と `@nestjs/config` で環境変数管理

## 典型的な落とし穴

- NestJS のバージョン依存に注意（v9, v10, v11 で差分あり。公式ドキュメントは最新）
- `forwardRef` を使いたくなったら循環依存の設計ミスを疑う
- DTO を interface で書くとランタイムで消えてしまい、validator が効かない — class で書く
- `async` 関数で例外を throw しないと `UnhandledPromiseRejection` でプロセスが落ちることがある
- Prisma を直接コントローラから呼ぶとレイヤー分離が崩れる — Service 層を挟む

## コードレビュー観点

- Module 境界が責務に沿っているか（`UserModule`, `PostModule` のような単位）
- Controller が薄いか（ルーティング + 入力検証のみ）
- ビジネスロジックが Service に集まっているか
- DTO で外部入出力を明示しているか
- 型安全（`any` を避けているか、`unknown` + 型ガードか）

## 推奨成果物

- ブログ API (User / Post / Comment)
- Todo API with JWT 認証（章 8 として `@nestjs/jwt` を追加）
- 在庫管理 API（Prisma トランザクション）
