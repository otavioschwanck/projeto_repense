class Course < ActiveRecord::Base
  STATUS = {"Ativo" => 1, "Inativo" => 2} #Tipos de stats possíveis

  has_many :classrooms, dependent: :destroy

  # Validações
  validates_presence_of :name, :description, :status

  def self.search(value)
    if value.present?
      where("name ILIKE :query or description ILIKE :query", query: "%#{value}%")
    else
      all
    end
  end
end
