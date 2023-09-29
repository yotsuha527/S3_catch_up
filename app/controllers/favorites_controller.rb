class FavoritesController < ApplicationController
  def create
    # if !Favorite.find(book_id: params[:book_id], user_id: current_user.id).exists?
      book = Book.find(params[:book_id])
      @favorite = current_user.favorites.new(book_id: book.id)
      @favorite.save
      redirect_to request.referer
      # render "favorites/replace_btn.js.erb"
    # end
  end

  def destroy
    # if Favorite.find(book_id: params[:book_id], user_id: current_user.id).exists?
      book = Book.find(params[:book_id])
      @favorite = current_user.favorites.find_by(book_id: book.id)
      @favorite.destroy
      redirect_to request.referer
      # render "favorites/replace_btn.js.erb"
    # end
  end
end
