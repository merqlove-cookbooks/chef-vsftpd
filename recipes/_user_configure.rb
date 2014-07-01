# encoding: utf-8

node['vsftpd']['users'].each do |user|
  template "#{ node['vsftpd']['config']['user_config_dir'] }/#{ user['name'] }" do
    source 'user.erb'
    variables(
      :config => user['config']
    )
    notifies :restart, 'service[vsftpd]', :delayed
  end
end
