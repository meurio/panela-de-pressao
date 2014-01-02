# coding: utf-8

def route_to_path route
  return campaigns_path                                                   if route == "the campaigns page"
  return campaign_path(@campaign)                                         if route == "this campaign page"
  return new_campaign_path                                                if route == "the new campaign page"
  return answers_campaign_path(@campaign)                                 if route == "the answers page of the campaign"
  return unmoderated_campaigns_path                                       if route == "the unmoderated campaigns page"
  return root_path                                                        if route == "the homepage"
  return '/auth/facebook/callback'                                        if route == "the Facebook callback"
  return updates_campaign_path(@campaign)                                 if route == "the updates page of the campaign"
  return edit_campaign_path(@campaign)                                    if route == "this campaign editing page"
  return new_influencer_path                                              if route == "the new influencer page"
  return influencer_path(@target.influencer)                              if route == "this target page"
  return updates_campaign_path(@campaign, anchor: "update_#{@update.id}") if route == "this update page"
  return "/meurio_accounts"                                               if route == "the Meu Rio accounts login page"
  return reported_campaigns_path                                          if route == "the reported campaigns page"
  raise "I don't know the route '#{route}'"
end

def to_xpath text
  return "//li[contains(@class, 'campaign')]"                                                                   if text == "the campaign list"
  return "//a[@href='#{campaign_moderate_path(@campaign)}']"                                                    if text == "the campaign's moderation button"
  return "//div[contains(@class, 'campaign_created_at')][.='#{I18n.l(@campaign.created_at, format: :short)}']"  if text == "the campaign's submition date"
  return "//div[contains(@class, 'campaign_user_email')][.='#{@campaign.user.email}']"                          if text == "the campaign's user email"
  return "//h3[.='#{@campaign.name}']"                                                                          if text == "the campaign's name"
  return "//div[contains(@class, 'campaign_moderator')][.='#{@campaign.reload.moderator.name}']"                if text == "the campaign's moderator name"
  raise "I don't know the xpath for '#{text}'"
end

def to_button string
  return "new_poke_phone_submit_button"     if string == "the phone poke button"
  return "new_poke_email_submit_button"     if string == "the email poke button"
  return "new_poke_facebook_submit_button"  if string == "the Facebook poke button"
  return "Aceitar campanha"                 if string == "Aceitar campanha"
  return "Adicionar alvo"                   if string == "Adicionar alvo"
  return "Enviar campanha para moderação"   if string == "Enviar campanha para moderação"
  return "Criar campanha"                   if string == "Criar campanha"
  return "Salvar campanha"                  if string == "Salvar campanha"
  return "Enviar email agora"               if string == "Enviar email agora"
  return "Criar Resposta"                   if string == "Criar Resposta"
  return "new_poke_twitter_submit_button"   if string == "the Twitter poke button"
  raise "I don't know button '#{string}'"
end

def to_element string
  return "img[src='http://sphotos-d.ak.fbcdn.net/hphotos-ak-snc7/602310_10151152362652843_505953681_n.jpg']" if string == "the poker avatar"
  return 'input[name="user[name]"]' if string == "user[name]"
  return 'input[name="user[email]"]' if string == "user[email]"
  return 'textarea[name="user[about_me]"]' if string == "user[about_me]"
  return 'input[type="submit"].facebook_poke' if string == "Pressionar pelo Facebook"
  return 'input[type="submit"].twitter_poke' if string == "Pressionar pelo Facebook"
  return "#new_campaign" if string == "the new campaign form"
  return "input.phone_with_country_code" if string == "the Plivo integration fields"
  return ".poke_notice" if string == "the thanks for poke message"
  return "form.new_phone_poke" if string == "the phone poke form"
  return "form.new_email_poke" if string == "the email poke form"
  return "form.new_twitter_poke" if string == "the Twitter poke form"
  return "first_name" if string == "the first name field"
  return "last_name" if string == "the last name field"
  return "email" if string == "the email field"
  return "phone" if string == "the phone field"
  return ".first_name-field small.error" if string == "the first name field error"
  return ".last_name-field small.error" if string == "the last name field error"
  return ".email-field small.error" if string == "the email field error"
  return ".phone-field small.error" if string == "the phone field error"
  return "aside.pressure .share" if string == "the campaign share buttons"
  return "a[href='/campaigns/reported']" if string == "the reported campaigns button"
  return ".campaign" if string == "campaigns"
  return ".empty" if string == "there is no reported campaigns"
  return ".moderator" if string == "the campaign's moderator"
end
