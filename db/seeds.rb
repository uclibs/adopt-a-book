require('csv')

csv_text = File.read(Rails.root.join('lib', 'seeds', 'Adopters.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'utf-8')
csv.each do |row|
  t = Adopter.new
  t.fname = row['Adopter Fname']
  t.lname = row['Adopter Lname']
  t.address = row['Adopter Address']
  t.phone = row['Adopter Phone']
  t.email = row['Adopter Email']
  t.save
end

csv_text = File.read(Rails.root.join('lib', 'seeds', 'Products.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'utf-8')
csv.each do |row|
  t = Product.new
  t.title = row['Title for Print and Web']
  t.author = row['Author (First Name Last Name)']
  t.pub_year = row['Year of Publication']
  t.category = row['Category']
  t.image = row['Image Filename']
  t.library = row['Library Full Name']
  t.description = row['Item Description']
  t.condition_treatment = row['Conservation Blurb']
  t.adopt_status = row['Adopt Status']
  t.adopt_amount = row['Adoption Goal']
  t.release_year = row['Year']
  t.dedication = row['Dedication']
  t.recognition = row['Recognition']
  t.adopter_id = row['Adopter ID']
  t.adopt_time = row['Adopt time']
  t.save
end
