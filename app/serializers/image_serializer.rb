class ImageSerializer
  include FastJsonapi::ObjectSerializer

  def self.serialize(image_package, search_params)
    { data:
      { id: nil,
        type: 'image',
        attributes:
        {
          location: search_params,
          image_url: image_package.url,
          crediting:
          {
            disclaimer: "Image URLS must be directly used or embedded (hotlinked) in applications. Information on hotlinking located here (https://help.unsplash.com/en/articles/2511271-guideline-hotlinking-images)"

          }
        }

      }

    }
  end
end
