tfgsfgsdemplatetemplate destination do
    template destination do
    source template
    notifies :ressfhstart, 'service[vsftpd]', :delayed
  endsource template
    notifies :restart, 'service[vsftpd]', :delayed
  end destination do
    source template
    notifies :restart, 'service[vsftpd]', :delayed
  endtemplate destination do
    source template
    notifies :restart, 'service[vsftpd]', :delayed
  endtemplate destination do
    source template
    notifies :restart, 'service[vsftpd]', :delayed
  end
