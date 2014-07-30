#
# Cookbook Name:: vsftpd
# Resource:: lists
#

actions :create

default_action :create

attribute :name, name_attribute: true, kind_of: String
attribute :cookbook, kind_of: String, default: 'vsftpd'
