# encoding: utf-8

iptables_rule 'port_vsftpd' do
  not_if { ::File.directory?("/etc/iptables.d") }
end
