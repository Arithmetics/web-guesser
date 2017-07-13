require 'sinatra'
require 'sinatra/reloader'

class Secret
  attr_accessor :number, :guesses_left
  
  def initialize
    @number = rand(100)
    @guesses_left = 5
  end
  
  def change
    @number = rand(100)
  end
  
  def sub_guess
    @guesses_left -= 1
  end
  
  def reset_guess 
    @guesses_left = 5
  end
  
end


secret = Secret.new



get '/' do
  number = secret.number
  message = check(params["guess"].to_i, secret)
  cheater = cheata(params["cheat"], secret)
  back_color = parse(params["guess"].to_i, secret)
  erb :index, :locals => {:number => number, :message => message, :back_color => back_color, :cheater => cheater}
  
end


def check(guess, secret)
  if guess == secret.number
      secret.change
      secret.reset_guess
      return "nice you guessed it, (#{secret.number}) i have a new number now, try to guess it"
    elsif guess < secret.number
      secret.sub_guess
      s = secret.guesses_left
      return "too low! #{s} guesses left"
    elsif guess > secret.number
      secret.sub_guess
      s = secret.guesses_left
      return "too high! #{s} guesses left"
  end
end

def parse(guess, secret)
  if guess == secret.number
      return 'green'
    elsif guess < secret.number
      return 'red'
    elsif guess > secret.number
      return 'orange'
  end
           
end

def cheata(boo, secret)
  if boo.to_s == "true"
    
    return " #{boo} cheat activated, the number is #{secret.number}"
    
  else
    
    return "not activated"
    
  end
  
  
end