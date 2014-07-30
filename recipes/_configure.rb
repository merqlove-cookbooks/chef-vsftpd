# encoding: utf-8

# Include service definition now
include_recipe 'vsftpd::_define_service'

directory node['vsftpd']['config']['user_config_dir'] do
  action :create
  user 'root'
  group 'root'
  mode '755'
  recursive true
end

config = value_for_platform_family(
  'rhel' => '/etc/vsftpd/vsftpd.conf',
  'redhat' => '/etc/vsftpd/vsftpd.conf',
  'centos' => '/etc/vsftpd/vsftpd.conf',
  'debian' => '/etc/vsftpd.conf'
)

# rubocop:enable Style/LineLength
template config do
  source 'vsftpd.conf.erb'
  notifies :restart, 'service[vsftpd]', :delayed
end
