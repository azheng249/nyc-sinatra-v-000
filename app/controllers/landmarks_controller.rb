class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'landmarks/index'
  end

  # Posted from /landmarks/new
  # Create a new landmark and optional associated figure
  post '/landmarks' do
    @landmark = Landmark.create(
      name: params[:landmark][:name],
      year_completed: params[:landmark][:year_completed],
      figure_id: params[:landmark][:figure_id]
    )

    # Create new figure with title if user did not select a figure from selection bar and gave a figure name
    if !params[:landmark][:figure_id] && !params[:figure][:name].empty?
      figure = Figure.create(name: params[:figure][:name])
      title = Title.create(name: params[:title][:name])
      figure.titles << title
    end

    @landmark.figure_id = figure.id if figure
    @landmark.save

    erb :'landmarks/show', locals: {message: "Successfully created landmark."}
  end

  get '/landmarks/new' do
    erb :'landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/show'
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'landmarks/edit'
  end

  # Posted from /landmarks/:id/edit
  post '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(
      name: params[:landmark][:name],
      year_completed: params[:landmark][:year_completed],
      figure_id: params[:landmark][:figure_id]
    )

    # Create new figure with title if user did not select a figure from selection bar and gave a figure name
    if !params[:landmark][:figure_id] && !params[:figure][:name].empty?
      figure = Figure.find_or_create(name: params[:figure][:name])
      title = Title.find_or_create(name: params[:title][:name])
      figure.titles << title
    end

    @landmark.figure_id = figure.id if figure
    @landmark.save

    erb :'landmarks/#{params[:id]}', locals: {message: "Landmark edited successfully."}
  end


end
