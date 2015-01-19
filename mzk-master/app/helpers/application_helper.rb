module ApplicationHelper
  def ugly_lyrics(lyrics)
    lyr = h(lyrics)
    lines = lyr.split("\n")
    lyr = lines.map do |line|
      "&#9835 #{line}"
    end.join("\n")

    "<pre>#{lyr}</pre>"
  end
end
