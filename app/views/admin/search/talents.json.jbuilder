 json.users @talents do |t|
   json.(t, :id, :name,:email,:privilege)
   if t.photo_file_name.nil?
     if t.is_at_least_medium_admin?
       url =  "/image-profile-admin.png"
     else
       url = "/image-profile-user.png"
     end
   else
     url = t.photo.url(:small)
   end
   json.url url
 end
