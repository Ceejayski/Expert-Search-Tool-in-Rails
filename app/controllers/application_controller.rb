class ApplicationController < ActionController::Base
  helper_method :url_shorten, :header_getter
  def url_shorten(member)
    url = Googl.shorten(member.website)
    member.short_url = url.short_url
  end

  def header_getter(member)
    doc = Nokogiri::HTML(open(member.website))
    member.headers = doc.css.map(&:text)
  end
end
