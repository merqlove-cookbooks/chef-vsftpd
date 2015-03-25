name              'vsftpd'
maintainer        'Sebastian Grewe'
maintainer_email  'sebastian.grewe@gmail.com'
license           'Apache 2.0'
description       'Installs/configures vsftpd'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.2.0'
recipe            'vsftpd::default', 'Installs/configures vsftpd'

depends 'iptables', '~> 0.14.1'

supports 'ubuntu'
supports 'debian'
supports 'centos'
supports 'rhel'
