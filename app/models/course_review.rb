class CourseReview < ApplicationRecord
  belongs_to :user # 후기를 작성한 학습자와의 관계 선언
  belongs_to :course # 후기가 작성된 강좌와의 관계 선언

  # 1점 이상~5점 이하 척도의 별점을 부여하여 학습자 만족도 평가 반영
  validates :rating, presence: true, numericality: { only_intefer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }

  # 후기 본문의 텍스트 작성시 무분별한 도배를 막기 위해 최소 10자 이상 작성 규칙을 강조
  validates :content, presence: true, length: { minimum: 10 }
end