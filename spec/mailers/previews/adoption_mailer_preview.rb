# Preview all emails at http://localhost:3000/rails/mailers/adoption_mailer
class AdoptionMailerPreview < ActionMailer::Preview
  def thank_you_email
    AdoptionMailer.with(adopter: Adopter.first, product_count: 3).thank_you_email
  end

  def adoption_notification_email
    AdoptionMailer.with(product_ids: %w[1 2 3], adopter: Adopter.first).adoption_notification_email
  end
end
