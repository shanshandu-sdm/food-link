class ApplicationMailer < ActionMailer::Base
  default from: 'cs.foodlink@gmail.com'

  def request_confirm(food_donation)
    @food_donation = food_donation
    restaurant_email = @food_donation.user.email
    charity_email = User.find_by(id: @food_donation.charity_id).email
    mail(to: [restaurant_email, charity_email], subject: 'Request Confirmation')
  end
end
