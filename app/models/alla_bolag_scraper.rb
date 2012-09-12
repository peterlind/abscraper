class AllaBolagScraper
  ENDPOINT = 'http://www.allabolag.se/?what='

  class << self
    def get_remote_result(input)
      response = http_get(input)
      parse_result(response)
    end

    def parse_result(input)
      html = Nokogiri::HTML input
      result = {}
      html.css('#hitlistName').each do |td|
        href = td.child.attr('href')
        name = td.child.attr('title')
        result[name] = parse_org_nr(href)
      end
      result
    end

    def parse_org_nr(href)
      nr = href.split('/')[-2]
      nr.insert(6, '-')
    end

    def http_get(input)
      response = RestClient.get("#{ENDPOINT}#{input}")
    end
  end
end
