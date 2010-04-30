#!/usr/bin/ruby

# require
require 'rubygems'
require 'net/github-upload' #sudo gem install net-github-upload

DEBUG = $*.include?('debug')

# setup
login = `git config github.user`.chomp  # your login for github
token = `git config github.token`.chomp # your token for github
repos = 'instantsfun'                    # your repos name (like 'taberareloo')
gh = Net::GitHub::Upload.new(
  :login => login,
  :token => token
)

all_os = { :linux => "Linux", :macosx => "Mac OS X (32bit)", :windows => "Windows"}

def exec(command)
 # puts command
  system(command) unless DEBUG
end

all_os.each do |os, human_os|
  file = "#{repos}_launchpad_#{os}.zip"

  # rename
  next unless exec "mv application.#{os} #{repos}"

  #remove source
  exec "rm -rf #{repos}/source"
  
  case os
    when :macosx  #patch Mac Os X file to use java 1.6    
     exec "mv #{repos}/instantsfun.app/Contents/Info.plist #{repos}/instantsfun.app/Contents/Info_old.plist"
     exec "sed 's/1\\\.5/1\\\.6/g' #{repos}/instantsfun.app/Contents/Info_old.plist > #{repos}/instantsfun.app/Contents/Info.plist"
     # copy icon
     exec "cp -f sketch.icns #{repos}/instantsfun.app/Contents/Resources/sketch.icns"
     exec "cp -r mozswing_native/#{os}/* #{repos}/instantsfun.app/Contents/Resources/Java"
   when :linux
     exec "cp -r mozswing_native/#{os}/* instantsfun/lib"
   when :windows
     exec "cp -r mozswing_native/#{os}/* instantsfun/lib"
  end
    
  if $*.include?('upload')
    #zip file
    exec "zip -x .DS_Store -r #{file} #{repos}/"
    direct_link =  gh.replace( :repos => repos, :file  => file, :description => "InstantsFun.Es Launchpad Wrapper #{human_os}")
    exec "rm #{file}"
    exec "rm -rf #{repos}"
    puts "########################  #{human_os} done, uploaded to: #{direct_link} ########################"  
  else  
    exec "mv #{repos} #{repos}_#{os}"
    puts "########################  #{human_os} done ########################"
  end


end