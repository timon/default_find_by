require File.join(File.dirname(__FILE__), 'lib', 'default_find_by')
ActiveRecord::Base.send(:extend, DefaultFindBy)

