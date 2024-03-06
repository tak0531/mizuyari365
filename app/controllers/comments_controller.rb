class CommentsController < ApplicationController
  before_action :require_login
  def edit
    @comment = Comment.new
  end

  def create
    comment = current_user.comments.build(comment_params)

    if comment.save
      redirect_to plant_path(comment.plant)
      flash[:success] = 'コメントを作成しました'
    else
      redirect_to plant_path(comment.plant)
      flash[:danger] = 'コメントの作成に失敗しました'
    end
  end

  def update
    @comment = current_user.comments.find(params[:id])
    plant = Plant.find_by(id: @comment.plant_id)
    if @comment.update
      redirect_to plant_path(plant), notice: "コメントを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    comment = current_user.comments.find(params[:id])
    plant = Plant.find_by(id: comment.plant_id)
    if comment.user_id == current_user.id
      comment.destroy
      flash[:success] = 'コメントを削除しました'
    end
    redirect_to plant_path(plant), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(plant_id: params[:plant_id])
  end
end
