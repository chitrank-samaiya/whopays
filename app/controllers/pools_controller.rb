class PoolsController < ApplicationController
  before_action :set_pool, only: [:show, :edit, :update, :destroy]

  # GET /pools
  # GET /pools.json
  def index
    @pools = Pool.all
  end

  # GET /pools/1
  # GET /pools/1.json
  def show
    @user = User.find_by(params[:id])
    @pools = Pool.all
    @games = Game.where(params[:pool_id])
    #@game = Game.find_by(params[:user_id])
  end
  # current_user game is ... current_user.id = game.user.id
  # GET /pools/new
  def new
    @pool = Pool.new
  end
  def join
      @pool = Pool.find_by([:id])
  end

  # GET /pools/1/edit
  def edit
  end

  # POST /pools
  # POST /pools.json
  def create
    @pool = Pool.new(pool_params)
    respond_to do |format|
      if @pool.save
        format.html { redirect_to @pool, notice: 'Pool was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pool }
      else
        format.html { render action: 'new' }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end
  def join
     @join = current_user.games.build(game_params)
        if @dog.save
          flash[:success] = "Joined Pool"
          redirect_to current_user
        else
          render 'static_pages/home'
        end
  end

  # PATCH/PUT /pools/1
  # PATCH/PUT /pools/1.json
  def update
    respond_to do |format|
      if @pool.update(pool_params)
        format.html { redirect_to @pool, notice: 'Pool was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pool.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pools/1
  # DELETE /pools/1.json
  def destroy
    @pool.destroy
    respond_to do |format|
      format.html { redirect_to pools_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pool
      @pool = Pool.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pool_params
      params.require(:pool).permit(:name)
    end
    def game_params
      params.require(:game).permit(:user_id, :pool_id)
    end
end
