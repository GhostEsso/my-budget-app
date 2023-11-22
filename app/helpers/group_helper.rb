module GroupHelper
  require 'uri'

  def total_amount(group)
    group.purchases.sum(:amount)
  rescue StandardError
    0
  end

  def check_url(url)
    default = 'no-pictures.png'
    return default unless url.present?

    extension = File.extname(url)
    return url if %w[.png .gif .jpg].include?(extension.downcase) && url =~ URI::DEFAULT_PARSER.make_regexp

    default
  end
end
