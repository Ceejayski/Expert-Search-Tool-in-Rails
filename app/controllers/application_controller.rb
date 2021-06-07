class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    if session[:member_id]
      @current_user ||= Member.find(session[:member_id])
    else
      @current_user = nil
    end
  end

  def url_shorten(member)
    # link = CGI.escape(member.website)
    # url = "https://cutt.ly/api/api.php?key=a6afc90116ff77be651af7ebe3cacc9d6fd57&short=#{link}"
    # JSON.parse(HTTParty.get(url).body)['url']['shortLink']
    HTTParty::Basement.default_options.update(verify: false)
    id = Member.all.last ? Member.all.last.id + 1 : 0
    link = 'https://api.tinyurl.com/create'
    body = { url: member.website, domain: 'tiny.one', alias: "samplexpert#{member.name}" }
    headers = {
      'accept' => 'application/json',
      'Authorization' => 'Bearer FwvYaqwvS2AlLk5XH8nrIKILuMbWVjqsRBTGdyjl9J44TefIXzjaBkfWEheW',
      'Content-Type' => 'application/json'
    }
    response = HTTParty.post(link,
                             body: body.to_json,
                             headers: headers)

    JSON.parse(response.body)['data']
  end

  def header_getter(member)
    url = URI.open(member.website)
    doc = Nokogiri::HTML(url, nil, 'utf-8')
    doc.css('h1', 'h2', 'h3').map(&:content)
  end

  def other_members
    @members = Member.where.not(id: current_user.id)
  end

  def befriend(user)
    friends << user
    user.friends << self
  end

  def mutuals(member)
    a_friends = friends
    b_friends = member.friends
    a_friends.select do |friend|
      b_friends.find_by(person_id: friend.person_id)
    end
  end

  def not_friends(member)
    member.friends.filter_map { |friend| Member.where.not(id: [friend.person_id, member.id]) }[0].to_a
  end

  def friends(member)
    member.friends.filter_map { |friend| Member.find(friend.person_id) }
  end

  def search(members, search)
    unless search.nil?
      r = /(?i)#{search.split(' ').map { |w| Regexp.escape(w) }.join('|')}/
      results = Hash.new { |x, y| x[y] = [] }
      members.each do |member|
        header = YAML.load(member.shortner.headers)
        header.each do |str|
          results[member] << str if str =~ r || str =~ /(?i)#{search}/
        end
      end
      results.sort_by { |_x, y| y.size }.to_h
    end
  end
end
