class Discount <ApplicationRecord
  validates_presence_of :percentage, :min_quantity

  validates_numericality_of :min_quantity, greater_than_or_equal_to: 1
  validates :percentage, :numericality => { greater_than_or_equal_to: 1, less_than: 100 }

  belongs_to :merchant

end
