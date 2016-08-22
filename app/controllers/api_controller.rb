class ApiController < ApplicationController
  skip_before_filter :verify_authenticity_token

 # get
 # /api/lookup
 # params device_id
 #I believe this is depriciated. Should be removed.
  def lookup
    @user = User.find_by( device_id: params[:device_id])
    if @user
        render :json => {sucess: 'true' , message:'user exists'}
    else
       regcode
    end
  end

  # get
  # /api/unregistered
  # params device_id
  # returns unique_id
  def unregistered
    @unregistered = UnregisteredDevice.create(device_id: params[:device_id] , unique_id: generate_code(10))
    if @unregistered
      render :json => { sucess: 'true',
        message: "Device is not Registered",
        data:{
          registration_id: @unregistered[:unique_id]
              }
          }
    else
       render :json => {sucess: "false", error: "server error"}
    end
  end

 # get
 # api/regcode
 #params device_id
 # returns unique_id

 def regcode
   @unreg = UnregisteredDevice.find_by(device_id: params[:device_id])
   if @unreg
     render :json => { sucess: 'true',
       message: "Device is not Registered",
       data:{registration_id: @unreg[:unique_id],
                      registered: @unreg[:active]
            }
          }
   else
     unregistered
   end

 end


  # post
  # api/service
  # params device_id , requested_service
  # returns success
  # this will also need to send sms
  def service
    @user = User.find_by( device_id: params[:device_id])
    if @user

      @request = RequestedAction.create(device_id: params[:device_id], requested_service: params[:message])
      if @user.caregivers.size == 0
            render :json => {sucess: 'false' ,
                              message: 'no careivers registered'}
      elsif @request
          success = send_message
          if success
            render :json => {sucess: 'true' ,
                              message: 'request processed'}
          else
            render :json => {sucess: 'false' ,
                              message: 'message failed to send'}
          end

      else
          render :json => {sucess: 'false' ,
                            error: 'request failed'}
      end
    else
      regcode
    end
  end

  private

  # def request_params
  #   params.require(:request).permit(:device_id , :requested_service)
  # end

  def generate_code(number)
    charset =  Array('a'..'z')
    Array.new(number) { charset.sample }.join
  end

  def get_token
    @token = Oauth.first
    if !@token || @token.expiration_time > Time.now
      url = URI.parse(ENV['RINGCENTRAL_PATH'] + '/restapi/oauth/token')
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url.path)

      data = {
        grant_type: 'password',
        username: ENV['RINGCENTRAL_LOGIN'],
        password: ENV['RINGCENTRAL_PASSWORD'],
        extension: '101',
        refresh_token_ttl: '-1'
        }

      request.add_field('Authorization', 'Basic ' + ENV['RINGCENTRAL_SECRET'])
      request.add_field('Content-Type','application/x-www-form-urlencoded;charset=UTF-8')

      response = http.request(request, URI.encode_www_form(data))
      puts "HTTP RESONSE \n"
      puts response.body
      puts "END HTTP RESPONSE \n"
      puts response.code
      if response.code == '200'
        body = JSON.parse response.body
        puts "response success"
        puts response.body
        if @token
          puts "token updated"
          @token.update(token: body['access_token'])
          @token.update(expiration_time: Time.now + 1.hour)
        else
          "New Token Created"
          @token = Oauth.create(token: body['access_token'], expiration_time: Time.now + 1.hour, name: 'RingCentral')
        end
        puts "return token"
        return body['access_token']
      else
        puts "failed"
        return false
      end
    else
      puts "token in database"
      return @token.token
    end
  end

  def send_message
    token = get_token
    puts "token = "
    puts  token
    if token
      url = URI.parse(ENV['RINGCENTRAL_PATH'] + '/restapi/v1.0/account/~/extension/~/sms')

      @user = User.find_by(device_id: params[:device_id])
      if @user
        @user.caregivers.each do |cargiver|
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true

          request = Net::HTTP::Post.new(url.path)
          request.add_field('Authorization','Bearer ' + token.to_s)
          request.add_field('Content-Type', 'application/json')

          @message = @user.first_name + ' ' + @user.last_name + ' has requested help by invoking the Amazon Echo Application “Call For Help”'
          @message = @message + ' Please check on ' +  @user.title + ' ' + @user.last_name + ', send help, or call 911. '

          if params[:message]
            @message = @message +  " "+ @user.title + ' ' + @user.last_name + " made the following statement: " + params[:message]
          end

          if @user.home_phone
            @message = @message + "\n Home: " + @user.home_phone
          end

          if @user.cell_phone
            @message = @message + "\n Cell: " + @user.cell_phone

          end
          json = {"to" => [],
                  "from" => {"phoneNumber" => ENV['RINGCENTRAL_LOGIN']},
                  "text" => @message}

          json["to"].push({ "phoneNumber" => "1" + cargiver.phone_number.to_s})
          response = http.request(request, json.to_json)
          puts response.body
          if response.code != '200'
            return false
          # else
          #   return true
          end
        end
        return true
      end
    else
      return false
    end

  end

end
