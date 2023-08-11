def solution(s)
  photos = s.split("\n")

  photo_info = photos.map do |photo|
    name, location, datetime = photo.split(', ')
    { name: name, location: location, datetime: datetime }
  end

  photo_location = Hash.new do |h, k|
    h[k] = []
  end
  
  photo_info.each do |data| 
    photo_location[data[:location]] << data 
  end

  new_photos = []

  photos.each do |photo|
    name, location, datetime = photo.split(', ')
    photos_by_location = photo_location[location]
    
    photos_by_location.sort_by! do |data| 
      data[:datetime]
    end
    
    max_num_length = photos_by_location.size.to_s.length

    photo_info = photos_by_location.find do |data| 
      data[:name] == name 
    end
    
    index = photos_by_location.index(photo_info)
    num = (index + 1).to_s.rjust(max_num_length, '0')
    extension = name.split('.').last
    
    converted_photo = "#{location}#{num}.#{extension}"
    converted_photos << converted_photo
  end

  converted_photos.join("\n")
end