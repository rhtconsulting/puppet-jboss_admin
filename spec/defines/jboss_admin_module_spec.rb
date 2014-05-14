require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'jboss_admin::module', :type => :define do
  let(:pre_condition) { [ 'jboss_admin::server{"test": base_path => "/opt/jboss"}'  ] }

  let(:title) { 'new_module' }
  let(:params) { {
    :namespace => 'com.mysql', 
    :server => 'Jboss_admin::Server["test"]', 
    :jar => '/tmp/mysql.jar', 
    :jar_name => 'mysql.jar',
    :dependencies => ['javax.api', 'javax.transaction.api']
  } }

  it {should compile}

end
