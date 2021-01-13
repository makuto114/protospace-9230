class PrototypesController < ApplicationController

  def index
      @prototypes = Prototype.all
    if user_signed_in?  
      @user = User.find(current_user.id)
    end
  end

  def new
    @prototype = Prototype.new
    @user = User.find(current_user.id)
  end

  def create
    @user = User.find(current_user.id)
    @prototype = Prototype.new(prototype_params)
    
    if @prototype.save
      redirect_to root_path
    else
      render new_prototype_path(@prototype)
    end
  end

  def show 
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
    unless current_user.id == @prototype.user.id
      redirect_to action: :index
    end
  end

  def update
    @prototype = Prototype.find(params[:id])

    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render action: :edit
    end
  end

  def destroy
    prptotype = Prototype.find(params[:id])
    prptotype.destroy

    redirect_to prototypes_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
   
end
