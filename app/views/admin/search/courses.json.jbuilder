 json.courses @courses do |c|
   json.(c, :id, :name, :description,:cover_file_name)
 end
