class HelpController < ApplicationController
  def index
  end

  def search_help
    data = File.read("#{Rails.root}/public/static_json/help_videos.json")
    @data = Array(data)
    prefix = "Historia"
    name = @data.find(:all, :conditions => ["name LIKE ?", "#{prefix}%"])
    
    puts @data
    puts name 

    respond_to do |format|
      format.js
    end
  end

  def contact
  end
end
