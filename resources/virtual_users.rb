#
# Cookbook Name:: vsftpd
# Resource:: virtual_users
#

actions :create

default_action :create

attribute :name, name_attribute: true, kind_of: String
attribute :cookbook, kind_of: String, default: 'vsftpd'
attribute :template, kind_of: String, default: 'virtual_users.txt.erb'

# User credentials Hash array [{'login' => 'vivek', 'password' => 'secure_password' }, ...]
attribute :users, kind_of: Array, default: node['vsftpd']['users']
