class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show; end

  def new
    @member = Member.new
  end

  def create
    @member = member.new(member_params)
    url_shorten(@member)
    header_getter(@member)
    if @posts.save
      redirect_to @member, notice: 'Post created successfully'
    else
      redirect_to new_post_path, notice: 'There are some errors'
    end
  end

  def update; end

  def edit; end

  def destroy; end

  private

  def member_params
    params.require(:member).permit(:name, :website, :short_url, :headers)
  end
end
