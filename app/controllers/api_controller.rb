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


  # get
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
          send_message
          render :json => {sucess: 'true' ,
                            message: 'request processed'}
      else
          render :json => {sucess: 'false' ,
                            error: 'request failed'}
      end
    else
      regcode
    end
  end

  private

  def request_params
    params.require(:request).permit(:device_id , :requested_service)
  end

  def generate_code(number)
    charset =  Array('a'..'z')
    Array.new(number) { charset.sample }.join
  end

  def get_token
    url = URI.parse(ENV['RINGCENTRAL_PATH'] + '/restapi/oauth/token')
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url.path)

    # data = 'grant_type=password&username=+12679304026&password=Purav2016~&extension=101&refresh_token_ttl=-1'
    data = {
      grant_type: 'password',
      username: ENV['RINGCENTRAL_LOGIN'],
      password: ENV['RINGCENTRAL_PASSWORD'],
      extension: '101',
      refresh_token_ttl: '-1'
      }
    request.add_field('Authorization', 'Basic ' + ENV['RINGCENTRAL_SECRET'])
    request.add_field('Content-Type','application/x-www-form-urlencoded;charset=UTF-8')

    response = http.request(request, data.to_json)
    body = JSON.parse(response.body)
    return body['access_token']

  end

  def send_message
    token = get_token
    url = URI.parse(ENV['RINGCENTRAL_PATH'] + '/restapi/v1.0/account/~/extension/~/sms')

    @user = User.find_by(device_id: params[:device_id])
    if @user
      @user.caregivers.each do |cargiver|
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Post.new(url.path)
        request.add_field('Authorization','Bearer ' + token.to_s)
        request.add_field('Content-Type', 'application/json')
        json = {"to" => [],
                "from" => {"phoneNumber" => ENV['RINGCENTRAL_LOGIN']},
                "text" => params[:message]}

        json["to"].push({ "phoneNumber" => "1" + cargiver.phone_number.to_s})
        response = http.request(request, json.to_json)
        # if response.status != 200
        #   raise "invalid request"
        # end
      end
    end


  end

end
