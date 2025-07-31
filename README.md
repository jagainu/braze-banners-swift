# braze-banners-swift
Brazeの新機能BannersをiOSのSwift SDKにて取得し、表示する際のサンプルです。

## 利用前提
- Braze swift SDKの初期化が行われていること（サンプルコードのBrazeBannersApp.swift内のAPIキーおよびエンドポイントを置き換えてください）

## 注意事項
- Braze Swift SDKはv12.0.3以降をお使いください（v12.0.2まではBannerの表示にバグがあったため）
- banners.requestBannersRefresh()の処理完了前に、banners.getBanner()の処理が走ってしまうとバナーの取得が行えないことがございます。2025年7月31日現在の最新のBraze Swift SDK（v12.1.0)ではrequestBannersRefresh()のコールバックが実装されていないため、この問題に対処するために暫定的に待機の処理を入れています。

## サンプルお試し手順（キャンペーンの作成方法）
1. Brazeの管理画面内でバナーのキャンペーンを作成します。
<img width="524" height="463" alt="image" src="https://github.com/user-attachments/assets/c8d2a54d-5525-4e79-8e84-a9987505efd8" />


2. メッセージ作成 > 配置(placement)の設定をします。
- 未設定の場合、「配置の管理」から新しい配置を作成できます。
- 配置を作成し、サンプルのコードに合わせて 配置ID（placement ID）をheader_bannerとして設定してください。
<img width="1041" height="299" alt="image" src="https://github.com/user-attachments/assets/4ece01f8-8010-4411-afc7-a5cdb11d8345" />


3. メッセージ作成 > 「バナーを作成」から表示されるバナーを編集します。
<img width="1041" height="299" alt="image" src="https://github.com/user-attachments/assets/7348d533-f120-43c6-a650-77e2a286f48d" />

4. ターゲットオーディエンスを設定します。
- ここではサイトを開いたユーザーが確実に対象になるように「All Users」などを選択してください。
- ABテストの設定も表示の確認のタイミングでは、コントロールグループを削除してください。
<img width="1070" height="680" alt="スクリーンショット 2025-07-29 15 19 49" src="https://github.com/user-attachments/assets/611f3cb2-821c-4dcc-9f03-ed86a7ebc0d4" />

5. キャンペーンを開始し、サンプルアプリをテスト端末で開きます。
<img width="1206" height="2622" alt="IMG_2075" src="https://github.com/user-attachments/assets/9b68a28d-719b-4367-ba38-d8612f6804ca" />
