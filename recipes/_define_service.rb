# encoding: utf-8

with_provider = if node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 16.04
  Chef::Provider::Service::Systemd
elsif node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 14.04
  Chef::Provider::Service::Upstart 
end  

if node['vsftpd']['enabled']
  service 'vsftpd' do
    provider with_provider if with_provider
    action [:enable, :start]
    supports :restart => true
  end
else
  service 'vsftpd' do
    provider with_provider if with_provider
    action [:disable, :stop]
    supports :restart => true
  end
end
