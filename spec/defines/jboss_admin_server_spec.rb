require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'jboss_admin::server', :type => :define do
  let(:title) {'server'}
  let(:params) { {:base_path => '/opt/jboss'} }

  it { should compile }
end
