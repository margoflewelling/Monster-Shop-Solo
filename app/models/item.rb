class Item <ApplicationRecord
  belongs_to :merchant
  has_many :reviews, dependent: :destroy
  has_many :item_orders
  has_many :orders, through: :item_orders

  validates_presence_of :name,
                        :description,
                        :price,
                        :image,
                        :inventory
  validates_inclusion_of :active?, :in => [true, false]
  validates_numericality_of :price, greater_than: 0


  def average_review
    reviews.average(:rating)
  end

  def sorted_reviews(limit, order)
    reviews.order(rating: order).limit(limit)
  end

  def no_orders?
    item_orders.empty?
  end

  def self.most_popular_items
    @most_popular_item_orders = ItemOrder.find_by_sql("SELECT item_id, sum(quantity) as sum FROM item_orders GROUP BY item_id ORDER BY sum DESC LIMIT 5")
    @most_popular_item_orders.map {|item| Item.find(item.item_id).name }
  end

  def self.least_popular_items
    @least_popular_item_orders = ItemOrder.find_by_sql("SELECT item_id, sum(quantity) as sum FROM item_orders GROUP BY item_id ORDER BY sum ASC LIMIT 5")
    @least_popular_item_orders.map {|item| Item.find(item.item_id).name }
  end
end
