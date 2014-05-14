require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'jboss_admin::attribute', :type => :define do
  let(:pre_condition) { [ 'jboss_admin::server{"test": base_path => "/opt/jboss"}'  ] }

  let(:title) {'attribute'}
  let(:params) { {:address => 'testaddress', :attribute => 'testattribute', :value => 'testvalue', :server => 'Jboss_admin::Server[test]'} }

  it do
    should compile
    should contain_exec('attribute_SetAttribute').with(
      'command' => '/opt/jboss/bin/cli.sh --connect --commands=testaddress:write-attribute(name=testattribute,value=testvalue)',
      'unless'  => '/opt/jboss/bin/cli.sh --connect --commands=testaddress:read-attribute(name=testattribute) | grep -e "=> testvalue$" | wc -l'
    )
  end
end
