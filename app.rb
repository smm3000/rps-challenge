require 'sinatra/base'
require 'sinatra/reloader'
require './lib/turn'
require './lib/opponent'

 class MyApp < Sinatra::Base 
 
    configure :development do
        register Sinatra::Reloader 
    end 

    enable :sessions

    get '/' do
        erb :index
    end 

    post '/name' do 
        session[:player_name] = params[:player_1_name]
        redirect '/play'
    end 

    get '/play' do
        @turn = Turn.new(session)
        erb :play
    end

    post '/play' do
        session[:player_shape] = params[:shape].downcase.to_sym
        session[:opponent_shape] = Opponent.new.shape
        redirect '/play'
    end 

    run! if app_file == $0
end 