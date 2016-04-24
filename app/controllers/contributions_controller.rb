class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :edit, :update, :destroy]

  # GET /contributions
  # GET /contributions.json
  def index
    @contributions = Contribution.all
  end

  # GET /reply?id=2
  def reply
    set_contribution
    if @contribution.contr_type != 'comment'
      raise ActiveRecord::RecordNotFound, 'Trying to reply a contribution of type '+@contribution.contr_type
    end
    @reply = Contribution.new
    @reply.parent_id = @contribution.id
    @reply.contr_type = 'reply'
    @reply.user = @contribution.user
  end
  
  def discuss
    set_contribution
    if @contribution.contr_type != 'post'
      raise ActiveRecord::RecordNotFound, 'Trying to discuss a contribution of type '+@contribution.contr_type
    end
    @discuss = Contribution.new
    @discuss.parent_id = @contribution.id
    @discuss.contr_type = 'comment'   #no he trobat els tipus de contributions que hi ha per tant inuteixo que es diran aixi
    @discuss.user = @contribution.user #aqui fico que el comentari es de la mateixa persona que el submision -> per cambiar
  end

  # GET /contributions/1
  # GET /contributions/1.json
  def show
  end

  # GET /contributions/new
  def new
    @contribution = Contribution.new
  end

  # GET /contributions/1/edit
  def edit
  end

  # POST /contributions
  # POST /contributions.json
  def create
    @contribution = Contribution.new(contribution_params)

    respond_to do |format|
      if @contribution.save
        print('test')
        print(@contribution.parent_id)
        if @contribution.contr_type == 'reply'
          format.html { redirect_to action: 'discuss', id: @contribution.parent.parent.id }
        elsif @contribution.contr_type == 'comment'
          format.html { redirect_to action: 'discuss', id: @contribution.parent.id }
        else
          format.html { redirect_to @contribution, notice: 'Contribution was successfully created.' }
          format.json { render :show, status: :created, location: @contribution }
        end
      else
        format.html { render :new }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contributions/1
  # PATCH/PUT /contributions/1.json
  def update
    respond_to do |format|
      if @contribution.update(contribution_params)
        format.html { redirect_to @contribution, notice: 'Contribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribution }
      else
        format.html { render :edit }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contributions/1
  # DELETE /contributions/1.json
  def destroy
    @contribution.destroy
    respond_to do |format|
      format.html { redirect_to contributions_url, notice: 'Contribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def newest
    @contributions = Contribution.where(["contr_type = 'post'"]).all.order('CREATED_AT DESC');
  end  

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_contribution
    @contribution = Contribution.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contribution_params
    params.require(:contribution).permit(:contr_type, :contr_subtype, :content, :user_id, :url, :upvote, :parent_id)
  end

end
