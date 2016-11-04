require 'spec_helper'

describe 'openvpn::define', type: :define do
  ['Debian'].each do |osfamily|
    let(:facts) do
      {
        osfamily: osfamily,
        ipaddress_primary: '10.0.2.15'
      }
    end
    let(:pre_condition) { 'include openvpn' }
    let(:title) { 'openvpn.conf' }

    context "on #{osfamily}" do
      context 'when source file' do
        let(:params) do
          {
            config_file_path: '/etc/openvpn/openvpn.2nd.conf',
            config_file_source: 'puppet:///modules/openvpn/common/etc/openvpn/openvpn.conf'
          }
        end

        it do
          is_expected.to contain_file('define_openvpn.conf').with(
            'ensure'  => 'present',
            'source'  => 'puppet:///modules/openvpn/common/etc/openvpn/openvpn.conf',
            'notify'  => 'Service[openvpn]',
            'require' => 'Package[openvpn]'
          )
        end
      end

      context 'when content string' do
        let(:params) do
          {
            config_file_path: '/etc/openvpn/openvpn.3rd.conf',
            config_file_string: '# THIS FILE IS MANAGED BY PUPPET'
          }
        end

        it do
          is_expected.to contain_file('define_openvpn.conf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'notify'  => 'Service[openvpn]',
            'require' => 'Package[openvpn]'
          )
        end
      end

      context 'when content template' do
        let(:params) do
          {
            config_file_path: '/etc/openvpn/openvpn.4th.conf',
            config_file_template: 'openvpn/common/etc/openvpn/openvpn.conf.erb'
          }
        end

        it do
          is_expected.to contain_file('define_openvpn.conf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'notify'  => 'Service[openvpn]',
            'require' => 'Package[openvpn]'
          )
        end
      end

      context 'when content template (custom)' do
        let(:params) do
          {
            config_file_path: '/etc/openvpn/openvpn.5th.conf',
            config_file_template: 'openvpn/common/etc/openvpn/openvpn.conf.erb',
            config_file_options_hash: {
              'key' => 'value'
            }
          }
        end

        it do
          is_expected.to contain_file('define_openvpn.conf').with(
            'ensure'  => 'present',
            'content' => %r{THIS FILE IS MANAGED BY PUPPET},
            'notify'  => 'Service[openvpn]',
            'require' => 'Package[openvpn]'
          )
        end
      end
    end
  end
end
