class TopController < ApplicationController
  
  def index
    @question = Question.new
    @feed_contents = current_user.group.feed_contents.includes(:content).page(params[:page]).per(5)
    @feed_contents_resource = @feed_contents.map(&:content)
    
    
    #feed_contents = current_user.group.feed_contents.includes(:content)#現在ログインしているユーザーのfeed_contentを複数取得する
    #@feed_contents = feed_contents.map(&:content)#feed_contentsからそれぞれcontentのみ取得する
    
    #@questions = current_user.group.questions#現在ログインしているユーザーが所属するグループのquestionを全て取得する
    
  
  end
  
end
