class Discount <ApplicationRecord
  validates_presence_of :percentage, :min_quantity

  belongs_to :merchant
end
