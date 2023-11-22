class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    @courses_name = @student.courses.pluck(:name)
  end

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(params.require(:student).permit(:name, :age, :email))
    if @student.save
    flash[:notice] = "Student is successfully created."
    redirect_to @student
    else 
      render 'new'
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    flash[:notice] = "Student removed successfully."
    redirect_to students_path
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(params.require(:student).permit(:name, :age, :email))
      flash[:notice] = "Student details updated successfully."
      redirect_to @student
    else
      render :edit
    end
  end
end
