class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy, :create_enrollment, :new_enrollment, :destroy_enrollment]
  before_action only: [:new_enrollment, :create_enrollment] do
    redirect_to @student, alert: "Estudante precisa estar ativo" if @student.status == 2
  end


  # GET /students
  # GET /students.json
  def index
    @search_value = params[:search]
    @students = Student.search(@search_value).page(params[:page]).per(25)
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @classrooms = @student.classrooms.page(params[:page]).per(10)
  end

  def new_enrollment
    @classroom = @student.classrooms.build
  end

  def create_enrollment
    @classroom = @student.classrooms.build(classroom_params)
    if @classroom.save
      redirect_to @student, notice: "Aluno matriculado com sucesso."
    else
      render :new_enrollment
    end
  end

  def destroy_enrollment
    @classroom = @student.classrooms.find(params[:classroom_id])
    if @classroom.destroy
      redirect_to @student, notice: "Mátricula removida com sucesso."
    else
      redirect_to @student, alert: "Não foi possível remover a mátricula."
    end
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Estudando criado com sucesso.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Estudando atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Estudando deletado com sucesso' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.where(id: params[:id]).first
      @student = Student.find(params[:student_id]) if @student.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :register_number, :status)
    end

    def classroom_params
      params.require(:classroom).permit(:course_id)
    end
end
