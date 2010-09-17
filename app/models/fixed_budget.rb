class FixedBudget < ActiveRecord::Base
  unloadable

  # Associations
  belongs_to :deliverable

  # Validations

  # Accessors
  def budget=(v)
    if v.is_a? String
      write_attribute(:budget, v.gsub(/[$ ,]/, ''))
    else
      write_attribute(:budget, v)
    end
  end

  def markup_value
    return 0 if budget.blank? || markup.blank?

    case
    when percent_markup?
      percent = markup.gsub('%','').to_f
      return budget.to_f * (percent / 100)
    when straight_markup?
      markup.gsub('$','').gsub(',','').to_f
    else
      0 # Invalid markup
    end
    
  end

  def percent_markup?
    markup && markup.match(/%/)
  end

  def straight_markup?
    markup && markup.match(/\$/)
  end
  
end