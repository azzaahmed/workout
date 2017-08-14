Warden::Manager.after_set_user do |user, auth, opts|
	# sets the cookie for the signed in user and makes it avaliable for find current user method in the connection file
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = user.id
end

Warden::Manager.before_logout do |user, auth, opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = nil
end