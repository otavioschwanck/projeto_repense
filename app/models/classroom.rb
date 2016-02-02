class Classroom < ActiveRecord::Base
  belongs_to :student
  belongs_to :course

  validates_presence_of :course_id, :student_id
  validates_uniqueness_of :student_id, scope: :course_id

  validate :can_enter
  validate :student_is_active?

  private

  def student_is_active?
    # Está mensagem de erro nunca irá aparecer, mas pra evitar que seja salvo mesmo.
    errors.add(:course_id, "Estudante precisa estar ativo.") if Student.find(student_id).status == 2
  end

  def can_enter
    # Apenas para evitar um inspecionar elemento mal intencionado.
    # Verifica se o curso realmente pode receber uma nova mátricula
    errors.add(:course_id, "Curso não permitido") unless Student.find(student_id).avaiable_courses.include? course
  end

end
