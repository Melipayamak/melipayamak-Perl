use strict;
use warnings;

use LWP::UserAgent;
use HTTP::Request;
use CGI;

BEGIN {  # BEGIN means this will all happen at compile time
    package Constants;

    $INC{'Constants.pm'}++;     # tell `require` that the package is loaded
    use base 'Exporter';        # setup package to export
    our @EXPORT_OK = qw( _sendURL _receiveURL _contactsURL _actionsURL _scheduleURL _ticketsURL _usersURL );  # what to export

    use constant _sendURL => 'https://api.payamak-panel.com/post/send.asmx';
    use constant _receiveURL => 'https://api.payamak-panel.com/post/receive.asmx';
    use constant _contactsURL => 'https://api.payamak-panel.com/post/contacts.asmx';
    use constant _actionsURL => 'https://api.payamak-panel.com/post/actions.asmx';
    use constant _scheduleURL => 'https://api.payamak-panel.com/post/schedule.asmx';
    use constant _ticketsURL => 'https://api.payamak-panel.com/post/tickets.asmx';
    use constant _usersURL => 'https://api.payamak-panel.com/post/users.asmx';
}


package SoapClient;

use Constants qw( _sendURL _receiveURL _contactsURL _actionsURL _scheduleURL _ticketsURL _usersURL );  # use it like normal

sub new {
    my $class = shift;
    my $self = {
        _username => shift,
        _password  => shift,
    };
    # Print all the values just for clarification.
    # print "First Name is $self->{_firstName}\n";
    # print "Last Name is $self->{_lastName}\n";
    # print "SSN is $self->{_ssn}\n";
    bless $self, $class;
    return $self;
}

sub SendSimpleSMS2 {

	my( $self, $to, $from, $text, $flash ) = @_;
	my $method = 'SendSimpleSMS2';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><to>$to</to><from>$from</from><text>$text</text><isflash>$flash</isflash></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	# $request->header(SOAPAction => '');
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);

	print $response->as_string;
}
sub SendSimpleSMS {

	my( $self, @to, $from, $msg, $flash ) = @_;
	my $_to = "<string>" . join("</string><string>", @to) . "</string>";
	my $method = 'SendSimpleSMS';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><to>$_to</to><from>$from</from><text>$msg</text><isflash>$flash</isflash></$method ></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub SendSms {

	my( $self, $to, $from, $msg, $flash, $udh, @recid ) = @_;
	my $_to = "<string>" . join("</string><string>", @to) . "</string>";
    my $_recid = "<long>" . join("</long><long>", @recid) . "</long>";
	my $method = 'SendSms';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><to>$_to</to><from>$from</from><text>$msg</text><isflash>$flash</isflash><udh>$udh</udh><recId>$_recid</recId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub SendWithDomain {

	my( $self, $to, $from, $msg, $flash, $domain ) = @_;
	my $method = 'SendWithDomain';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><to>$to</to><from>$from</from><text>$msg</text><isflash>$flash</isflash><domainName>$domain</domainName></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub getMessages {

	my( $self, $location, $from, $index, $count ) = @_;
	my $method = 'getMessages';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><location>$location</location><from>$from</from><index>$index</index><count>$count</count></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetSmsPrice {

	my( $self, $irancellCount, $mtnCount, $from, $text ) = @_;
	my $method = 'GetSmsPrice';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><irancellCount>$irancellCount</irancellCount><mtnCount>$mtnCount<mtnCount><from>$from</from><text>$text</text></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
