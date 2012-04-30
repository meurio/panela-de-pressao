# coding: utf-8
require 'machinist/active_record'

User.blueprint do
  name { "Test User" }
  email { "foo#{sn}@bar.com" }
end

Authorization.blueprint do
  user { User.make! }
  uid  { "uid#{sn}" }
  provider { 'meurio' }
end

Campaign.blueprint do
  name { "Desarmamento Voluntário" }
  description { "O projeto desenvolve atividades destinadas a reduzir a violência armada." }
  user { User.make! }
  image { File.open(File.dirname(__FILE__) + "/../../features/support/campaign.png") }
  category { Category.make! }
end

Category.blueprint do
  name { "Categoria #{sn}" }
end

Target.blueprint do
  influencer { Influencer.make! }
  campaign { Campaign.make! }
end

Influencer.blueprint do
  name { "Eduardo Paes" }
  email { "eduardopaes@meurio.org.br" }
  twitter { "eduardopaes_" }
  facebook { "http://www.facebook.com/eduardopaesRJ" }
  role { "Prefeito" }
end
