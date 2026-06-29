class Lesson < ApplicationRecord
  belongs_to :course
  has_many :lesson_progresses, dependent: :destroy
  # 강의 전용 동영상 저장 공간
  has_one_attached :video
  # 강의 전용 자료 저장 공간
  has_one_attached :material
end
