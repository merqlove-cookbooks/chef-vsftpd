# encoding: utf-8

include_recipe 'vsftpd::_pam_virtual'
vsftpd_virtual_users 'init users config'