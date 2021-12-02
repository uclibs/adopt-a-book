desc "Clear pending books"
 task :clear_pending_books => :environment do
     Product.where(adopt_status: "pending").each do |product|
       if product.adopter_id.nil? &&(Time.now - product.updated_at.to_time) > 1800
         product.adopt_status = "available"
         product.save
       end
  end
end
