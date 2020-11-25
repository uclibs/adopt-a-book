# AdoptionMailer mailer sends email to adopter and admin when adoption is complete
class AdoptionMailer < ActionMailer::Base
  default from: ENV['APP_MAIL_ADDRESS']

  def thank_you_email
    @adopter = params[:adopter]
    @product_count = params[:product_count]
    @subject = 'UC Libraries Adopt-A-Book confirmation'
    mail(from: ENV['ADMIN_MAIL_ADDRESS'], to: @adopter.email, subject: @subject)
  end

  def adoption_notification_email
    @product_ids = params[:product_ids]
    @product_titles = Product.find(@product_ids).pluck(:title)
    @product_count = @product_ids.count
    @adopter = params[:adopter]
    @subject = 'Adopted Book PRE-ORDER'
    mail(to: ENV['ADMIN_MAIL_ADDRESS'], subject: @subject)
  end
end
