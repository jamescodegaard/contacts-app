class Contact < ApplicationRecord

  def friendly_created_at
    created_at.strftime("%A, %d %b %Y %l:%M %p")
  end

  def full_name
    "#{first_name} #{middle_name} #{last_name}"
  end

end
