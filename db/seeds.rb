# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(
    email: "alexjalg_xD@gmail.com", 
    uid: "123SDFSDdsfg!123asda", 
    provider: "facebook" )
Token.create(
    token: "VMDKEIQQS123ALJ67575",
    expires_at: DateTime.now + 1.year,
    user: user )
poll = MyPoll.create( 
    title: "Que leguaje de programación es mejor para ti?",
    description: "Queremos saber que lenguajes son los preferidos de la pipol",
    expires_at: DateTime.now + 1.year,
    user: user )
question = Question.create(
    description: "Te importa la eficiencia de ejecución del programa?",
    my_poll: poll )
Answer.create(
    description: "a) Sí, me importa mucho",
    question: question )