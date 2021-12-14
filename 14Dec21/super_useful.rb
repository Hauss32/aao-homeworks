# PHASE 2
def convert_to_int(str)
  begin
    Integer(str)
  rescue => exception
    puts exception
  else
    
  end
end

# PHASE 3
class CoffeeError < StandardError
  def message
    puts "Mmm, coffee! Ok, try again."
  end
end

class UnknownFruitError < StandardError
  def message
    puts "That doesn't look like a fruit I know of! :("
  end
end

FRUITS = ["apple", "banana", "orange"]

def reaction(maybe_fruit)
  if FRUITS.include? maybe_fruit
    puts "OMG, thanks so much for the #{maybe_fruit}!"
  elsif maybe_fruit == "coffee"
    raise CoffeeError
  else
    raise UnknownFruitError
  end 
end

def feed_me_a_fruit
  puts "Hello, I am a friendly monster. :)"

  begin
    puts "Feed me a fruit! (Enter the name of a fruit:)"
    maybe_fruit = gets.chomp
    reaction(maybe_fruit) 
  rescue CoffeeError => error
    puts error.message
    retry
  rescue UnknownFruitError => error
    puts error.message
  rescue => error
    puts error
  end
end  

# PHASE 4
class BestFriend
  def initialize(name, yrs_known, fav_pastime)
    @name = name
    @yrs_known = yrs_known
    @fav_pastime = fav_pastime

    raise ArgumentError.new("It'll take at least 5 years to become best friends!") if yrs_known < 5
    raise ArgumentError.new("You forgot to tell me your name!") if name.empty?
    raise ArgumentError.new("Real besties share their fav pastime :(") if fav_pastime.empty?
  end

  def talk_about_friendship
    puts "Wowza, we've been friends for #{@yrs_known}. Let's be friends for another #{1000 * @yrs_known}."
  end

  def do_friendstuff
    puts "Hey bestie, let's go #{@fav_pastime}. Wait, why don't you choose. 😄"
  end

  def give_friendship_bracelet
    puts "Hey bestie, I made you a friendship bracelet. It says my name, #{@name}, so you never forget me." 
  end
end


