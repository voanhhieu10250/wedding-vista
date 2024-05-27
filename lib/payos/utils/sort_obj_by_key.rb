def sort_obj_by_key(obj)
  if obj.is_a?(Hash)
    obj.sort_by { |k, _v| k }.to_h
  else
    obj.to_unsafe_h.sort_by { |k, _v| k }.to_h
  end
end
