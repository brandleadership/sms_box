require 'spec_helper'

module SMSBox
  describe Client do
    describe '#factory' do

      context 'when block given' do
        it 'can be configured with a block' do
          client = SMSBox.client 'url' do |c|
            c.username = 'username'
          end
          client.username.should == 'username'
        end
      end

      context 'when options given' do
        it 'can be configured with a hash' do
          client = SMSBox.client 'url', { username: 'username' }
          client.username.should == 'username'
        end
      end

    end

    describe '#request'
  end
end
