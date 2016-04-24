# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


users = User.create!([{name: 'Manolo', email: 'jo@gmail.com'}])

post = Contribution.create!({contr_type: 'post', title: 'QUE ES EL RISSOTTO?', content: 'Biene Encarna a hacer rissotto o no biene?', user: users.first})
comment = Contribution.create!({contr_type: 'comment', parent: post, user: users.first, content: 'Quizas biene Perete con la Guitarra?'})
reply = Contribution.create!({contr_type: 'reply', parent: comment, user: users.first, content: 'Agorrotin, agarrotan'})