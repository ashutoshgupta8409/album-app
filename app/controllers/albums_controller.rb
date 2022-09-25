class AlbumsController < ApplicationController
  before_action :authenticate_user!

  def index
    @albums = current_user.albums.all
  end

  def delete_photo_attachment
    image = ActiveStorage::Attachment.find(params[:id])
    image.purge
    redirect_back(fallback_location: albums_path)  
  end  

  def show
    @album = Album.find(params[:id])
  end

  def new
    @album = Album.new
  end

  def create
    @album = current_user.albums.new(album_params)
    
    if @album.save
     
      AlbumMailer.welcome_email(current_user).deliver_now
      redirect_to @album
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.find(params[:id])
  end

  def update
    @album = Album.find(params[:id])

    if @album.update(album_params)
      redirect_to @album
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to root_path, status: :see_other
  end

  private
    def album_params
      params.require(:album).permit(:title, :description, :published, :tagged, :image, photos:[])      
    end
end
