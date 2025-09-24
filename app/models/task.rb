class Task < ApplicationRecord
    STATUSES = ["Новая задача", "На выполнении", "Выполнена", "Просрочена"].freeze

    validates :title, presence: true
    validates :description, length: { maximum: 1000 }, allow_blank: true
    validates :status, inclusion: { in: STATUSES }

    # Статус по умолчанию
    def set_default_status
        self.status ||= "Новая задача"
    end

    # Переход к следующему статусу
    def next_status!
        case status
        when "Новая задача"
        update!(status: "На выполнении")
        when "На выполнении"
        update!(status: "Выполнена")
        reset_if_repeating!
        end
    end

    # Повторение задачи
    def reset_if_repeating!
        return unless repeat_forever || (repeat_interval && repeat_unit)
        
        new_due_date = case repeat_unit
                    when "day" then due_date + repeat_interval.days
                    when "week" then due_date + repeat_interval.weeks
                    when "month" then due_date + repeat_interval.months
                    end

        update!(status: "Новая задача", due_date: new_due_date)
    end

    # Проверка просроченной задачи
    def check_overdue!
        return if status == "Выполнена"

        if due_date && due_date < Date.today
            if repeat_forever || (repeat_interval.present? && repeat_unit.present?)
                # повторяющаяся задача → пересчитываем от сегодня
                interval = repeat_interval.to_i
                new_due_date = case repeat_unit
                                when "day" then Date.today + interval.days
                                when "week" then Date.today + interval.weeks
                                when "month" then Date.today >> interval 
                                end
                update!(status: "Новая задача", due_date: new_due_date)
            else
                # обычная просроченная задача
                update!(status: "Просрочена")
            end
        end
    end


end