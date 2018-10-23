class SessionsController < ApplicationController
  def create
    @manager = Manager.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
    end
    @client = Client.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
    end
  end

  def destroy
    session.delete :manager_id && session.delete :client_id
    redirect_to '/'
  end

private

  def auth
    request.env['omniauth.auth']
  end
end
