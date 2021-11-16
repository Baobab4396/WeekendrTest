class AvailabilityValidator < ActiveModel::EachValidator

    def validate_each(record, attribute, value)
      #On récupère l'ensemble des ScheduleItem avec le même day_id et le shop_name que le ScheduleItem dont on veut insérer.
      scheduleItems = ScheduleItem.where(["shop_name =? and day_id =?", record.shop_name, record.day_id])

      #Conversion Hash en plage horaire d'intervale open_time et close_time pour chaque plage open_time - close_time déjà présente.
      date_ranges = scheduleItems.map { |b| b.open_time..b.close_time }
  
      # On regarde si l'horaire que l'on veut insérer (open_time ou close_time) tombe sur une plage horaire déjà présente.
      date_ranges.each do |range|
        if range.include? value
          record.errors.add(attribute, "not available")
        end
      end
    end
end

# Un ScheduleItem est un "fragment" d'emploi du temps. Un fragment d'emploi du temps est un jour de la semaine
# ( représenté par un entier de 0 à 6, le 0 étant le dimanche ) avec une plage horaire (open_time et close_time)
# Un ScheduleItem est associé à un shop ( shop_name ). On peut spécifier plusieurs ScheduleItem avec le même shop_name
# et le même day_id , si on veut ajouter une autre plage horaire, du moment qu'elle ne chevauche avec une autre plage horaire déjà présente.
class ScheduleItem < ApplicationRecord
    
    validates :shop_name, presence:true
    validates_inclusion_of :day_id, :in => 0..6

    # La validation "availability" permet de vérifier que la plage horaire que l'on veut insérer ne chevauche pas avec une autre deja existante,
    # pour un shop_name et un day_id donné. 
    validates :open_time, :close_time, presence:true, availability: true

    # La validation close_time_after_open_time vérifie que l'heure de fermeture n'est pas antérieure à l'heure d'ouverture.
    validate :close_time_after_open_time

    private

    def close_time_after_open_time
        return if close_time.blank? || open_time.blank?

        if close_time < open_time
          errors.add(:close_time, "must be after the open")
        end
    end
end
