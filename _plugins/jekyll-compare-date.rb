require 'date'

module Jekyll
    module CompareDateFilter
      def compare_date(from, to = Date.today)
        if from.is_a?(String)
            from = Date.parse(from)
        end
        if to.is_a?(String)
            to = Date.parse(to)
        end
        (from - to).to_i
      end
    end
end

Liquid::Template.register_filter(Jekyll::CompareDateFilter)
