require 'addressable/uri'
require 'rest-client'
def create_user

  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.html'
  ).to_s

  puts RestClient.post(
    url,
    { user: {name: "Gizmo", email: "gizmo@gizmo.gizmo" } }
  )
end

def show_user(id)

  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}"
  ).to_s

  puts RestClient.get(url)
end

def update_user(id, options = {})
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: "/users/#{id}"
  ).to_s

  puts RestClient.put(url, {user: {:name => "gizmo"}})
end

def delete_user(id)
  url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: "/users/#{id}"
  ).to_s

  puts RestClient.delete(url)
end
