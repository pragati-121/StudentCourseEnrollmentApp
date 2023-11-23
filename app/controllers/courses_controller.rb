class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @student_names = @course.students.pluck(:name)
  end

  def enroll
    @course_to_enroll = Course.find(params[:id])
    @available_students = Student.where.not(id: @course_to_enroll.students.pluck(:id))
  end

  def enroll_student
    @course_to_enroll = Course.find(params[:id])
    @enrolled_student  = Student.find(params[:student_id])

    if @course_to_enroll.students.include?(@enrolled_student)
      flash[:alert] = "Stduent is already enrolled in this course"
    else
      @course_to_enroll.students << @enrolled_student
      flash[:notice] = "Student enrolled successfully"
    end
    redirect_to courses_path
  end

def remove_student
  @course = Course.find(params[:id])
  @student_to_remove = @course.students.find(params[:student_id])

  if @course.students.destroy(@student_to_remove)
    flash[:notice] = "Student removed from the course successfully."
  else
    flash[:alert] = "Failed to remove student from the course."
  end
  redirect_to course_path(@course)
end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(params.require(:course).permit(:name, :start_date, :end_date))
    if @course.save
    flash[:notice] = "Course is successfully created."
    redirect_to @course
    else 
      render 'new'
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    flash[:notice] = "Course removed successfully."
    redirect_to courses_path
  end

  def edit
     @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    if @course.update(params.require(:course).permit(:name, :start_date, :end_date))
      flash[:notice] = "Course details updated successfully."
      redirect_to @course
    else
      render :edit
    end
  end
end
