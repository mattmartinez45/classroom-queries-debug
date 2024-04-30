class CoursesController < ApplicationController
  def index
    matching_courses = Course.all
    @courses = matching_courses.order({ :created_at => :desc })

    render({ :template => "courses/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @course = Course.where({:id => the_id }).at(0)

    render({ :template => "courses/show" })
  end

  def create
    course = Course.new
    course.title = params.fetch("q_title")
    course.term_offered = params.fetch("query_term")
    course.department_id = params.fetch("query_department_id")
    course.save

    redirect_to("/courses")

  end

  def update
    id = params.fetch("path_id")
    matching_course = Course.where({ :id => id })
    the_course = matching_course.at(0)

    the_course.title = params.fetch("query_title")
    the_course.term_offered = params.fetch("query_term_offered")
    the_course.department_id = params.fetch("query_department_id")
    the_course.save

    redirect_to("/courses/#{the_course.id}")
  end

  def destroy
    the_id = params.fetch("path_id")
    matching_cours = Course.where({ :id => the_id })
    the_course_d = matching_cours.at(0)
    the_course_d.destroy

    redirect_to("/courses")
  end
end
