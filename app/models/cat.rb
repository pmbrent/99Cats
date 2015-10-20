class Cat < ActiveRecord::Base
  COLORS = ["white","black","orange","gray"]

  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS }
  validates :sex, inclusion: { in: ["M", "F"] }

  has_many :cat_rental_requests, :dependent => :destroy


  def age
    ((Date.today - birth_date) / 365).to_i
  end


end
