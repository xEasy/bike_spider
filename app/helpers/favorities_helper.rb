module FavoritiesHelper
  def post_favority_class(post)
    Favority.where(post_id: post.id).exists? ? 'has_fav' : 'wasnt_fav'
  end
end
