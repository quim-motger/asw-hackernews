class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_login, only: [:edit, :update]
  before_action :set_karma, only: [:show, :edit]
  include ApplicationHelper
  include SessionsHelper

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if current_user.id != @user.id
      flash[:status] = 'Non authorized'
      redirect_to root_url
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    if logged_in? and current_user.id == @user.id
      render :edit, id: @user.id
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json


  def update
    if current_user.id != @user.id
      # TODO: SHOW 401 error
      redirect_to root_url
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to action: 'show', id: @user.id }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  ##API CALLS
  def api_show
    set_user
    render json: @user
  end
  
  def api_update
    @user = User.find_by_email(decode(request.authorization))
    @user.update(user_params)
    render json: @user
  end
  
  def api_threads
    set_user
    @contributions = (@user.contributions).where("contr_type = 'comment' or contr_type = 'reply'")
    render json: @contributions
  end

  ##end API CALLS

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def set_karma
    set_user
    @karma=0
    @user.contributions.each do |i|
      @karma+=i.votes.length
    end
  end

  def check_login
    unless logged_in?
      redirect_to signin_path("google");
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email)
  end
  
end

  
