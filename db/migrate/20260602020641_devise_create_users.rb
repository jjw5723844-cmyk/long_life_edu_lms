# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      ## 기본 정보
      t.string :name, null: false, default: ""
      t.integer :role, null: false, default: 0 # 0: 학습자, 1: 교강사, 2: 운영관리자
      t.string :phone
      t.date :birth_date
      t.text :bio
      t.string :gender # "남성", "여성", "기타" 선택

      ## Database authenticatable(인증)
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable(비밀번호 재설정)
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable(자동 로그인 유지)
      t.datetime :remember_created_at

      ## Trackable(로그인 추적)
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Confirmable(이메일 인증)
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable(계정 잠금)
      t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string   :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      t.timestamps null: false
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :confirmation_token,   unique: true
    add_index :users, :unlock_token,         unique: true
    add_index :users, :role
  end
end
