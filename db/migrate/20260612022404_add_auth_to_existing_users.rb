class AddAuthToExistingUsers < ActiveRecord::Migration[8.1]
  def change
    # 1. users 테이블에 email_address 컬럼이 없으면 새로 추가.
    add_column :users, :email_address, :string unless column_exists?(:users, :email_address)

    # 2. 암호화된 비밀번호를 저장할 password_digest 컬럼을 추가
    add_column :users, :password_digest, :string unless column_exists?(:users, :password_digest)

    # 3. 이메일 주소 중복 방지 인덱스 추가.
    add_index :users, :email_address, unique: true unless index_exists?(:users, :email_address)
  end
end
