class Api::GlitchifyController < Api::ApplicationController

  def modbadge
    expires_in 24.hours, public: true
    ffz_room = HTTParty.get("https://api.frankerfacez.com/v1/room/#{params[:username]}")
    unless ffz_room.success?
      head 404 and return
    end
    mod_url = ffz_room['room']['moderator_badge']
    unless mod_url
      head 404 and return
    end
    mod_png = HTTParty.get(mod_url).parsed_response
    chunky_mod = ChunkyPNG::Image.from_blob(mod_png)
    output = ChunkyPNG::Image.new(18, 18, ChunkyPNG::Color.from_hex("#34ae0a"))
    output.compose!(chunky_mod, 1, 1)
    send_data output, type: 'image/png', disposition: 'inline'
  end

end
