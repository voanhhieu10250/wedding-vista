require_relative "sort_obj_by_key"

def convert_obj_to_query_str(object)
  sorted_object = sort_obj_by_key(object)
  sorted_object.map do |key, value|
    value = if value.is_a?(Array)
              value.map { |val| sort_obj_by_key(val) }.to_json
            elsif value.nil?
              ""
            else
              value
            end
    "#{key}=#{value}"
  end.join("&")
end
