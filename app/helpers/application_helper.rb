module ApplicationHelper
  def friend_btn(member)
    pre_vote = member.friendships.find { |friend| friend.friend_id == current_user.id }
    if pre_vote
      (button_to 'Unfriend', member_friendship_path(member, pre_vote), method: :delete,
                                                                       class: 'btn btn-danger btn-sm')
    else
      (button_to 'Add friend', member_friendships_path(member), method: :post, class: 'btn btn-success btn-sm')
    end
  end

  def header_list(header)
    arr = YAML.load(header)
    !arr.empty? ? arr.join(', ') : 'Website has no headers'
  end

  def link_text(link)
    link.sub('https://', '')
  end

  def camelize(name)
    arr = name.split(' ')
    result = []
    arr.each do |x|
      result << x[0].upcase + x[1..-1]
    end
    result.join(' ')
  end

  def friend_count(member)
    pluralize(member.friends.size, 'friend')
  end

  def header_count(array)
    return "an header \"#{array[0]}\"" if array.size <= 1

    text = pluralize(array.size - 1, 'more header')

    "an header \"#{array[-1]}\" and #{text}"
  end

  def mutuals_count(user, member)
    return "#{camelize(user.name)} have no mutual friends with #{member.name}" if user.mutuals(member).size == 0

    text = pluralize(user.mutuals(member).size, 'mutual friend')

    "#{camelize(user.name)} has #{text} with #{member.name}"
  end

  def member_getter(friendship)
    Member.find(friendship.person_id)
  end

  def mutual_friends(user, member)
    res = user.mutuals(member)
    return if res.size == 0
    return "#{member_getter(res[0]).name} knows #{camelize(member.name)}" if res.size == 1

    ", #{camelize(user.name)}'s friends #{member_getter(res[0]).name} and #{member_getter(res[1]).name} knows #{camelize(member.name)}" if res.size > 1
  end

  def bootstrap_class_for_flash(flash_type)
    case flash_type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      flash_type.to_s
    end
  end
end
