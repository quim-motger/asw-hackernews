class VotesController < ApplicationController
  include SessionsHelper
  include ApplicationHelper
  before_action :set_vote, only: [:show, :edit, :update, :destroy, :show_api]
  before_action :authenticate, only: [:create_api]

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
  end

  # GET /votes/new
  def new
    @vote = Vote.new

  end

  # GET /votes/1/edit
  def edit
  end

  # POST /votes
  # POST /votes.json
  def create
    respond_to do |format|
      @vote = Vote.new(vote_params)
      unless logged_in? or format.json
        redirect_to signin_path('google')
        return
      end

      @vote.user_id = current_user.id


      if @vote.save
        format.html { redirect_to :back }
        format.json { render :show, status: :ok, location: @vote }
      else
        redirect_to :back
      end
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_api
    @vote = Vote.new({contribution_id: params['contribution_id']})
    @vote.user_id = @api_user.id
    if @vote.save
      render :show_api, id: @vote.id
    else
      render json: @vote.errors, status: :bad_request
    end
  end

  def show_api
    render json: @vote, status: :ok
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vote
    @vote = Vote.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vote_params
    params.require(:vote).permit(:user_id, :contribution_id)
  end
end
