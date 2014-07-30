#
# Cookbook Name:: vsftpd
# Provider:: lists
#

action :create do
  # rubocop:disable Style/LineLength
  { 'vsftpd.chroot_list.erb' => node['vsftpd']['config']['chroot_list_file'],
    'vsftpd.user_list.erb' => node['vsftpd']['config']['userlist_file'] }.each do |template, destination|
    # rubocop:enable Style/LineLength
    template "#{new_resource.name} #{destination}" do
      path destination
      cookbook new_resource.cookbook
      source template
      notifies :restart, 'service[vsftpd]', :delayed
    end
  end

  new_resource.updated_by_last_action(true)
end