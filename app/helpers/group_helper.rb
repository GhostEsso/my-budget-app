module GroupHelper
  def total_amount(group)
    group.purchases.sum(:amount)
  rescue StandardError
    0
  end
end
