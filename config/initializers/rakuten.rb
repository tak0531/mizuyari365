RakutenWebService.configure do |c|
  # (必須) アプリケーションのアプリケーションID。
  c.application_id = ENV.fetch('RWS_APPLICATION_ID', 'default_value')

  # オプション）楽天アカウントのアフィリエイトID。
  c.affiliate_id = ENV.fetch('RWS_AFFILIATION_ID', 'default_value') # default: nil

  c.max_retries = 3 # default: 5

  c.debug = true # default: false
end
