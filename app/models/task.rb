class Task < ApplicationRecord
    
    
    
    #проверка на пустоту
    validates :title, :status, presence: true
    #проверка на кол-во символов
    validates :description, length: { maximum: 1000 }

end
