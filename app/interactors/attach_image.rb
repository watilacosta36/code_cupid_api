# frozen_string_literal: true

class AttachImage
  include Interactor

  def call
    attach_image
  end

  private

  def attach_image
    context.images.each do |img|
      decoded_img = Base64.decode64(img['image_data'])
      temp_file = build_temp_file(decoded_img)

      context.user.images.attach(
        io: temp_file,
        filename: "image_#{Time.now.to_i}.jpg",
        content_type: 'image/jpeg'
      )
    ensure
      temp_file.close
      temp_file.unlink
    end
  end

  def build_temp_file(decoded_img)
    temp_file = Tempfile.new(%w[image_ .jpg], binmode: true)
    temp_file.write(decoded_img)
    temp_file.rewind
    temp_file
  end
end
