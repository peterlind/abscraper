class AllaBolagScraper
  ENDPOINT = 'http://www.allabolag.se/?what='

  class << self
    def get_remote_result(input)
      response = http_get(input)
      return nil unless response
      result = parse_result(response)
      find_single_result_if_possible(result, input)
    end

    def find_single_result_if_possible(hash, input)
      found = hash.keys.find{|k| compare_normalized(k, input)}
      found ? { found => hash[found] } : hash
    end

    def compare_normalized(a,b)
      normalize(a) == normalize(b)
    end

    def normalize(string)
      string.gsub(' ','').downcase
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
      response = RestClient.get("#{ENDPOINT}#{CGI.escape(input)}")
    end
  end
end
