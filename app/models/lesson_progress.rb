class LessonProgress < ApplicationRecord
  belongs_to :user # 진도 레코드가 해당 강의를 수강하는 학습자에게 귀속되는 것을 명시
  belongs_to :lesson # 진도 레코드가 해당 강의 콘텐츠에 귀속되는 것을 명시
  # 데이터베이스 인덱스 제약과 상호작용하는 모델 레벨의 유일성 검증을 추가
  validates :user_id, uniqueness: { scope: :lesson_id }
end
