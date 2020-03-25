class PhotosController < ApplicationController
  def index
    # @photos = Photo.all.order({ :created_at => :desc })
    @q = Photo.ransack(params[:q])
    @photos = @q.result(:distinct => true).includes(:user)

    # id = @photos.sample.id
    id = params.fetch("input_form_id", nil)
    p session.fetch(:uudh).nil?
    if session[:link_id] == nil
      p session[:link_id]
      puts "-------------"
      session[:link_id] = Array.new
      p session[:link_id]
      puts "=========="
      session[:link_id].push(id)
      p session[:link_id]
    else
      session[:link_id].push(id)
      p session[:link_id]
      puts "***************"
    end
    render({ :template => "photos/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @photo = Photo.where({:id => the_id }).at(0)

    render({ :template => "photos/show.html.erb" })
  end

  def create
    @photo = Photo.new
    @photo.caption = params.fetch("query_caption")
    @photo.image = params.fetch("query_image")
    @photo.owner = params.fetch("query_owner")
    @photo.likes_count = params.fetch("query_likes_count")
    @photo.comments_count = params.fetch("query_comments_count")

    if @photo.valid?
      @photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :notice => "Photo failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)

    @photo.caption = params.fetch("query_caption")
    @photo.image = params.fetch("query_image")
    @photo.owner = params.fetch("query_owner")
    @photo.likes_count = params.fetch("query_likes_count")
    @photo.comments_count = params.fetch("query_comments_count")

    if @photo.valid?
      @photo.save
      redirect_to("/photos/#{@photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{@photo.id}", { :alert => "Photo failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)

    @photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end
end
