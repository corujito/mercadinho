class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :timeoutable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum role: [ :admin, :funcionario1 ]

  def email_required?
    false
  end
end
