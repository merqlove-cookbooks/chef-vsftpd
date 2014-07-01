#
# Cookbook Name:: chef-vsftpd
# Resource:: virtual_users
#

actions :create

default_action :create

attribute :name, :name_attribute => true, :kind_of => String
attribute :password, :kind_of => [String, NilClass], :default => nil, :required => true # Password

def initialize(*args)
  super
  @action = :create
end
