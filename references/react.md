# React — 学習カリキュラム

対象: React / TypeScript / Vite で、ローカル状態 + API 連携 + ルーティングまでの SPA を書けるようになるまで。
Next.js はこの scope では扱わない（別カリキュラムにすると混乱しない）。

## 前提確認

- Node.js 18+: `node --version`
- npm / pnpm
- VS Code + ESLint, Prettier, ES7+ React snippets
- TypeScript 経験がなければ `references/nestjs.md` の第 2 章を前置き

## カリキュラム（全 7 章）

### 第 1 章 Vite で最初の React + TypeScript プロジェクト
- [1.1] `npm create vite@latest my-app -- --template react-ts`
- [1.2] `src/App.tsx` の構造、Vite の dev サーバ起動
- [1.3] ブラウザの DevTools で React コンポーネントを見る
- [1.4] JSX の基本（式の埋め込み、属性、class → `className`）

### 第 2 章 コンポーネントと Props
- [2.1] 関数コンポーネント
- [2.2] Props の型付け（`type` / `interface` / `React.FC` を使う/使わない議論）
- [2.3] children の扱い
- [2.4] コンポーネント分割の粒度の感覚

**到達状態**: Button / Card / Avatar のような再利用コンポーネントが書ける

### 第 3 章 状態 (useState) とイベント
- [3.1] `useState` の基礎
- [3.2] イベントハンドラ（`onClick`, `onChange`）
- [3.3] フォームの制御コンポーネント
- [3.4] 状態の置き場所（リフトアップ）

**到達状態**: 入力フォームつき Counter / Todo リスト（ローカル）

### 第 4 章 副作用 (useEffect) と Fetch
- [4.1] `useEffect` の基礎（依存配列の読み方）
- [4.2] `fetch` で API を呼ぶ
- [4.3] loading / error / data の 3 状態管理
- [4.4] cleanup 関数とアンマウント時の処理
- [4.5] なぜ `useEffect` の依存配列が重要か（stale closure）

**到達状態**: JSONPlaceholder のような外部 API からデータ取得 → 表示できる

### 第 5 章 リスト、条件分岐、フォーム発展
- [5.1] `.map()` で配列レンダリング、`key` の意味
- [5.2] 条件レンダリング（`&&`, 三項演算子、早期 return）
- [5.3] 複数入力のフォームと `useState` オブジェクト管理
- [5.4] コントロールドコンポーネントの基本

### 第 6 章 ルーティング、共通レイアウト、状態管理の発展
- [6.1] React Router の基本（`BrowserRouter`, `Route`, `Link`）
- [6.2] 共通レイアウトコンポーネント
- [6.3] `useContext` で跨ぎ状態（テーマ、認証ユーザ）
- [6.4] いつ Redux/Zustand を検討するか（今は入れない、紹介だけ）
- [6.5] ライブラリ選定の考え方（状態管理 / データフェッチ / フォーム）

### 第 7 章 スタイリング・テスト・仕上げ
- [7.1] スタイリング選択肢の紹介（CSS Modules, Tailwind CSS, Styled Components）
- [7.2] Tailwind を選ぶならセットアップ
- [7.3] テスト入門（Vitest + React Testing Library）
- [7.4] `@testing-library/user-event` でインタラクション
- [7.5] デプロイの選択肢（Vercel, Netlify, GitHub Pages）

## 典型的な落とし穴

- `useEffect` の依存配列の書き忘れ → 無限ループ or stale データ
- `.map()` の `key` に index を使うのはリスト順変更時に問題
- state の直接変更（`arr.push(x); setArr(arr)`）→ 再レンダリングされない、不変更新を
- 親から毎回新しいオブジェクトを渡すと `React.memo` が効かない
- `setState` は非同期。直後の値を読んでも反映されていない

## コードレビュー観点

- コンポーネントが単一責務か（1 コンポーネント = 1 概念）
- 副作用が正しく整理されているか（依存配列、cleanup）
- Props の型が最小で正確か
- リスト `key` が適切か
- 無駄な再レンダリング（巨大な state、親レベルで毎回作るオブジェクト）

## 推奨成果物

- Todo アプリ（LocalStorage 連携）
- GitHub ユーザー検索（外部 API）
- 映画検索 UI（OMDb API 等）
- 簡易掲示板（章 8 としてバックエンド連携: 同じ session で NestJS と組み合わせると学習効果大）

## 注意: Next.js を学びたいと言われた場合

Next.js は React を前提とするため、まず React 単体のこのカリキュラムを終えてから Next.js に移るのが失敗しにくい。もし 既に React を書けるなら、直接 Next.js カリキュラム（別途作成）に飛んでよい。
