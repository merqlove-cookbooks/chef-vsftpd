#
# Cookbook Name:: chef-vsftpd
# Resource:: virtual_users
#

actions :create

default_action :create

attribute :name, :name_attribute => true, :kind_of => String
attribute :users, :kind_of => [Array, NilClass], :default => nil, :required => true # User credentials Hash array [{'login' => 'vivek', 'password' => 'secure_password' }, ...]

def initialize(*args)
  super
  @action = :create
end
