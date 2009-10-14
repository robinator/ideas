xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{@user.login}'s Ideas"
    xml.description "#{@user.login}'s public ideas on idealogue"

    @ideas.each do |idea|
      xml.item do
        xml.title idea.name
        xml.description idea.body
        xml.pubDate idea.created_at.to_s(:rfc822)
        xml.link idea_url(idea)
      end
    end
  end
end