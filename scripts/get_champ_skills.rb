require 'mechanize'
require 'IMGKit'

championname = ARGV[0]

agent = Mechanize.new
agent.read_timeout = 180 #[sec]
detail = agent.get('http://loljp-wiki.tk/wiki/?%A5%C7%A1%BC%A5%BF%A5%D9%A1%BC%A5%B9%2F%A5%C1%A5%E3%A5%F3%A5%D4%A5%AA%A5%F3')
html_style_sheet = detail.parser.xpath("//link[@rel='stylesheet']")

html_body = detail.parser.xpath("//a[@id='#{championname}']").xpath("../..")
html_body_image = html_body.xpath(".//img")
html_body_image[0]["src"] = "http://loljp-wiki.tk/wiki/" + html_body_image[0]["src"]

File.open('hoge.html', 'w') {|file|
  file.write '<?xml version="1.0" encoding="EUC-JP" ?>'
  file.write '<head>'
  html_style_sheet.each do |style_sheet|
    style_sheet["href"] = 'http://loljp-wiki.tk/wiki/' + style_sheet["href"]
    file.write style_sheet
  end
  file.write '</head>'
  file.write "<div class='champion_summary_list'>"
  file.write html_body.to_html()
  file.write "</div>"
}

kit = IMGKit.new(File.new('hoge.html'))
kit.to_file('/tmp/screen_shot.png')

