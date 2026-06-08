json.extract! course, :id, :title, :description, :instructor_name, :max_students, :category_id, :created_at, :updated_at
json.url course_url(course, format: :json)
