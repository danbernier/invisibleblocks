require 'yaml'

def rename_html_to_md
  files = Dir.glob('_posts/*.html') + Dir.glob('_drafts/*.html')
  files.each do |file|
    new_file_name = file.sub(/\.html$/, '.md')
    cmd = "mv \"#{file}\" \"#{new_file_name}\" "
    #puts cmd
    `#{cmd}`
  end
end

def fix_files!
  files = Dir.glob('_posts/*.md') + Dir.glob('_drafts/*.md')
  files.each do |file|
    #print "#{file}..."
    src = File.read(file)

    if src =~ /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m
      content = $POSTMATCH
      data = begin
               YAML.load($1)
             rescue
               puts "Whoops! Can't load the frontmatter from #{file}, deleting it..."
               {}
             end

      data, content = *yield(data, content)

      new_src = %Q{#{data.to_yaml}---

#{content}}.strip

      if new_src != src
        #print "Changed!"
        File.open(file, 'w') do |f|
          f.puts new_src
        end
      end
    else
      raise "Y U NO have frontmatter, #{file}?"
    end

    #puts
  end

  #puts `git diff`
  #`git co -- _posts/*.md` unless save_files
end

def fix_content!
  fix_files! do |data, content|
    new_content = yield(content)
    [data, new_content]
  end
end

def fix_yaml!
  fix_files! do |data, content|
    yield(data)
    [data, content]
  end
end


# Full process:
rename_html_to_md

fix_content! { |src| src.gsub("<br />", "") }
fix_content! { |src| src.gsub("<p>", "\n").gsub("</p>", "") }
fix_content! { |src| src.gsub("&quot;", '"') }


# first some clean-up
fix_content! do |src|
  src.
    gsub('[sourcecode lang=', '[sourcecode language=').
    gsub(/\[sourcecode language='(.*?)'\]/, '[sourcecode language="\1"]').
    gsub('[sourcecode language="jscript"]', '[sourcecode language="js"]').
    gsub('[sourcecode language="javascript"]', '[sourcecode language="js"]').
    gsub('[sourcecode language="c#"]', '[sourcecode language="csharp"]')
end

fix_content! do |src|
  src.
    gsub(/\[sourcecode language="(.*?)"\]/, '{% highlight \1 linenos %}').
    gsub('[/sourcecode]', '{% endhighlight %}')
end

fix_content! { |src| src.gsub(' </a>', '</a> ') }
fix_content! { |src| src.gsub(' target="_blank"', '') }  # Just remove them, whatev.
fix_content! { |src|
  src.gsub(%r(<a href="(.*?)">(.*?)</a>), '[\2](\1)')
}

fix_content! { |src| src.gsub("<code>", "`").gsub("</code>", "`") }
fix_content! { |src|
  src.gsub("<i>", "_").gsub("</i>", "_")
    .gsub("<em>", "_").gsub("</em>", "_")
    .gsub("<b>", "**").gsub("</b>", "**")
    .gsub("<strong>", "**").gsub("</strong>", "**")
}
fix_content! { |src| src.gsub("&gt;", '>').gsub("&lt;", '<').gsub("&amp;", '&') }
fix_content! { |src|
  src.
    gsub(/[“”]/, '"').
    gsub(/[‘’]/, "'").
    gsub('&#8217;', "'").
    gsub('&#8221;', '"')
}

fix_content! { |src|
  src.gsub(%r(^<h1>(.*?)</h1>)) { "\n# #{$1}\n" }.
    gsub(%r(^<h2>(.*?)</h2>)) { "\n## #{$1}\n" }.
    gsub(%r(^<h3>(.*?)</h3>)) { "\n### #{$1}\n" }.
    gsub(%r(^<h4>(.*?)</h4>)) { "\n#### #{$1}\n" }.
    gsub(%r(^<h5>(.*?)</h5>)) { "\n##### #{$1}\n" }.
    gsub(%r(^<h6>(.*?)</h6>)) { "\n###### #{$1}\n" }
}

#fix_content! { |src| src.gsub(/<li>(.*?)<\/li>/, '* \1').gsub('<ul>', "").gsub('</ul>', "\n") }

# files = `git grep -l "<img" _posts`.strip.split("\n").map(&:strip)
# p files


fix_yaml! { |data|
  data['author'] = 'Dan Bernier'
  data.delete('meta')
}
