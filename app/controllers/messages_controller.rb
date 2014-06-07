class MessagesController < ApplicationController
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
	  start = Time.zone.now
	  redis = Redis.new
	  redis.psubscribe('messages.*') do |on|
	    on.pmessage do |pattern, event, data|
	      response.stream.write("event: #{event}\n")
	      response.stream.write("data: #{data}\n\n")
	    end
	  end
		rescue IOError
		  logger.info "Stream closed"
		ensure
		  redis.quit
		  response.stream.close
	end


end
