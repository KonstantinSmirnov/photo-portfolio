jQuery ($) ->
  $(document).on "turbolinks:load", ->
    @share_facebook = (link, title, image, caption, description) ->
      FB.ui
        method      : 'feed'
        link        : link
        name        : title
        #picture     : image
        picture     : $('.slider-cover-photo.slick-current img').src
        caption     : caption
        description : description
