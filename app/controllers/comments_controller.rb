class CommentsController < ApplicationController

def create
  @prototype = Prototype.find(params[:prototype_id])
  @comment = @prototype.comments.build(comment_params.merge(user: current_user))

  if @comment.save
    redirect_to prototype_path(@prototype), notice: 'コメントを投稿しました。'
  else
    # コメントが保存できなかった時の処理
    @comments = @prototype.comments.includes(:user)
    render 'prototypes/show', status: :unprocessable_entity
  end
end

private

def comment_params
  params.require(:comment).permit(:comments).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
end



end
