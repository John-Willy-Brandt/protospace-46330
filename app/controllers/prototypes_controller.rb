  class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy ]
   before_action :set_prototype,        only: %i[show edit update destroy]
    before_action :authorize_owner!,     only: %i[edit update destroy]


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new  
  end

  def create
    # Build through the association so user_id is set without touching params
    @prototype = current_user.prototypes.build(prototype_params)
    if @prototype.save
      redirect_to root_path, notice: '投稿しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment   = Comment.new                      # for the form
    @comments  = @prototype.comments.includes(:user).order(created_at: :desc)  # for the list
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end




  private

    def set_prototype
    @prototype = Prototype.find(params[:id])
  end


  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end
  def authorize_owner!
    return if current_user && current_user.id == @prototype.user_id
    redirect_to root_path, alert: '権限がありません。'
  end
end


