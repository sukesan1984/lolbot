require 'mechanize'

summonername = ARGV[0]

agent = Mechanize.new
agent.read_timeout = 180 # [sec]
page = agent.post('http://na.op.gg/summoner/ajax/spectator/', {"userName" => summonername, "force" => true})


#p page.body
base_url = 'http://na.op.gg'

page.parser.xpath("//td[@class='SummonerName']").each_with_index do |name, i|
    print name.text.chomp
    href = name.xpath('a').attribute("href").value
    detail = agent.get(base_url + href)
    print " Tier: " + detail.parser.xpath("//div[@class='SummonerTiers']").xpath('.//span').text + "\n"
    detail.parser.xpath("//div[@class='ChampionBox Ranked']").each do |champion|
        print "\n    " + champion.xpath(".//div[@class='ChampionName']").xpath(".//span[@class='name']").text.strip.chomp
        print " " + champion.xpath(".//div[@class='ChampionPlayed']").xpath(".//span[@class='title']").text.strip.chomp
        print " " + champion.xpath(".//div[@class='ChampionPlayed']").xpath(".//span")[1].text.strip.chomp
    end
    print "\n"
    sleep(0.1)
end
