airplane = Picture.create(name: "Airplane", image: File.open("spec/files/airplane.png"))
baboon = Picture.create(name: "Baboon", image: File.open("spec/files/baboon.png"))
cat = Picture.create(name: "Cat", image: File.open("spec/files/cat.png"))
arctichare = Picture.create(name: "Arctichare", image: File.open("spec/files/arctichare.png"))
boat = Picture.create(name: "Boat", image: File.open("spec/files/boat.png"))
fruits = Picture.create(name: "Fruits", image: File.open("spec/files/fruits.png"))
frymire = Picture.create(name: "Frymire", image: File.open("spec/files/frymire.png"))
girl = Picture.create(name: "Girl", image: File.open("spec/files/girl.png"))
monarch = Picture.create(name: "Monarch", image: File.open("spec/files/monarch.png"))
mountain = Picture.create(name: "Mountain", image: File.open("spec/files/mountain.png"))
watch = Picture.create(name: "Watch", image: File.open("spec/files/watch.png"))

nature = Tag.find_by(name: "Nature")
outdoor = Tag.find_by(name: "Outdoor")
sporting = Tag.find_by(name: "Sporting")
computer = Tag.find_by(name: "Computer")

lifestyle = Category.find_by(name: "Lifestyle")
entertainment = Category.find_by(name: "Entertainment")
health = Category.find_by(name: "Health & Fitness")
business = Category.find_by(name: "Business")
education = Category.find_by(name: "Education")
finance = Category.find_by(name: "Finance")
food = Category.find_by(name: "Food & Drink")
kids = Category.find_by(name: "Kids")
medical = Category.find_by(name: "Medical")
navigation = Category.find_by(name: "Navigation")

Screen.seed(:id,
  { id: 1, picture: airplane, category: lifestyle, tags: [sporting] },
  { id: 2, picture: baboon, category: navigation, tags: [nature] },
  { id: 3, picture: cat, category: health, tags: [outdoor] },
  { id: 4, picture: arctichare, category: finance, tags: [sporting] },
  { id: 5, picture: boat, category: navigation, tags: [sporting] },
  { id: 6, picture: fruits, category: food, tags: [nature] },
  { id: 7, picture: frymire, category: kids, tags: [computer] },
  { id: 8, picture: girl, category: kids, tags: [outdoor] },
  { id: 9, picture: monarch, category: education, tags: [nature] },
  { id: 10, picture: mountain, category: business, tags: [sporting]},
  { id: 11, picture: watch, category: finance, tags: [computer] }
)
