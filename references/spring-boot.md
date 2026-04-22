# Spring Boot (Java) — 学習カリキュラム

対象: Java と Spring Boot を使って Web API を書けるようになるまで。

## 前提確認

- JDK 17 以降（Spring Boot 3.x が前提）: `java --version`
- ビルドツール（Maven `mvn -v` または Gradle `gradle -v`）
- IDE: IntelliJ IDEA (Community) 推奨、VS Code + Extension Pack for Java + Spring Boot Extension Pack でも可

## カリキュラム（全 7 章）

### 第 1 章 Java 基礎（他言語経験ありの前提で圧縮）
- [1.1] 型、変数、`System.out.println`
- [1.2] クラス、`main` メソッド、パッケージ
- [1.3] コレクション（`List`, `Map`）、拡張 for
- [1.4] 例外の基礎（checked と unchecked）

完全な初心者の場合は `language-general.md` の第 1〜3 章を前置きする。

### 第 2 章 ビルドツールと依存管理
- [2.1] Maven の `pom.xml` または Gradle の `build.gradle` を読む
- [2.2] 依存の追加と解決
- [2.3] ビルド・実行・テストコマンド

### 第 3 章 Spring Boot プロジェクトの立ち上げ
- [3.1] `spring initializr` でプロジェクト生成
- [3.2] エントリーポイント `@SpringBootApplication` の意味
- [3.3] `application.properties` / `application.yml`
- [3.4] `spring-boot-starter-web` と埋め込み Tomcat

**到達状態**: `mvn spring-boot:run` でサーバが起動し、`/hello` が 200 を返す

### 第 4 章 DI と Bean、レイヤー分離
- [4.1] DI コンテナ = ApplicationContext の役割
- [4.2] `@Component` / `@Service` / `@Repository` / `@Controller` の使い分け
- [4.3] コンストラクタインジェクション（fieldインジェクションは避ける理由）
- [4.4] レイヤー構成（Controller → Service → Repository）

### 第 5 章 REST API と Validation
- [5.1] `@RestController`, `@GetMapping`, `@PostMapping` 等
- [5.2] `@PathVariable` / `@RequestParam` / `@RequestBody`
- [5.3] DTO と Entity の分離、なぜ分けるか
- [5.4] Bean Validation (`@Valid`, `@NotNull`, `@Size`)
- [5.5] 例外ハンドリング `@RestControllerAdvice`

**到達状態**: 入力バリデーションつきの 1 リソース CRUD API

### 第 6 章 Spring Data JPA
- [6.1] Entity と `@Id`, `@GeneratedValue`
- [6.2] `JpaRepository` の基本
- [6.3] クエリメソッド命名規約 vs `@Query`
- [6.4] トランザクション（`@Transactional`）とその境界
- [6.5] H2 in-memory DB から PostgreSQL への切替は設定変更のみ

### 第 7 章 テスト・ログ・仕上げ
- [7.1] JUnit 5 でユニットテスト
- [7.2] Mockito でモック化
- [7.3] `@SpringBootTest` と `@WebMvcTest` の違い
- [7.4] SLF4J + Logback でログ
- [7.5] Actuator で最低限の監視エンドポイント

**到達状態**: 主要ユースケースにテストがあり、ログが出ている

## 典型的な落とし穴

- Field injection (`@Autowired private …`) は testability が落ちる — constructor injection にする
- Entity をそのまま API のレスポンスにすると循環参照や過剰露出を招く — DTO に詰め替える
- `@Transactional` は public メソッドにのみ効く（自クラス内呼び出しでは効かない）
- `equals/hashCode` を JPA Entity に書くときは ID ベースに気をつける（null 比較）
- Lombok を入れる場合は IDE 側の設定が必要（annotation processing）

## コードレビュー観点

- レイヤーがちゃんと分かれているか（Controller に DB 処理が漏れていないか）
- DTO ⇔ Entity の変換は明示的か
- 依存は constructor injection か
- 例外ハンドリングが一元化されているか
- `application.properties` に秘密情報を書いていないか

## 推奨成果物

- ブログ API（Post / Comment / Tag）
- Todo API with ユーザー認証（Spring Security 入門を章 8 として増設）
- 商品在庫管理 API（トランザクションの挙動を体感）
