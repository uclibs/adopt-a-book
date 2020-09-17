require('csv')

csv_text = File.read(Rails.root.join('lib', 'seeds', 'AAB.csv'))
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
  t.adopter_fname = row['Adopter Fname']
  t.adopter_lname = row['Adopter Lname']
  t.adopter_address = row['Adopter Address']
  t.adopter_phone = row['Adopter Phone']
  t.adopter_email = row['Adopter Email']
  t.adopt_time = row['Adopt time']
  t.save
end

# Delete table contents
# Product.delete_all
