require_relative "../lib/whatcd"

def ask(detail)
  print "#{detail}: "
  return gets.chomp
end

ENV["WHATCD_USERNAME"] ||= ask "Username"
ENV["WHATCD_PASSWORD"] ||= ask "Password"
ENV["WHATCD_COOKIE"]   ||= ask "Cookie"
