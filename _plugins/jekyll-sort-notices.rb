module Jekyll
    module SortNoticesFilter
      def sort_notices(notices)
        notices.sort_by {
            |n| n["updated_on"][-1]
        }
      end
    end
end

Liquid::Template.register_filter(Jekyll::SortNoticesFilter)
