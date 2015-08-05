source 'https://rubygems.org'

require 'json'
require 'open-uri'
versions = JSON.parse(open('https://pages.github.com/versions.json').read)

gem 'github-pages', versions['github-pages']

gem 'hpricot'
gem 'jekyll-import', path: '/home/dan/projects/oss/jekyll-import/'
#gem 'jekyll-import', git: 'https://github.com/jekyll/jekyll-import.git', branch: 'master'
