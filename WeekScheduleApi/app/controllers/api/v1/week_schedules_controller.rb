require 'date'
require 'json'
class Api::V1::WeekSchedulesController < ApplicationController
  before_action :set_week_schedule, only: [:show]

  # GET /week_schedules
  def index
    @week_schedules = WeekSchedule.all

    render json: @week_schedules
  end

  # GET /week_schedules/1
  # A la requête d'un emploi du temps, on crée à la volée son emploi du temps "au bon format" pour l'envoyer au front.
  def show
    shopSchedule = WeekSchedule.where(["shop_name =?", params[:id]])
    
    hashSched = Hash.new

    # On construit l'emploi du temps jour par jour ( d'où le 0..6 )
    for i in 0..6
      # On récupère l'ensemble des fragments d'emploi du temps (ScheduleItem , cf. models) pour construire l'emploi du temps pour le jour i ( i est la variable de la boucle )
      scheduleItems = ScheduleItem.where(["shop_name =? and day_id =?", params[:id], i])
      schedules = scheduleItems.map { |item| item }
      
      # On trie par horaire d'ouverture.
      schedules = schedules.sort_by {|vn| vn[:open_time]}

      # Si aucune plage horaire n'est trouvée, on retourne null, on considèrera que la boutique est fermée ce jour.
      if schedules.empty?
        hashSched[i] = "null"
      else
        hashSched[i] = ""

        #Pour chaque plage horaire, on va écrire les plages d'ouverture sous la forme %H:%M - %H%M , ...  
        schedules.each do |schedule_item|
          hashSched[i] = hashSched[i] + schedule_item[:open_time].strftime("%H:%M") + " - " + schedule_item[:close_time].strftime("%H:%M") + ", "
        end

        # On enlève la virgule espace ajouté en trop
        hashSched[i] = hashSched[i][0...-2]
      end
      # For debugging purposes
      puts hashSched[i]
    end
    # On JSON tout ca et on balance ca au front.
    @week_schedule[:schedule] = hashSched.to_json
    render json: @week_schedule
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_week_schedule
      @week_schedule = WeekSchedule.find_by(shop_name: params[:id])
    end
end
