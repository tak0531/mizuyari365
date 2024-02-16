class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :callback]
  protect_from_forgery except: :callback

  def index
  end

  def show
    @user = User.find(params[:id])
    @plants = @user.plants.to_a
    @w_cycle = @plants.map { |plant| plant.watering_cycle(plant) }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to login_path
      flash[:success] = "アカウントを作成しました"
    else

      render :new, status: :unprocessable_entity
      flash.now[:danger] = "アカウントの作成に失敗しました"


    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def search_index
    user = User.find_by(id: params[:user_id])
    @plants = user.plants.all
  end


  # LINEmessagingapi
  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    events.each do |event|
      case event
        
      # ユーザーが講師kラインを友達追加した際にメッセージを送る処理
      when Line::Bot::Event::Follow
        line_user_id = event['source']['userId']
        client.push_message(line_user_id, { type: 'text', text: '友達追加ありがとうございます。' })
        client.push_message(line_user_id, { type: 'text', text: '水やりKeeperに登録しているメールアドレスをメッセージで送るとLINE通知機能がオンになります。' })
      
      # Usersのline_idを登録する処理 
      when Line::Bot::Event::Message
        user_email = event['message']['text']
        # user_email.match(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/) で取得でもいいかも
        user_line_id = event['source']['userId']
          if @user = User.find_by(email: user_email)
            @user.line_id = user_line_id
            @user.save
            client.push_message(user_line_id, { type: 'text', text: "#{@user.name}さんのLINEが登録されました。" })
            redirect_to root_path
          else
            client.push_message(user_line_id, { type: 'text', text: "メールアドレスが存在しませんでした。" })
          end
      end
    end
  end

  def delete_line_id
    @user = User.find(current_user.id)
    @user.line_id = nil
    @user.save
    flash[:success] = 'LINEの連携を解除しました。'
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar, :line_id)
  end

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

end