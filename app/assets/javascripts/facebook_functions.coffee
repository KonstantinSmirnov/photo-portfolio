jQuery ($) ->
  $(document).on "turbolinks:load", ->
    @share_facebook = (link, title) ->
      FB.ui
        method      : 'feed'
        link        : link
        name        : title
        picture     : $('.slider-cover-photo.slick-current img').attr('src')
