file = File.read('lib/assets/recipes-en.json')
json = JSON.parse(file)

unique_categories = json.pluck('category').uniq.reject(&:blank?)
unique_categories.each do |categ|
  Category.create(title: categ)
end

mapped_categories = Category.all.pluck(:title, :id).to_h

json.each do |j|
  recipe = Recipe.new(title: j['title'], 
    cooktime: j['cook_time'], 
    preptime: j['prep_time'], 
    ingredients: j['ingredients'], 
    rating: j['ratings'], 
    author: j['author'], 
    image_link: j['image'])
  recipe.category_id = mapped_categories[j['category']] if j['category'].present?
  recipe.save!
end