dir = File.dirname(__FILE__)

cookbook_path  [ File.join(dir, 'cookbooks'),
                 File.join(dir, 'site-cookbooks') ]
file_backup_path File.join(dir, 'backup')
file_cache_path  File.join(dir, 'cache')
json_attribs     File.join(dir, 'solo.json')
