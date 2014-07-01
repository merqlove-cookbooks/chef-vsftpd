# encoding: utf-8

node.default['vsftpd']['config']['pam_service_name'] = 'vsftpd_virtual'

template "#{ node['vsftpd']['pamdir'] }/vsftpd_virtual" do
  source 'vsftpd_virtual.erb'
  notifies :restart, 'service[vsftpd]', :delayed
end
