#
# Cookbook Name:: chef-vsftpd
# Resource:: virtual_users
#

actions :create

default_action :create

attribute :name, name_attribute: true, kind_of: String

# User credentials Hash array [{'login' => 'vivek', 'password' => 'secure_password' }, ...]
attribute :users, kind_of: Array, default: nil, required: true
