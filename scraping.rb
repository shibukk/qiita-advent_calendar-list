require 'mechanize'

class Scraping
  def initialize
    @agent = Mechanize.new
    @day = Time.now.day
  end

  def exec
    data = []
    # めんどくさいのでハードコーディング
    1.upto(24) do |i|
      page = @agent.get(url(i))
      page.search('//td[@class="adventCalendarList_calendarTitle"]/a').each do |calendar|
        detail = page.link_with(:href => calendar[:href]).click
        detail.search('.adventCalendarItem').each do |item|
          entry = get_entry(item)
          next if entry.nil?
          data << {
            title: entry.text,
            url: entry[:href]
          }
        end
      end
      sleep 30
    end
    return data
  end

  def url(num)
    "http://qiita.com/advent-calendar/2016/calendars?page=#{num}"
  end

  def get_entry(item)
    return nil if item.at('.adventCalendarItem_date').text !~ /^12 \/ #{@day}$/
    return item.at('.adventCalendarItem_entry/a')
  end
end
