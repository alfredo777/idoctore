class MessagesController < ApplicationController
  before_filter :set_cache_buster

  include ActionController::Live

  def show
  	response.headers['Content-Type'] = 'text/javascript'
  end
   #### crear message

  def create
  	response.headers["Content-Type"] = "text/javascript"
    @cite = CiteDoctor.find(params[:cite_id])
    @m = !params[:message].empty?
    if @m

	    if @cite.user_id == current_user.id
	       puts "paciente"
	       @to_id = @cite.doctor_id
	        else
	       puts "doctor"
	       @to_id = @cite.user_id
	    end

	    @message = MessageUserToUser.new
	    @message.user_id = current_user.id
	    @message.to_user_id = @to_id 
	    @message.cite_doctor_id = @cite.id
	    @message.message = params[:message]
	    @message.save
	    json_parce_for_chat = {message_act: @message.to_json, user_x: @message.user.to_json}
	    $redis.publish('messages.create', json_parce_for_chat.to_json)
   
    end

  end

  def paginate_messages
     @page = params[:pages].to_i + 1
     @cite = CiteDoctor.find(params[:ident_i])
     @messages = @cite.message_user_to_users.paginate(:page => @page, :per_page => 5).order('created_at DESC')
    respond_to do |format|
      format.js
    end
  end

	def events
	 response.headers["Content-Type"] = "text/event-stream"
	 sse = SSE.new(response.stream, retry: 300, event: "event-name")
	 start = Time.zone.now
	 redis = Redis.new
	   ticker = Thread.new { loop { sse.write 0; sleep 5 } }
     sender = Thread.new do
		  redis.psubscribe('messages.*') do |on|
		    on.pmessage do |pattern, event, data|
		      response.stream.write("event: #{event}\n")
		      response.stream.write("data: #{data}\n\n")
		    end
		  end
		 end
		  ticker.join
      sender.join
	 rescue IOError
	  logger.info "Stream closed"
	 ensure
	 	Thread.kill(ticker) if ticker
    Thread.kill(sender) if sender
	  redis.quit
	  response.stream.close
	end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
