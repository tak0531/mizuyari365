class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :callback]
  protect_from_forgery except: :callback

  def index; end

  def show
    @user = User.find(params[:id])
    @plants = @user.plants.order(created_at: :desc)
    @w_cycle = @plants.map { |plant| plant.watering_cycle(plant) }

    @plant_limit2 = @user.plants.order(created_at: :desc).limit(2)
  end

  def new
    @user = User.new
  end

  def edit; end

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

  def update; end

  def destroy; end

  def search_index
    user = User.find_by(id: params[:user_id])
    @plants = user.plants.all
  end

  # LINEmessagingapi
  def callback
    body = request.body.read

    events = client.parse_events_from(body)
    events.each do |event|
      # ユーザーが公式ラインを友達追加した際にメッセージを送る処理
      if event['type'] == 'follow'
        line_user_id = event['source']['userId']
        client.push_message(line_user_id, { type: 'text', text: '友達追加ありがとうございます。' })
        client.push_message(line_user_id, { type: 'text', text: '水やりKeeperに登録しているメールアドレスをメッセージで送るとLINE通知機能がオンになります。' })

      # Usersのline_idを登録する処理
      elsif event['type'] == 'message'
        event_text = event['message']['text']
        user_line_id = event['source']['userId']
        if event_text.match(/\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/)
          if @user = User.find_by(email: event_text)
            @user.line_id = user_line_id
            @user.save
            client.push_message(user_line_id, { type: 'text', text: "#{@user.name}さんのLINEが登録されました。" })
            redirect_to root_path
          else
            client.push_message(user_line_id, { type: 'text', text: "メールアドレスが存在しませんでした。" })
          end
        elsif !(event_text =~ /\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b/)
          @user = User.find_by(line_id: user_line_id)
          @plants = @user.plants.to_a
          @w_cycle = @plants.map { |plant| plant.watering_cycle(plant) }

          if event['message']['text'].include?('水やり')
            @w_cycle.each do |key, value|
              if value == "3回以上水やりを忘れています。"
                client.push_message(user_line_id, { type: 'text', text: "'#{key}'は3回以上も水やり忘れてるよ。" })
              elsif value != 0
                client.push_message(user_line_id, { type: 'text', text: "#{key}は#{value}が水やり日だよ。" })
              end
            end
          else
            client.push_message(user_line_id, { type: 'text', text: "水やりのタイミングが知りたい場合は、'水やり'と送ってください。" })
          end
        end
      end
    end
  end
  # https://mizuyari-keeper-71a0af7a91ef.herokuapp.com/users/user_id/callback
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
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV.fetch("LINE_CHANNEL_SECRET", nil)
      config.channel_token = ENV.fetch("LINE_CHANNEL_TOKEN", nil)
    end
  end
end
