json.extract!(product, :id, :title, :author, :pub_year, :category, :image, :library, :description, :condition_treatment, :adopt_status, :adopt_amount, :release_year, :dedication, :recognition, :created_at, :updated_at)
json.url(product_url(product, format: :json))
