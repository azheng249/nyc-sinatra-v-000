class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all

    erb :'figures/index'
  end

  # New Figure was created. Posted from '/figures/new'
  post '/figures' do

    @figure = Figure.create(name: params[:figure][:name])
    @figure.title_ids = params[:figure][:title_ids]
    @figure.landmark_ids = params[:figure][:landmark_ids]

    if !params[:title][:name].empty?
      new_title = Title.create(name: params[:title][:name] )
      @figure.titles << new_title
    end

    if !params[:landmark][:name].empty?
      new_landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
      @figure.landmarks << new_landmark
    end

    @figure.save
    erb :'figures/show', locals: {message: "Successfully created figure."}
  end

  # Gets form to make new Figure
  get '/figures/new' do
    erb :'figures/new'
  end

  # Gets form to edit Figure based on :id
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'figures/edit'
  end

  # Shows the figure
  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'figures/show'
  end

  post '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    @figure.title_ids = params[:figure][:title_ids]
    @figure.landmark_ids = params[:figure][:landmark_ids]

    if !params[:title][:name].empty?
      new_title = Title.create(name: params[:title][:name])
      @figure.titles << new_title
    end

    if !params[:landmark][:name].empty?
      new_landmark = Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
      @figure.landmarks << new_landmark
    end

    @figure.save

    erb :'figures/show', locals: {message: "Figure successfully edited."}
  end

end
