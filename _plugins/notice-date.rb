# Set metadata for notices from `updated_on`
# Otherwise, jekyll-feed will think all notices are published and updated at the build time.
require 'date'

module NoticeDate
  class Generator < Jekyll::Generator
    def generate(site)
      Jekyll.logger.info "Notice Date:", "Setting metadata for notices"

      site.collections['notices'].docs.each do |n|
        if n['date'].nil?
          n.data['date'] = normalize_date n['updated_on'][0]
        end
        if n['last_modified_at'].nil?
          n.data['last_modified_at'] = normalize_date n['updated_on'][-1]
        end
      end
    end

    def normalize_date(date)
      if date.is_a? String
        return Time.new date
      elsif date.is_a? Date
        return date.to_time
      else
        return date
      end
    end
  end
end
