administrator = Role.find_by(name: "administrator")
customer = Role.find_by(name: "customer")

airplane = Screen.find_by(id: 1)
baboon = Screen.find_by(id: 2)
cat = Screen.find_by(id: 3)
arctichare = Screen.find_by(id: 4)
boat = Screen.find_by(id: 5)

User.seed_once(:email) do |user|
  user.id = 1
  user.email = "keith.ward@bethel.com"
  user.first_name = "Keith"
  user.last_name = "Ward"
  user.roles = [administrator, customer]
  user.downloaded = [airplane, baboon, cat]
  user.favorites = [arctichare, boat]
end

User.seed_once(:email) do |user|
  user.id = 13
  user.email = "customer@gmail.com"
  user.first_name = Forgery::Name.first_name
  user.last_name = Forgery::Name.last_name
  user.roles = [customer]
end

User.all.map { |u| u.update_attributes!(password: "asdfasdf", password_confirmation: "asdfasdf") }
