class ApplicationMailer < ActionMailer::Base
  default from: "yoshioka.yotsuha.infratop@gmail.com"    # デフォルトで送る側のメールアドレスを設定
  layout 'mailer'        # レイアウトファイルの指定(この場合、mailer.html.erb or mailer.text.erbが呼び出される)
end
