class SearchesController < ApplicationController
  def search
    tag = Tag.find_by(tag: params[:word])
    if tag.nil?
      @flag = true
    else
      @books = Book.where(tag_id: tag.id)
    end
  end
end
