package 'unzip'
package 'vim'

cookbook_file '/home/vagrant/rinxter.zip' do
  backup false
  action :create_if_missing
  user 'vagrant'
  group 'vagrant'
end

script 'Setup Rinxter' do
  interpreter 'bash'
  user 'vagrant'
  cwd '/home/vagrant'
  code <<-EOH
    unzip -qq /home/vagrant/rinxter.zip
    mysql --user=root --password="rinxter" < /home/vagrant/rinxter/dscore.sql
  EOH
  not_if "test -d /home/vagrant/rinxter"
end

include_recipe "java"

execute 'Install tomcat' do
  command 'sudo aptitude install -q -y tomcat5.5 tomcat5.5-admin'
  not_if "test -d /etc/tomcat5.5"
end

template '/etc/init.d/rinxter' do
  source 'rinxter.erb'
  owner 'root'
  group 'root'
  mode '755'
end

service "rinxter" do
  service_name "rinxter"
  supports :restart => true, :restart => true
  action [:enable, :start]
end
