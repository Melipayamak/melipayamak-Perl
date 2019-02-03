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

	my( $self, @to, $from, $msg, $flash, $udh, @recid ) = @_;
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
sub SendByBaseNumber {

	my( $self, @text, $to, $bodyId ) = @_;
	my $_text = "<string>" . join("</string><string>", @text) . "</string>";
	my $method = 'SendByBaseNumber';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><text>$_text</text><to>$to</to><bodyId>$bodyId</bodyId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub SendByBaseNumber2 {

	my( $self, @text, $to, $bodyId ) = @_;
	my $method = 'SendByBaseNumber2';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><text>$text</text><to>$to</to><bodyId>$bodyId</bodyId></$method></soap:Body></soap:Envelope>";

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
sub GetMultiDelivery {

	my( $self, $recId ) = @_;
	my $method = 'GetMultiDelivery2';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><recId>$recId</recId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetInboxCount {

	my( $self, $isRead ) = @_;
	my $method = 'GetInboxCount';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><isRead>$isRead</isRead></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetDelivery {

	my( $self, $to, $recId ) = @_;
	my $method = 'GetDelivery';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><recId>$recId</recId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}    
sub GetDeliveries3 {

	my( $self, @recIds ) = @_;
	my $_recids = "<string>" . join("</string><string>", @recIds) . "</string>";
	my $method = 'GetDeliveries3';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><recId>$_recids</recId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}    
sub GetDeliveries2 {

	my( $self, $recId ) = @_;
	my $method = 'GetDeliveries2';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><recId>$recId</recId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub GetDeliveries {

	my( $self, @recIds ) = @_;
	my $method = 'GetDeliveries';
	my $_recids = "<long>" . join("</long><long>", @recIds) . "</long>";
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><recId>$_recids</recId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub GetCredit {

	my( $self ) = @_;
	my $method = 'GetCredit';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _sendURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}


# Receive API Operations
# use Received or Sent or Removed or Deleted for location in the next method
sub RemoveMessages {

	my( $self, $location, $msgIds ) = @_;
	my $method = 'RemoveMessages';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><location>$location</location><msgIds>$msgIds</msgIds></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub GetUsersMessagesByDate {

	my( $self, $location, $from, $index, $count, $dateFrom, $dateTo ) = @_;
	my $method = 'GetUsersMessagesByDate';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><location>$location</location><from>$from</from><index>$index</index><count>$count</count><dateFrom>$dateFrom</dateFrom><dateTo>$dateTo</dateTo></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetOutBoxCount {

	my( $self ) = @_;
	my $method = 'GetOutBoxCount';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetMessagesWithChangeIsRead {

	my( $self, $location, $from, $index, $count, $isRead, $changeIsRead ) = @_;
	my $method = 'GetMessagesWithChangeIsRead';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><location>$location</location><from>$from</from><index>$index</index><count>$count</count><isRead>$isRead</isRead><changeIsRead>$changeIsRead</changeIsRead></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
} 
sub GetMessagesReceptions {

	my( $self, $msgId, $fromRows ) = @_;
	my $method = 'GetMessagesReceptions';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><msgId>$msgId</msgId><fromRows>$fromRows</fromRows></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub GetMessagesFilterByDate {

	my( $self, $location, $from, $index, $count, $dateFrom, $dateTo, $isRead ) = @_;
	my $method = 'GetMessagesFilterByDate';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><location>$location</location><from>$from</from><index>$index</index><count>$count</count><dateFrom>$dateFrom</dateFrom><dateTo>$dateTo</dateTo><isRead>$isRead</isRead></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub GetMessagesByDate {

	my( $self, $location, $from, $index, $count, $dateFrom, $dateTo ) = @_;
	my $method = 'GetMessagesByDate';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><location>$location</location><from>$from</from><index>$index</index><count>$count</count><dateFrom>$dateFrom</dateFrom><dateTo>$dateTo</dateTo></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub GetMessagesAfterIDJson {

	my( $self, $location, $from, $count, $msgId ) = @_;
	my $method = 'GetMessagesAfterIDJson';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><location>$location</location><from>$from</from><count>$count</count><msgId>$msgId</msgId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
} 
sub GetMessagesAfterID {

	my( $self, $location, $from, $count, $msgId ) = @_;
	my $method = 'GetMessagesAfterID';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><location>$location</location><from>$from</from><count>$count</count><msgId>$msgId</msgId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}    
sub GetMessages {

	my( $self, $location, $from, $index, $count ) = @_;
	my $method = 'GetMessages';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><location>$location</location><from>$from</from><index>$index</index><count>$count</count></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
} 
sub ChangeMessageIsRead {

	my( $self, $msgIds ) = @_;
	my $method = 'ChangeMessageIsRead';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><msgIds>$msgIds</msgIds></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _receiveURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}    
# Users API Operations
sub AddPayment {

	my( $self, $name, $family, $bankName, $ code, $amount, $cardNumber ) = @_;
	my $method = 'AddPayment';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><name>$name</name><family>$family</family><bankName>$bankName</bankName><code>$code</code><amount>$amount</amount><cardNumber>$cardNumber</cardNumber></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddUser {

	my( $self, $productId, $descriptions, $mobileNumber, $emailAddress, $nationalCode, $name, $family, $corporation, $ phone, $fax, $address, $postalCode, $certificateNumber ) = @_;
	my $method = 'AddUser';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><productId>$productId</productId><descriptions>$descriptions</descriptions><mobileNumber>$mobileNumber</mobileNumber><emailAddress>$emailAddress</emailAddress><nationalCode>$nationalCode</nationalCode><name>$name</name><family>$family</family><corporation>$corporation</corporation><phone>$phone</phone><fax>$fax</fax><address>$address</address><postalCode>$postalCode</postalCode><certificateNumber>$certificateNumber</certificateNumber></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddUserComplete {

	my( $self, $productId, $descriptions, $mobileNumber, $emailAddress, $nationalCode, $name, $family, $corporation, $ phone, $fax, $address, $postalCode, $certificateNumber, $country, $province, $city, $howFindUs, $commercialCode, $saleId, $recommanderId ) = @_;
	my $method = 'AddUserComplete';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><productId>$productId</productId><descriptions>$descriptions</descriptions><mobileNumber>$mobileNumber</mobileNumber><emailAddress>$emailAddress</emailAddress><nationalCode>$nationalCode</nationalCode><name>$name</name><family>$family</family><corporation>$corporation</corporation><phone>$phone</phone><fax>$fax</fax><address>$address</address><postalCode>$postalCode</postalCode><certificateNumber>$certificateNumber</certificateNumber><country>$country</country><province>$province</province><city>$city</city><howFindUs>$howFindUs</howFindUs><commercialCode>$commercialCode</commercialCode><saleId>$saleId</saleId><recommanderId>$recommanderId</recommanderId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddUserWithLocation {

	my( $self, $productId, $descriptions, $mobileNumber, $emailAddress, $nationalCode, $name, $family, $corporation, $ phone, $fax, $address, $postalCode, $certificateNumber, $country, $province, $city ) = @_;
	my $method = 'AddUserWithLocation';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><productId>$productId</productId><descriptions>$descriptions</descriptions><mobileNumber>$mobileNumber</mobileNumber><emailAddress>$emailAddress</emailAddress><nationalCode>$nationalCode</nationalCode><name>$name</name><family>$family</family><corporation>$corporation</corporation><phone>$phone</phone><fax>$fax</fax><address>$address</address><postalCode>$postalCode</postalCode><certificateNumber>$certificateNumber</certificateNumber><country>$country</country><province>$province</province><city>$city</city></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddUserWithMobileNumber {

	my( $self, $productId, $mobileNumber, $firstName, $lastName, $email ) = @_;
	my $method = 'AddUserWithMobileNumber';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><productId>$productId</productId><mobileNumber>$mobileNumber</mobileNumber><firstName>$firstName</firstName><lastName>$lastName</lastName><email>$email</email></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddUserWithUserNameAndPass {

	my( $self, $targetUserName, $targetUserPassword, $productId, $descriptions, $mobileNumber, $emailAddress, $nationalCode, $name, $family, $corporation, $phone, $fax, $address, $postalCode, $certificateNumber ) = @_;
	my $method = 'AddUserWithUserNameAndPass';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><targetUserName>$targetUserName$</targetUserName><targetUserPassword>$targetUserPassword</targetUserPassword><productId>$productId</productId><descriptions>$descriptions</descriptions><mobileNumber>$mobileNumber</mobileNumber><emailAddress>$emailAddress</emailAddress><nationalCode>$nationalCode</nationalCode><name>$name</name><family>$family</family><corporation>$corporation</corporation><phone>$phone</phone><fax>$fax</fax><address>$address</address><postalCode>$postalCode</postalCode><certificateNumber>$certificateNumber</certificateNumber></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub AuthenticateUser {

	my( $self ) = @_;
	my $method = 'AuthenticateUser';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub ChangeUserCredit {

	my( $self, $amount, $description, $targetUsername, $GetTax ) = @_;
	my $method = 'ChangeUserCredit';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><amount>$amount</amount><description>$description</description><targetUsername>$targetUsername</targetUsername><GetTax>$GetTax</GetTax></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}    
sub ChangeUserCreditBySeccondPass {

	my( $self, $ausername, $seccondPassword, $amount, $description, $targetUsername, $GetTax ) = @_;
	my $method = 'ChangeUserCreditBySeccondPass';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$ausername</username><seccondPassword>$seccondPassword</seccondPassword><amount>$amount</amount><description>$description</description><targetUsername>$targetUsername</targetUsername><GetTax>$GetTax</GetTax></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}    
sub DeductUserCredit {

	my( $self, $ausername, $apassword, $amount, $description ) = @_;
	my $method = 'DeductUserCredit';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$ausername</username><password>$apassword</password><amount>$amount</amount><description>$description</description></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub ForgotPassword {

	my( $self, $mobileNumber, $emailAddress, $targetUsername ) = @_;
	my $method = 'ForgotPassword';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><mobileNumber>$mobileNumber</mobileNumber><emailAddress>$emailAddress</emailAddress><targetUsername>$targetUsername</targetUsername></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub GetCities {

	my( $self, $provinceId ) = @_;
	my $method = 'GetCities';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><provinceId>$provinceId</provinceId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetEnExpireDate {

	my( $self ) = @_;
	my $method = 'GetEnExpireDate';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetExpireDate {

	my( $self ) = @_;
	my $method = 'GetExpireDate';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetProvinces {

	my( $self ) = @_;
	my $method = 'GetProvinces';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetUserBasePrice {

	my( $self, $targetUsername ) = @_;
	my $method = 'GetUserBasePrice';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><targetUsername>$targetUsername</targetUsername></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetUserByUserID {

	my( $self, $pass, $userId ) = @_;
	my $method = 'GetUserByUserID';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><pass>$pass</pass><userId>$userId</userId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub GetUserCredit {

	my( $self, $targetUsername ) = @_;
	my $method = 'GetUserCredit';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><targetUsername>$targetUsername</targetUsername></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetUserCreditBySecondPass {

	my( $self, $secondPassword, $targetUsername ) = @_;
	my $method = 'GetUserCreditBySecondPass';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><secondPassword>$secondPassword</secondPassword><targetUsername>$targetUsername</targetUsername></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub GetUserDetails {

	my( $self, $targetUsername ) = @_;
	my $method = 'GetUserDetails';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><targetUsername>$targetUsername</targetUsername></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub GetUserIsExist {

	my( $self, $targetUsername ) = @_;
	my $method = 'GetUserIsExist';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><targetUsername>$targetUsername</targetUsername></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub GetUserNumbers {

	my( $self ) = @_;
	my $method = 'GetUserNumbers';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub GetUserTransactions {

	my( $self, $targetUsername, $creditType, $dateFrom, $dateTo, $keyword ) = @_;
	my $method = 'GetUserTransactions';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><targetUsername>$targetUsername</targetUsername><creditType>$creditType</creditType><dateFrom>$dateFrom</dateFrom><dateTo>$dateTo</dateTo><keyword>$keyword</keyword></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetUserWallet {

	my( $self ) = @_;
	my $method = 'GetUserWallet';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}    
sub GetUserWalletTransaction {

	my( $self, $dateFrom, $dateTo, $count, $startIndex, $payType, $payLoc ) = @_;
	my $method = 'GetUserWalletTransaction';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><dateFrom>$dateFrom</dateFrom><dateTo>$dateTo</dateTo><count>$count</count><startIndex>$startIndex</startIndex><payType>$payType</payType><payLoc>$payLoc</payLoc></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}    
sub GetUsers {

	my( $self ) = @_;
	my $method = 'GetUsers';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub HasFilter {

	my( $self, $text ) = @_;
	my $method = 'HasFilter';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><text>$text</text></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
} 
sub RemoveUser {

	my( $self, $targetUsername ) = @_;
	my $method = 'RemoveUser';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><targetUsername>$targetUsername</targetUsername></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub RevivalUser {

	my( $self, $targetUsername ) = @_;
	my $method = 'RevivalUser';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><targetUsername>$targetUsername</targetUsername></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _usersURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   


# Contact API Operations
sub AddContact {

	my( $self, $groupIds, $firstname, $lastname, $nickname, $corporation, $mobilenumber, $phone, $fax, $birthdate, $email, $gender, $province, $city, $address, $postalCode, $additionaldate, $additionaltext, $descriptions ) = @_;
	my $method = 'AddContact';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><groupIds>$groupIds</groupIds><firstname>$firstname</firstname><lastname>$lastname</lastname><nickname>$nickname</nickname><corporation>$corporation</corporation><mobilenumber>$mobilenumber</mobilenumber><phone>$phone</phone><fax>$fax</fax><birthdate>$birthdate</birthdate><email>$email</email><gender>$gender</gender><province>$province</province><city>$city</city><address>$address</address><postalCode>$postalCode</postalCode><additionaldate>$additionaldate</additionaldate><additionaltext>$additionaltext</additionaltext><descriptions>$descriptions</descriptions></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddContactEvents {

	my( $self, $contactId, $eventName, $eventType, $eventDate ) = @_;
	my $method = 'AddContactEvents';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><contactId>$contactId</contactId><eventName>$eventName</eventName><eventDate>$eventDate</eventDate><eventType>$eventType</eventType></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddGroup {

	my( $self, $groupName, $Descriptions, $showToChilds ) = @_;
	my $method = 'AddGroup';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><groupName>$groupName</groupName><Descriptions>$Descriptions</Descriptions><showToChilds>$showToChilds</showToChilds></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub ChangeContact {

	my( $self, $contactId, $mobilenumber, $firstname, $lastname, $nickname, $corporation, $phone, $fax, $email, $gender, $province, $city, $address, $postalCode, $additionaltext, $descriptions, $contactStatus ) = @_;
	my $method = 'ChangeContact';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><contactId>$contactId</contactId><mobilenumber>$mobilenumber</mobilenumber><firstname>$firstname</firstname><lastName>$lastname</lastname><nickname>$nickname</nickname><corporation>$corporation</corporation><phone>$phone</phone><fax>$fax</fax><email>$email</email><gender>$gender</gender><province>$province</province><city>$city</city><address>$address</address><postalCode>$postalCode</postalCode><additionaltext>$additionaltext</additionaltext><descriptions>$descriptions</descriptions><contactStatus>$contactStatus</contactStatus></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub ChangeGroup {

	my( $self, $groupId, $groupName, $Descriptions, $showToChilds, $groupStatus ) = @_;
	my $method = 'ChangeGroup';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><groupId>$groupId</groupId><groupName>$groupName</groupName><Descriptions>$Descriptions</Descriptions><showToChilds>$showToChilds</showToChilds><groupStatus>$groupStatus</groupStatus></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub CheckMobileExistInContact {

	my( $self, $mobileNumber ) = @_;
	my $method = 'CheckMobileExistInContact';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><mobileNumber>$mobileNumber</mobileNumber></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub GetContactEvents {

	my( $self, $contactId ) = @_;
	my $method = 'GetContactEvents';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><contactId>$contactId</contactId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetContacts {

	my( $self, $groupId, $keyword, $from, $count ) = @_;
	my $method = 'GetContacts';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><groupId>$groupId</groupId><keyword>$keyword</keyword><from>$from</from><count>$count</count></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub GetContactsByID {

	my( $self, $contactId, $status ) = @_;
	my $method = 'GetContactsByID';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><contactId>$contactId</contactId><status>$status</status></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetGroups {

	my( $self ) = @_;
	my $method = 'GetGroups';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub MergeGroups {

	my( $self, $originGroupId, $destinationGroupId, $deleteOriginGroup ) = @_;
	my $method = 'MergeGroups';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><originGroupId>$originGroupId</originGroupId><destinationGroupId>$destinationGroupId</destinationGroupId><deleteOriginGroup>$deleteOriginGroup</deleteOriginGroup></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub RemoveContact {

	my( $self, $mobilenumber ) = @_;
	my $method = 'RemoveContact';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><mobilenumber>$mobilenumber</mobilenumber></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub RemoveContactByContactID {

	my( $self, $contactId ) = @_;
	my $method = 'RemoveContactByContactID';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><contactId>$contactId</contactId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}    
sub RemoveGroup {

	my( $self, $groupId ) = @_;
	my $method = 'RemoveGroup';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><groupId>$groupId</groupId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _contactsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
 
  
# ACtions API Operations
sub AddBranch {

	my( $self, $branchName, $owner ) = @_;
	my $method = 'AddBranch';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><branchName>$branchName</branchName><owner>$owner</owner></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddBulk {

	my( $self, $from, $branch, $bulkType, $title, $message, $rangeFrom, $rangeTo, $DateToSend, $requestCount, $rowFrom ) = @_;
	my $method = 'AddBulk';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><from>$from</from><branch>$branch</branch><bulkType>$bulkType</bulkType><title>$title</title><message>$message</message><rangeFrom>$rangeFrom</rangeFrom><rangeTo>$rangeTo</rangeTo><DateToSend>$DateToSend</DateToSend><requestCount>$requestCount</requestCount><rowFrom>$rowFrom</rowFrom></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddNewBulk {

	my( $self, $from, $branch, $bulkType, $title, $message, $rangeFrom, $rangeTo, $DateToSend, $requestCount, $rowFrom ) = @_;
	my $method = 'AddNewBulk';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><from>$from</from><branch>$branch</branch><bulkType>$bulkType</bulkType><title>$title</title><message>$message</message><rangeFrom>$rangeFrom</rangeFrom><rangeTo>$rangeTo</rangeTo><DateToSend>$DateToSend</DateToSend><requestCount>$requestCount</requestCount><rowFrom>$rowFrom</rowFrom></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddNumber {

	my( $self, $branchId, @mobileNumbers ) = @_;
	my $method = 'AddNumber';
	my $_mobileNumbers = "<string>" . join("</string><string>", @mobileNumbers) . "</string>";
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><branchId>$branchId</branchId><mobileNumbers>$_mobileNumbers</mobileNumbers></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetBranchs {

	my( $self, $owner ) = @_;
	my $method = 'GetBranchs';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><owner>$owner</owner></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetBulk {

	my( $self ) = @_;
	my $method = 'GetBulk';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub GetBulkCount {

	my( $self, $branch, $rangeFrom, $rangeTo ) = @_;
	my $method = 'GetBulkCount';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><branch>$branch</branch><rangeFrom>$rangeFrom</rangeFrom><rangeTo>$rangeTo</rangeTo></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetBulkReceptions {

	my( $self, $bulkId, $fromRows ) = @_;
	my $method = 'GetBulkReceptions';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><bulkId>$bulkId</bulkId><fromRows>$fromRows</fromRows></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetBulkStatus {

	my( $self, $bulkId, $sent, $failed, $status ) = @_;
	my $method = 'GetBulkStatus';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><bulkId>$bulkId</bulkId><sent>$sent</sent><failed>$failed</failed><status>$status</status></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
# sub GetMessagesReceptions {

# 	my( $self, $msgId, $fromRows ) = @_;
# 	my $method = 'GetMessagesReceptions';
# 	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><msgId>$msgId</msgId><fromRows>$fromRows</fromRows></$method></soap:Body></soap:Envelope>";

#     my $ua = LWP::UserAgent->new();
#     my $request = HTTP::Request->new(POST => _actionsURL);
# 	$request->content($envelope);
# 	$request->content_type("text/xml; charset=utf-8");
# 	my $response = $ua->request($request);
# 	print $response->as_string;
# }
sub GetMobileCount {

	my( $self, $branch, $rangeFrom, $rangeTo ) = @_;
	my $method = 'GetMobileCount';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><branch>$branch</branch><rangeFrom>$rangeFrom</rangeFrom><rangeTo>$rangeTo</rangeTo></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub GetSendBulk {

	my( $self ) = @_;
	my $method = 'GetSendBulk';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetTodaySent {

	my( $self ) = @_;
	my $method = 'GetTodaySent';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub GetTotalSent {

	my( $self ) = @_;
	my $method = 'GetTotalSent';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub RemoveBranch {

	my( $self, $branchId ) = @_;
	my $method = 'RemoveBranch';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><branchId>$branchId</branchId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub RemoveBulk {

	my( $self, $bulkId ) = @_;
	my $method = 'RemoveBulk';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><bulkId>$bulkId</bulkId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub SendMultipleSMS {

	my( $self, @to, $from, @text, $isflash, $udh, @recId, $status ) = @_;
	my $method = 'SendMultipleSMS';
	my $_to = "<string>" . join("</string><string>", @to) . "</string>";
	my $_text = "<string>" . join("</string><string>", @text) . "</string>";
	my $_recId = "<long>" . join("</long><long>", @recId) . "</long>";
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><to>$_to</to><from>$from</from><text>$_text</text><isflash>$isflash</isflash><udh>$udh</udh><recId>$_recId</recId><status>$status</status></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub SendMultipleSMS2 {

	my( $self, @to, @from, @text, $isflash, $udh, @recId, $status ) = @_;
	my $method = 'SendMultipleSMS2';
	my $_to = "<string>" . join("</string><string>", @to) . "</string>";
	my $_from = "<string>" . join("</string><string>", @from) . "</string>";
	my $_text = "<string>" . join("</string><string>", @text) . "</string>";
	my $_recId = "<long>" . join("</long><long>", @recId) . "</long>";
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><to>$_to</to><from>$_from</from><text>$_text</text><isflash>$isflash</isflash><udh>$udh</udh><recId>$_recId</recId><status>$status</status></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub UpdateBulkDelivery {

	my( $self, $bulkId ) = @_;
	my $method = 'UpdateBulkDelivery';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><bulkId>$bulkId</bulkId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _actionsURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}



# Schedule API Operations
sub AddMultipleSchedule {

	my( $self, @to, $from, @text, $isflash, @scheduleDateTime, $period ) = @_;
	my $method = 'AddMultipleSchedule';
	my $_to = "<string>" . join("</string><string>", @to) . "</string>";
	my $_text = "<string>" . join("</string><string>", @text) . "</string>";
	my $_schDates = "<dateTime>" . join("</dateTime><dateTime>", @scheduleDateTime) . "</dateTime>";
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><to>$_to</to><from>$from</from><text>$_text</text><isflash>$isflash</isflash><scheduleDateTime>$_schDates</scheduleDateTime><period>$period</period></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _scheduleURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddNewUsance {

	my( $self, $to, $from, $text, $isflash, $scheduleStartDateTime, $countrepeat, $scheduleEndDateTime, $periodType ) = @_;
	my $method = 'AddNewUsance';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><to>$to</to><from>$from</from><text>$text</text><isflash>$isflash</isflash><scheduleStartDateTime>$scheduleStartDateTime</scheduleStartDateTime><countrepeat>$countrepeat</countrepeat><periodType>$periodType</periodType></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _scheduleURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub AddSchedule {

	my( $self, $to, $from, $text, $isflash, $scheduleDateTime, $period ) = @_;
	my $method = 'AddSchedule';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><to>$to</to><from>$from</from><text>$text</text><isflash>$isflash</isflash><scheduleDateTime>$scheduleDateTime</scheduleDateTime><period>$period</period></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _scheduleURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub AddUsance {

	my( $self, $to, $from, $text, $isflash, $scheduleStartDateTime, $repeatAfterDays, $scheduleEndDateTime ) = @_;
	my $method = 'AddUsance';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><to>$to</to><from>$from</from><text>$text</text><isflash>$isflash</isflash><scheduleStartDateTime>$scheduleStartDateTime</scheduleStartDateTime><repeatAfterDays>$repeatAfterDays</repeatAfterDays><scheduleEndDateTime>$scheduleEndDateTime</scheduleEndDateTime></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _scheduleURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}
sub GetScheduleStatus {

	my( $self, $scheduleId ) = @_;
	my $method = 'GetScheduleStatus';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><scheduleId>$scheduleId</scheduleId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _scheduleURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}   
sub RemoveSchedule {

	my( $self, $scheduleId ) = @_;
	my $method = 'RemoveSchedule';
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><scheduleId>$scheduleId</scheduleId></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _scheduleURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
}  
sub RemoveScheduleList {

	my( $self, @scheduleIdList ) = @_;
	my $method = 'RemoveScheduleList';
	my $_list = "<int>" . join("</int><int>", @scheduleIdList) . "</int>";
	my $envelope = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><$method xmlns=\"http://tempuri.org/\"><username>$self->{_username}</username><password>$self->{_password}</password><scheduleIdList>$_list</scheduleIdList></$method></soap:Body></soap:Envelope>";

    my $ua = LWP::UserAgent->new();
    my $request = HTTP::Request->new(POST => _scheduleURL);
	$request->content($envelope);
	$request->content_type("text/xml; charset=utf-8");
	my $response = $ua->request($request);
	print $response->as_string;
} 
