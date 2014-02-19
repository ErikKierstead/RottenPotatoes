class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
 
 end

  def index
#raise params.inspect

    @movies = Movie.all
    @all_ratings = Movie.uniq.pluck(:rating)

    if params[:sort] == nil
       sort = session[:sort]
#raise params.inspect
#raise session.inspect
    else
       sort = params[:sort]
    end
#sort = params[:sort] || session[:sort]

   session[:sort] = params[:sort]

if sort == 'title'
       
       session[:date] = "desc"
       session[:hilite]= "title"

       if(session[:direction] == 'asc')
          @movies = @movies.sort_by{|m| m.title}.reverse
          session[:direction] = 'desc'
       
       else
          @movies = @movies.sort_by{|m| m.title}
          session[:direction] = 'asc'
       end

    elsif sort == 'date'

       session[:direction] = "desc"
       session[:hilite] = "date"

       if(session[:date] == 'asc')
          @movies = @movies.sort_by{|m| m.release_date}.reverse
          session[:date] = 'desc'
       
       else
          @movies = @movies.sort_by{|m| m.release_date}
          session[:date] = 'asc'
      
       end

    elsif session[:hilite] = ""

   end


end


#if(params[:sort].to_s == 'title')
#       session[:sort] = params[:sort]
#       @movies = @movies.sort_by{|m| m.title}
# end

  def new
    # default: render 'new' template
  end

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
