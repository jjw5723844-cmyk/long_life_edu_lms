class Institution < ApplicationRecord
  # 기관 필수 입력 정보 검증 (schema.rb 기준)
  validates :name, :greeting_title, :greeting_content, :mission, :core_values, presence: true
end
