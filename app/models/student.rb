class Student < ActiveRecord::Base
  STATUS = {"Ativo" => 1, "Inativo" => 2} #Tipos de stats possíveis

  has_many :classrooms

  #Validações

  validates_presence_of :name, :status, :register_number
  validates_uniqueness_of :register_number


  def self.search(value)
    # Busca os alunos - Por nome, ou tipo de registro.
    if value.present?
      where("name ILIKE :query or register_number ILIKE :query", query: "%#{value}%")
    else
      all
    end
  end


end
