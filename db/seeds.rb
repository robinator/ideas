['admin', 'user'].each do |u| 
  user = User.create(:login => u, :email => "#{u}@varietyour.com", :password => "#{u}123", :password_confirmation => "#{u}123")
  if user.id
    puts "User '#{u}' created"
  else
    puts user.errors.full_messages
  end
end