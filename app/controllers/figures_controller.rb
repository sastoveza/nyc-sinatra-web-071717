class FiguresController < ApplicationController

	get "/figures" do 
		erb :"figures/index"
	end

	get "/figures/new" do
		erb :"figures/new"
	end

	post "/figures" do

		@figure = Figure.create(params["figure"])
		
		if !params[:title][:name].empty?
			title = Title.find_or_create_by( params[:title])
			@figure.titles << title
		end

		if !params[:landmark][:name].empty?
			landmark = Landmark.find_or_create_by(params[:landmark])
			@figure.landmarks << landmark
		end

		redirect "/figures"
	end

	get "/figures/:id" do
		@figure = Figure.find_by(id: params[:id])
		erb :"figures/show"
	end

	get "/figures/:id/edit" do
		@figure = Figure.find_by(id: params[:id])

		erb :"figures/edit"
	end

	patch "/figures/:id" do
		@figure = Figure.find_by(id: params[:id])
		@figure.update( params[:figure])

		# if !params[:title][:name].empty?
		# 	title = Title.find_or_create_by( params[:title])
		# 	@figure.titles << title
		# end

		if !params[:landmark][:name].empty?
			landmark = Landmark.find_or_create_by(params[:landmark])
			@figure.landmarks << landmark
		end


		redirect "/figures/#{@figure.id}"
	end 
end