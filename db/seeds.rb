['admin', 'user'].each do |u| 
  user = User.create(:login => u, :email => "#{u}@varietyour.com", :password => "#{u}#{u}#{u}", :password_confirmation => "#{u}#{u}#{u}")
  if user.id
    puts "User '#{u}' created"
  else
    puts user.errors.full_messages
  end
end

