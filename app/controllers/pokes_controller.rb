# coding: utf-8
class PokesController < InheritedResources::Base
  load_and_authorize_resource :only => [:create]
  belongs_to :campaign

  prepend_before_filter(:only => [:create], :if => Proc.new { request.post? }) do 
    session[:poke] = params[:poke].merge(:campaign_id => params[:campaign_id])
  end

  before_filter :only => [:create] do
    require_facebook_auth if session[:poke][:kind] == "facebook"
    require_twitter_auth if session[:poke][:kind] == "twitter"
  end

  def create
    @poke = Poke.new session.delete(:poke).merge(:user_id => current_user.id)
    create! do |success, failure|
      success.html do
        flash[:poke_create] = "<span>Boa!</span>Você acaba de colaborar com uma causa que você acredita e que pode fazer a diferença para o Rio. Agora ajude a espalhar essa ideia. Não se esqueca que você pode pressionar quantas vezes quiser!"
        redirect_to :action => "show", :controller => "campaigns", :id => @campaign.id
      end
    end
  end
end
