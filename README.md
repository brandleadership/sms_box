# SmsBox

mnc smsBox® v6.4 -- HTTP XML API client

## Installation

Add this line to your application's Gemfile:

    gem 'sms_box'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sms_box

## Usage

### Generic Usage

Load and SMSBox

    require 'sms_box'
    client = SMSBox.client 'http://pro.smsbox.ch:8047/Pro/sms/xml',
      {
        :username => 'myuser',
        :password => 'mypass'
      }

Client can be configured within a block

    client = SMSBox.client 'http://pro.smsbox.ch:8047/Pro/sms/xml' do |c|
      c.username = 'myuser'
      c.password = 'mypass'
    end

To send a request, a Request object needs to be instantiated and passed
to `client.request`

    request = SMSBox::WebsendRequest.new.tap do |r|
      r.service = 'TEST'
      r.text = 'This is a test message.'
      r.receivers = [
        '+41790000001',
        '+41790000002',
        '+41790000003',
      ]
    end
    res = client.request request

The bang method `request!` can be used to automatically raise an
`SMSBox::RequestException` when request failed.

    res = client.request! request # raises SMSBox::RequestException when response.error? == true

The status of the request can be checked on the response object

    res.success?
    # or
    res.error?
    # The error type is stored as string in res.error

### Implemented Requests

* WEBSEND (with multiReceiver)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
