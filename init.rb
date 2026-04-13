require 'redmine'

Redmine::Plugin.register :redmine_embedded_video do
 name 'Redmine Embedded Video'
 author 'Nikolay Kotlyarov, PhobosK, Jan Pilz'
 description 'Embeds attachment videos, video URLs or Youtube videos. Usage (as macro): video(ID|URL|YOUTUBE_URL). Uses native HTML5 video.'
 url 'http://www.redmine.org/issues/5171'
 version '0.2.0'
end

Redmine::WikiFormatting::Macros.register do
   desc "Wiki video embedding"

    macro :video do |o, args|
        @width = args[1].gsub(/\D/,'') if args[1]
        @height = args[2].gsub(/\D/,'') if args[2]
        @width ||= 400
        @height ||= 300
        @num ||= 0
        @num = @num + 1
        attachment = o.attachments.find_by_filename(args[0]) if o.respond_to?('attachments')

        if attachment
            file_url = url_for(:only_path => false, :controller => 'attachments', :action => 'download', :id => attachment, :filename => attachment.filename)
        else
            file_url = args[0].gsub(/<.*?>/, '').gsub(/&lt;.*&gt;/,'')
        end

        if /(youtube.com\/watch\?v=|youtu.be\/)(?<video_id>.*)/i =~ args[0]
            # https://developers.google.com/youtube/player_parameters
            out = <<END
<iframe type="text/html" width="#{@width}" height="#{@height}"
  src="https://www.youtube.com/embed/#{video_id}"
  frameborder="0" allowfullscreen>
</iframe>
END
        else
             out = <<END
<video width="#{@width}" height="#{@height}" playsinline controls>
  <source src="#{file_url}">
  Your browser does not support the video tag.
</video>
END
        end

    out.html_safe
  end
end
