class TeacherDashboardsController < ApplicationController
  def index
    @my_courses = current_user.courses.includes(registrations: :user).order(created_at: :desc)
  end
end
