require 'jekyll-import'

JekyllImport::Importers::WordpressDotCom.run({
  "source" => "invisibleblocks.wordpress.2015-08-05.xml",
  "no_fetch_images" => false,
  "assets_folder" => "assets"
})

load 'fix-highlights.rb'
