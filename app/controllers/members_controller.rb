class MembersController < ApplicationController
  before_action :set_member, only: %i[show edit update destroy]
  before_action :other_members, only: %i[show]
  def index
    @members = Member.all
  end

  def show
    session[:member_id] = @member.id
    @not_freinds = not_friends(@member)
    @search_results = search(@not_freinds, params[:search])
  end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
    short = url_shorten(@member)
    if @member.valid? && short
      @member.save
      @short = Shortner.create(member_id: @member.id, short_url: short, headers: header_getter(@member))
      session[:member_id] = @member.id
      redirect_to new_member_friendship_path(@member), notice: 'members created successfully'
    else

      flash[:error] = @member.errors.full_messages.to_sentence

      redirect_to new_member_path
    end
  end

  def update; end

  def edit; end

  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Post deleted successfully'
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :website, :short_url, :headers)
  end
end
