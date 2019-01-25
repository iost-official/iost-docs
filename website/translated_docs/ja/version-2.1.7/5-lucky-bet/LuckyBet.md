---
id: version-2.1.7-LuckyBet
title: LuckyBetサンプル
sidebar_label: LuckyBetサンプル
original_id: LuckyBet
---
このチュートリアルは、スマートコントラクトのコーディングとデプロイをデモするために設計されています。
(実際のチェーンに接続しないで、開発のためだけに)ローカルにIOSTノードをデプロイする方法を紹介します。
それにより、スマートコントラクト('Lucky Bet'という名前のギャンブルゲーム)がノードにデプロイされます。

## ステップ1: ローカルサーバーの実行
最初に[ローカールサーバーを起動](4-running-iost-node/LocalServer.md)します。

## ステップ2: iWalletのインストール
[このドキュメント](4-running-iost-node/Building-IOST.md)に従って、IOSTをビルドします。

## ステップ3: スマートコントラクトのデプロイと実行
```shell
# deploy and run the smart contract
git clone https://github.com/iost-official/luckybet_sample.git
cd luckybet_sample/
python3.6 luckbet.py # You will see "Congratulations! You have just run a smart contract on IOST!".
```


## 付録: Lucky Betのルール
ゲームのルールがこちらです。コントラクトのコードを理解する助けになるでしょう。

1. IOSTのアカウントは、１から５IOSTを賭けることができます。ベットする数は0から9です。
2. ベットが100に達すると当選番号が公開され、当選者はステークの95%を獲得し、残りの5%がトランザクション手数料になります。
3. 当選番号は、ブロック高を10で割った余りです。前の当選番号のブロックが16ブロック未満の場合は、ブロックの親のハッシュを16で割った余りが0の場合だけ公開し、そうでないときは当選番号は公開されません。