class MoviesController < ApplicationController
    
    def movie_params
        params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
    
    def index
        @movies = Movie.all
        respond_to do |format|
            format.html
            format.csv {render text: @movies.to_csv}
            format.xls { send_data @movies.to_csv(col_sep: "\t") }
        end
    end
    
    def import
        Movie.import(params[:file])
        flash[:notice] = "Data imported"
        redirect_to movies_path notice: "Data Imported."
    end
   
    def show
        id = params[:id] # retrieve movie ID from URI route
        @movie = Movie.find(id) # look up movie by unique ID
    end
    
    def new
        @movie = Movie.new
        # default: render 'new' template
    end 
    
    def create
        @movie = Movie.create!(movie_params)
        flash[:notice] = "#{@movie.title} was successfully created."
        redirect_to movie_path(@movie)
    end
    
    def edit
        @movie = Movie.find params[:id]
    end

    def update
        @movie = Movie.find params[:id]
        @movie.update_attributes!(movie_params)
        flash[:notice] = "#{@movie.title} was successfully updated."
        redirect_to movie_path(@movie)
    end
    
    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie '#{@movie.title}' deleted."
        redirect_to movies_path
    end
    
    def search_tmdb
        @movies = Movie.find_in_tmdb(params[:search_terms])
    end
    
end