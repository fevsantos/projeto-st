class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: %i[show edit update destroy ]

  def index
    @questionnaires = Questionnaire.all
    user = current_user
    @quest_user = Questionnaire.where(user: user)
  end

  def show
  @questionnaire = Questionnaire.find(params[:id])
  @questions = []
  @options = []
  @resposta = []
  @questionnaire.questions.each do |q|
    @questions << q.name
  end
  @questionnaire.questions.each do |q|
    q.answers.each do |a|
      @options << a.name
    end
  end
  @questionnaire.questions.each do |q|
    q.answers.each do |a|
      if a.correct == true
        @resposta << a.name
      end
    end
  end

  @n = @questions.length
  @numeros = (0..100).to_a
  @loop = @numeros[0...@n]
  @o = @options.length
  @loop2 = @numeros[0...@o]
  @loop2.each do |n|
    instance_variable_set "@op#{n}".to_sym, @options[n]
  end
  @questionsr = []
  @loop.each do |n|
    @questionsr << {
      numb: n + 1,
      question: @questions[n],
      answer: @resposta[n],
      options: [
        instance_variable_get("@op#{n * 4}"),
        instance_variable_get("@op#{(n * 4) + 1}"),
        instance_variable_get("@op#{(n * 4) + 2}"),
        instance_variable_get("@op#{(n * 4) + 3}")
    ]
  }
  end
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def edit
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    @questionnaire.user = current_user

    respond_to do |format|
      if @questionnaire.save
        format.html { redirect_to questionnaire_url(@questionnaire), notice: "Questionnaire was successfully created." }
        format.json { render :show, status: :created, location: @questionnaire }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @questionnaire.update(questionnaire_params)
        format.html { redirect_to questionnaire_url(@questionnaire), notice: "Questionnaire was successfully updated." }
        format.json { render :show, status: :ok, location: @questionnaire }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @questionnaire.destroy

    respond_to do |format|
      format.html { redirect_to questionnaires_url, notice: "Questionnaire was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @token = params[:q]
    @quest_stu = Questionnaire.find_by(token: @token)
  end

  def grades
    @questionnaire = Questionnaire.find(params[:id])
    @grades = StudentGrade.where(questionnaire_id: @questionnaire.id)
    @nquestions = @questionnaire.questions.count
  end

  def grades_update
    @questionnaire = Questionnaire.find(params[:id])
    @grades = @questionnaire.student_grades
    @grades.each do |grade|
      if grade.user_id == params[:student_grade][:user_id].to_i
        grade.update(repeat: params["student_grade"]["repeat"])
      end
    end
    redirect_to grades_path(@questionnaire)
  end

  private

  def set_questionnaire
    @questionnaire = Questionnaire.find(params[:id])
  end

  def questionnaire_params
    params.require(:questionnaire).permit(
      :name,
      :token,
      questions_attributes: [
          :_destroy,
          :id,
          :question_type,
          :name,
          answers_attributes: [:_destroy, :id, :name, :correct]
      ]
    )
  end
end
