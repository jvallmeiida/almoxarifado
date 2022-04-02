class Material < ApplicationRecord
  attr_accessor :quantity_entrance, :quantity_exit

  belongs_to :user, optional: true
  has_many :material_logs

  validates_uniqueness_of :name
  validates_numericality_of :quantity
  validates :quantity, numericality: {:greater_than => 0}, on: :create

  before_update :have_stock_for_pick_up?

  private

  def have_stock_for_pick_up?
    return if quantity_exit.blank? || quantity_entrance.present?

    material = Material.find_by(name: name)
    total = material.quantity - quantity_exit.to_i

    return if total.positive? || total == 0

    errors.add :base, "Retirada mais do que existe no estoque."

    throw(:abort)
  end
end