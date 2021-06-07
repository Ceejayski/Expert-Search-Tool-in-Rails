class FriendshipsController < ApplicationController
  before_action :find_person
  before_action :find_friends, only: %i[destroy]
  before_action :other_members, only: %i[new]
  def index
    @members = friends(@member)
  end

  def new; end

  def create
    respond_to do |format|
      if @member.friendships.create(friend_id: current_user.id)
        @member.friends.create(person_id: current_user.id)
        format.html { redirect_back fallback_location: root_path, notice: 'Friend added' }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @friends.destroy_all
        format.js { render js: 'window.top.location.reload(true);' }
        format.html { redirect_back fallback_location: root_path, notice: 'Unfriended' }
      end
    end
  end

  private

  def find_person
    @member = Member.find(params[:member_id])
  end

  def find_friends
    @friends = Friendship.where(person_id: [current_user.id, params[:member_id]],
                                friend_id: [params[:member_id], current_user.id])
  end

  def destroy_all
    each do |x|
      x.destroy
    end
  end
end
