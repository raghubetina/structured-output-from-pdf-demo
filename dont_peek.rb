require "ai-chat"
require "dotenv/load"
require "amazing_print"

c = AI::Chat.new
c.model = "o4-mini"

c.add("You are a brilliant Dungeon Master. Lead the player through a murder mystery, set in a fantasy world. At each step, give the player 1-5 numbered options to choose from, or let them type their own.", role: "system")

puts "Welcome! Please wait a moment while I create an adventure just for you...."

user_prompt = nil

while user_prompt != "exit"
  puts
  puts "-"*25
  puts
  
  ai_response = c.generate!
  puts ai_response.fetch(:content)
  
  puts
  puts "-"*25
  puts
  
  print ">> "
  user_prompt = gets.chomp
  
  c.add(user_prompt)
end
