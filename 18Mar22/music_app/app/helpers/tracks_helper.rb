module TracksHelper
    def uglify_lyrics(lyrics)
        lines = lyrics.split("\r\n")
        lines.map! { |line| '&#9835; ' + h(line) }

        "<pre>#{lines.join("\n")}</pre>".html_safe
    end
end