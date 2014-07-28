#
# Cookbook Name:: chef-vsftpd
# Provider:: virtual_users
#

action :create do
  name = new_resource.name

  Dir.mktmpdir do |dir|
    txt = "#{dir}/#{node['vsftpd']['db4_file']}.txt"
    db = "#{ node['vsftpd']['etc_dir'] }/#{ node['vsftpd']['db4_file'] }.#{ node['vsftpd']['db4_file_ext'] }"
    generator = "db_load -T -t hash -f #{txt} #{db} && chmod 0600 #{db}"

    generate_db = execute "generate-vsftpd-berkley-db-#{name}" do
      action :nothing
      command generator
      notifies :restart, 'service[vsftpd]', :delayed
    end

    template txt do
      source 'virtual_users.txt.erb'
      variables users: new_resource.users

      action :create
      notifies :run, generate_db, :delayed
    end

    new_resource.updated_by_last_action(true)
  end
end
