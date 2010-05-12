Gem::Specification.new do |s|
  s.name = 'sinatra-session'
  s.version = '1.0.0'
  s.date = '2010-05-12'

  s.summary = 'Simple, secure sessions for Sinatra'
  s.description = 'Simple, secure sessions for Sinatra'

  s.author = 'Michael Jackson'
  s.email = 'mjijackson@gmail.com'

  s.require_paths = %w< lib >

  s.files = Dir['lib/**/*.rb'] +
    %w< sinatra-session.gemspec Rakefile README >

  s.add_dependency('sinatra', '>= 1.0')
  s.add_development_dependency('rake')

  s.has_rdoc = true
  s.rdoc_options = %w< --line-numbers --inline-source --title Sinatra::Session --main Sinatra::Session >
  s.extra_rdoc_files = %w< README >

  s.homepage = 'http://mjijackson.com/sinatra-session'
end
