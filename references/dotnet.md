# .NET / C# — 学習カリキュラム

対象: C# を使って .NET の仕組みを理解し、Web API が書けるようになるまで。

## 前提確認

- `.NET SDK` インストール（現行 LTS の 8.0 以降推奨）: `dotnet --version`
- VS Code の場合 `C# Dev Kit` 拡張。Rider / Visual Studio 2022 でも OK
- ターミナル操作の基礎

## カリキュラム（全 6 章）

### 第 1 章 .NET 入門と C# 基礎
- [1.1] `dotnet new console` でプロジェクト作成、`dotnet run` で実行
- [1.2] C# の型システム（値型と参照型、`string` / `int` / `bool`）
- [1.3] 変数、条件分岐、ループ
- [1.4] `List<T>` と `Dictionary<TKey, TValue>`

**到達状態**: CLI で FizzBuzz を書いて実行できる

### 第 2 章 オブジェクト指向と C# の流儀
- [2.1] クラスとプロパティ（自動実装プロパティ、`init` アクセサ）
- [2.2] コンストラクタ、`readonly`, `record` との違い
- [2.3] 継承と `override`、`sealed`
- [2.4] インターフェース（`interface`）
- [2.5] `namespace` とファイル分割

**到達状態**: 小さなドメイン（例: `Book`, `Library`）をクラスでモデリングできる

### 第 3 章 LINQ と非同期
- [3.1] LINQ の基礎（`Where`, `Select`, `OrderBy`）
- [3.2] メソッド構文とクエリ構文
- [3.3] `async` / `await` の基礎
- [3.4] `Task<T>` の振る舞いとキャンセル

**到達状態**: ファイルを非同期で読み、LINQ で集計する CLI が書ける

### 第 4 章 .NET のランタイムとプロジェクト構造
- [4.1] CLR・BCL・NuGet の位置づけ
- [4.2] `csproj` の読み方（`TargetFramework`, `PackageReference`）
- [4.3] ソリューション (`.sln`) とマルチプロジェクト構成
- [4.4] NuGet パッケージを追加して使う（例: `Newtonsoft.Json` か `System.Text.Json`）

**到達状態**: 依存パッケージを含む複数プロジェクト構成を組める

### 第 5 章 ASP.NET Core で最小 Web API
- [5.1] `dotnet new webapi` と Minimal API
- [5.2] ルーティングとリクエスト/レスポンス
- [5.3] DI コンテナの基礎（`builder.Services.AddSingleton` 等）
- [5.4] `appsettings.json` と `IConfiguration`
- [5.5] EF Core で SQLite にアクセス（CRUD 1 リソース）

**到達状態**: `GET` / `POST` / `PUT` / `DELETE` を備えた 1 リソース API が立ち上がる

### 第 6 章 テスト・ログ・仕上げ
- [6.1] xUnit でユニットテスト
- [6.2] `Microsoft.Extensions.Logging` でログ
- [6.3] 例外ハンドリングのミドルウェア
- [6.4] 簡易的な統合テスト（`WebApplicationFactory`）

**到達状態**: API にテストとログを加え、README を添えて公開できる状態

## 典型的な落とし穴

- `string` の `==` は中身比較だが、`object` 経由だと参照比較になる
- `async void` はイベントハンドラ以外で使わない
- `IDisposable` を返すものは `using` で受ける
- DI のライフタイム混同（`Singleton` から `Scoped` を取ると壊れる）
- EF Core の遅延読み込みで N+1

## コードレビュー観点

- 命名（PascalCase / camelCase / `I`-prefix for interfaces）
- `nullable reference types` を活かしているか（`#nullable enable`）
- LINQ で `ToList()` を早期に呼んで意図しない enumerate をしていないか
- `async` の戻り値が `Task` / `Task<T>` で、`async void` になっていないか
- 例外をキャッチして握り潰していないか

## 推奨成果物

- Books API (CRUD + カテゴリで絞り込み)
- 家計簿 API（日付集計）
- Todo API with ユーザー分離（後半で認証を足す前提）
