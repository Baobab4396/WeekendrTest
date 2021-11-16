class Api::V1::ScheduleItemsController < ApplicationController
  before_action :set_schedule_item, only: [:show, :update, :destroy]

  # GET /schedule_items
  def index
    @schedule_items = ScheduleItem.all
    render json: @schedule_items
  end

  # GET /schedule_items/1
  def show
    render json: @schedule_item
  end

  # POST /schedule_items
  def create

    # Si l'emploi du temps (WeekSchedule) associé à une boutique n'existe pas encore, on va la créer.
    shopSchedule = WeekSchedule.where(["shop_name =?", params[:schedule_item][:shop_name]])
    if shopSchedule.empty?
      WeekSchedule.create(:shop_name => params[:schedule_item][:shop_name], :schedule => "")
    end
    @schedule_item = ScheduleItem.new(schedule_item_params)

    if @schedule_item.save
      render json: @schedule_item, status: :created, location: api_v1_schedule_item_url(@schedule_item)
      
    else
      render json: @schedule_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /schedule_items/1
  def update
    if @schedule_item.update(schedule_item_params)
      render json: @schedule_item
    else
      render json: @schedule_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /schedule_items/1
  def destroy
    @schedule_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule_item
      @schedule_item = ScheduleItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def schedule_item_params
      params.require(:schedule_item).permit(:shop_name, :day_id, :open_time, :close_time)
    end
end
