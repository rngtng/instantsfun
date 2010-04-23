#!/usr/bin/ruby

# require
require 'rubygems'
require 'net/github-upload'

DEBUG = true

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
  file = "instantsfun_launchpad_#{os}.zip"

  # rename
  next unless exec "mv application.#{os} instantsfun"

  if( os == :macosx )  #patch Mac Os X file to use java 1.6
      #exec "mv instantsfun/instantsfun.app/Contents/Info.plist instantsfun/instantsfun.app/Contents/Info_old.plist"
      #exec "sed 's/1\\\.5/1\\\.6/g' instantsfun/instantsfun.app/Contents/Info_old.plist > instantsfun/instantsfun.app/Contents/Info.plist"
      # copy icon
      exec "cp -f sketch.icns instantsfun/instantsfun.app/Contents/Resources/sketch.icns"
  end 
  
  exec "cp -r native/* instantsfun/instantsfun.app/Contents/Resources/Java"
    
  #zip file
  exec "zip -x .DS_Store -r #{file} instantsfun/"
      
  direct_link = DEBUG ? "debug" : gh.replace( :repos => repos, :file  => file, :description => "InstantsFun.Es Launchpad Wrapper#{human_os}")
  
  exec "rm #{file}"
  exec "rm -rf instantsfun"
  
  puts "########################  #{human_os} done, uploaded to: #{direct_link} ########################"  
end