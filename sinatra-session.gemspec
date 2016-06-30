Gem::Specification.new do |s|
  s.name = 'sinatra-session'
  s.version = '1.1.0'
  s.date = Time.now.strftime('%Y-%m-%d')

  s.summary = 'Simple, secure sessions for Sinatra'
  s.description = 'Simple, secure HTTP cookie-based sessions for Sinatra'

  s.author = 'Michael Jackson'
  s.email = 'mjijackson@gmail.com'

  s.require_paths = %w< lib >

  s.files = Dir['lib/**/*.rb'] +
    %w< sinatra-session.gemspec Rakefile README.md >

  s.add_dependency('sinatra', '>= 1.0')
  s.add_dependency('encrypted_cookie', '>= 0.0.4')
  s.add_development_dependency('rake')

  s.rdoc_options = %w< --line-numbers --inline-source --title Sinatra::Session --main Sinatra::Session >
  s.extra_rdoc_files = %w< README.md >

  s.homepage = 'http://mjijackson.github.com/sinatra-session'
end
