#
# Cookbook Name:: vsftpd
# Provider:: virtual_users
#

require 'digest'

action :create do
  name = new_resource.name

  txt = "#{::Chef::Config[:file_cache_path]}/#{node['vsftpd']['db4_file']}.txt"
  db = "#{node['vsftpd']['etcdir']}/#{node['vsftpd']['db4_file']}.#{node['vsftpd']['db4_file_ext']}"
  generator = "db_load -T -t hash -f #{txt} #{db} && chmod 0600 #{db} && rm -f #{txt}"

  generate_db = execute "generate-vsftpd-berkley-db-#{name}" do
    action :nothing
    command generator
    notifies :restart, 'service[vsftpd]', :delayed
  end

  old_sum = ::File.read("#{txt}_sum") if ::File.exist?("#{txt}_sum")
  new_sum = ::Digest::SHA256.hexdigest new_resource.users.to_s

  template txt do
    cookbook new_resource.cookbook
    source new_resource.template
    mode 00600
    variables users: new_resource.users
    action :nothing
    notifies :run, generate_db, :delayed
  end

  file "#{txt}_sum" do
    mode 00600
    content new_sum
    action :create
    only_if { old_sum != new_sum }
    notifies :create, "template[#{txt}]"
  end



  create_config(new_resource.users, new_resource.cookbook)
  vsftpd_lists 'custom init'

  new_resource.updated_by_last_action(true)
end

def create_config(users, cookbook)
  return unless users

  names=[]
  users.each do |user|
    names.push user['name']
    template "#{node['vsftpd']['config']['user_config_dir']}/#{user['name']}" do
      cookbook cookbook
      source 'virtual_user_config.erb'
      variables config: user['config']
      notifies :restart, 'service[vsftpd]', :delayed
    end
    node.default['vsftpd']['allowed'].push(user['name'])
  end

  clean_config(names)
end

def clean_config(names)
  return unless names

  if ::Dir.exist? "#{node['vsftpd']['config']['user_config_dir']}"
    ::Dir.foreach("#{node['vsftpd']['config']['user_config_dir']}") do |user|
      next if user == '.' or user == '..'
      unless names.include? user
        ::File.delete("#{node['vsftpd']['config']['user_config_dir']}/#{user}")
      end
    end
  end
end
