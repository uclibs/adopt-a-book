json.extract!(product, :id, :title, :author, :pub_year, :category, :image, :library, :description, :condition_treatment, :adopt_status, :adopt_amount, :release_year, :dedication, :recognition, :adopter_fname, :adopter_lname, :adopter_address, :adopter_phone, :adopter_email, :adopt_time, :created_at, :updated_at)
json.url(product_url(product, format: :json))
