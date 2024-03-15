RakutenWebService.configure do |c|
    # (必須) アプリケーションのアプリケーションID。
    c.application_id = 'YOUR_APPLICATION_ID'

    # オプション）楽天アカウントのアフィリエイトID。
    c.affiliate_id = 'YOUR_AFFILIATE_ID' # default: nil

    # (オプション) # リクエストの再送回数.
    # リクエスト数が制限を超過した場合, エンドポイントは # リクエスト数超過エラーを返します.
    # リクエストが多すぎるというエラーが返されます. その後, # クライアントはしばらくしてから同じリクエストの送信を再試行します.
    # while.
    c.max_retries = 3 # default: 5

     # (オプション) デバッグモードを有効にします. trueを設定すると, クライアントはすべてのHTTPリクエストとレスポンスを # 標準エラーにストリーム出力します.
    # レスポンスを標準エラーに出力します.
    c.debug = true # default: false
end