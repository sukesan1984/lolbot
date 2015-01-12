require 'mechanize'

summonername = ARGV[0]

agent = Mechanize.new
agent.read_timeout = 180 # [sec]
detail = agent.get('http://na.op.gg/summoner/userName=' + summonername)
print " Tier: " + detail.parser.xpath("//div[@class='SummonerTiers']").xpath('.//span').text + "\n"
detail.parser.xpath("//div[@class='ChampionBox Ranked']").each do |champion|
    print "\n    " + champion.xpath(".//div[@class='ChampionName']").xpath(".//span[@class='name']").text.strip.chomp
    print " " + champion.xpath(".//div[@class='ChampionPlayed']").xpath(".//span[@class='title']").text.strip.chomp
    print " " + champion.xpath(".//div[@class='ChampionPlayed']").xpath(".//span")[1].text.strip.chomp
end
print "\n"
