require 'spec_helper'

describe Campaign do
  before do
    bitly = Bitly.new('bitly id', 'bitly key')
    bitly.stub_chain(:shorten, :short_url).and_return("http://localhost:3000/campaigns")
    Bitly.stub(:new).and_return(bitly)
    subject.stub_chain(:user, :phone, :blank?).and_return(false)
  end

  describe "associations" do
    it{ should belong_to :user }
    it{ should belong_to :category }
    it{ should have_many :pokes }
    it{ should have_many :influencers }
  end

  describe "validations" do
    before { Campaign.any_instance.stub(:user).and_return(User.make! phone: "(21) 9999-9999", email: "test@paneladepressao.org.br") }
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :description }
    it{ should validate_presence_of :user_id }
    it{ should validate_presence_of :image }
    it{ should validate_presence_of :category_id }
    it{ should validate_presence_of :poke_type }
    it{ should validate_presence_of :organization_id }
  end

  describe "Maps integration" do
    let(:campaign) { Campaign.make! }

    it "should throw an error if embed code is wrong" do
      campaign.update_attribute(:map_embed, "wrong")
      campaign.should_not be_valid
      expect(campaign.errors[:map_embed].size).to be_eql(1)
    end

    it "should not throw errors when embed code is right" do
      campaign.update_attribute(:map_embed, '<iframe width="425" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="https://www.google.com/maps?ie=UTF8&amp;hq=&amp;hnear=Laranjeiras,+Rio+de+Janeiro,+Brazil&amp;ll=-22.9333,-43.1869&amp;spn=0.0232,0.038366&amp;t=m&amp;z=15&amp;output=embed"></iframe><br /><small><a href="https://www.google.com/maps?ie=UTF8&amp;hq=&amp;hnear=Laranjeiras,+Rio+de+Janeiro,+Brazil&amp;ll=-22.9333,-43.1869&amp;spn=0.0232,0.038366&amp;t=m&amp;z=15&amp;source=embed" style="color:#0000FF;text-align:left">View Larger Map</a></small>')
      campaign.should be_valid
      campaign.should have(0).error_on(:map_embed)
    end
  end

  describe "#targets_with_facebook" do
    context "when there is no target with Facebook" do
      its(:targets_with_facebook){ should be_empty }
    end
    context "when there is one target with Facebook" do
      before { subject.stub(:targets).and_return([double('Target', :influencer => double('Influencer', :facebook_id => "14"))]) }
      its(:targets_with_facebook){ should have(1).target }
    end
  end

  describe "#targets_with_twitter" do
    context "when there is no target with Twitter" do
      its(:targets_with_twitter){ should be_empty }
    end
    context "when there is one target with Twitter" do
      before { subject.stub(:targets).and_return([Target.make!(:influencer => Influencer.make!(:twitter => "@nicolasiensen"))]) }
      its(:targets_with_twitter){ should have(1).target }
    end
  end

  describe "#description_html" do
    let(:campaign) { Campaign.make! }
    it "should populate the description_html column" do
      campaign.description_html.should_not == 'nil'
    end
  end


  describe "#has_voice_action?" do
    context "when there's a voice script and voice number" do
      let(:campaign) { Campaign.make! }

      it "should return true" do
        expect(campaign.has_voice_action?).to eq(true)
      end
    end

    context "when there is NOT a voice script and voice number" do
      let(:campaign) { Campaign.make!(voice_call_script: nil, voice_call_number: nil) }

      it "should return false" do
        expect(campaign.has_voice_action?).to eq(false)
      end
    end
  end

  describe '#moderated?' do
    context 'when the campaign has a moderator' do
      let(:campaign) { Campaign.make! }

      it 'is true' do
        expect(campaign.moderated?).to eq(true)
      end
    end

    context 'when the campaign does not have a moderator' do
      let(:unmoderated_campaign) { Campaign.make! :unmoderated }

      it 'is false' do
        expect(unmoderated_campaign.moderated?).to eq(false)
      end
    end
  end

  context "when it's poke type is set to email" do
    before { subject.poke_type = 'email' }
    it { should validate_presence_of :email_text }
  end

  context "when it's poke type is set to facebook" do
    before { subject.poke_type = 'facebook' }
    it { should validate_presence_of :facebook_text }
  end

  context "when it's poke type is set to twitter" do
    before { subject.poke_type = 'twitter' }
    it { should validate_presence_of :twitter_text }
  end
end
