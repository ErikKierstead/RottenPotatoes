class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
 
#sort = params[:sort] || session[:sort]
#   if sort == 'title'
#      ordering = {:order => :title}
#      end
    
 end

  def index
    @movies = Movie.all

    sort = params[:sort] || session[:sort]
    if sort == 'title'
       ordering = {:order => :title}
    end
      
#@movies = Movie.order(params[:sort])
#@movies = Movie.all
#@movies = Movie.order(params[:sort])
#if(params[:sort].to_s == 'title')
#       session[:sort] = params[:sort]
#       @movies = @movies.sort_by{|m| m.title}
# end

  def new
    # default: render 'new' template
  end

#def sort
#     sort = params[:sort] || session[:sort]
#     if sort == 'title'
#        ordering = {:order => :title}
#     end
#   end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
