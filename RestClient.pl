use strict;
use warnings;

use LWP::UserAgent;
use CGI;

BEGIN {  # BEGIN means this will all happen at compile time
    package Constants;

    $INC{'Constants.pm'}++;     # tell `require` that the package is loaded
    use base 'Exporter';        # setup package to export
    our @EXPORT_OK = qw( URL );  # what to export

    use constant URL => 'https://rest.payamak-panel.com/api/SendSMS/'; # define your constant
}


package RestClient;

use Constants qw( URL );  # use it like normal

sub new {
    my $class = shift;
    my $self = {
        _username => shift,
        _password  => shift,
    };
    bless $self, $class;
    return $self;
}

sub SendSMS {

	my( $self, $to, $from, $text ) = @_;

    my $ua = LWP::UserAgent->new();
	my $response = $ua->post( URL . 'SendSMS', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
		'to' => $to,
		'from' => $from,
		'text' => $text
	});

	my $content  = $response->decoded_content();

	my $cgi = CGI->new();
	print $cgi->header(), $content;
}

sub SendByBaseNumber {

	my( $self, $text, $to, $bodyId ) = @_;

    my $ua = LWP::UserAgent->new();
	my $response = $ua->post( URL . 'BaseServiceNumber', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
		'text' => $text,
		'to' => $to,
		'bodyId' => $bodyId
	});

	my $content  = $response->decoded_content();

	my $cgi = CGI->new();
	print $cgi->header(), $content;
}

sub GetDeliveries2 {
	
	my( $self, $recID ) = @_;

    my $ua = LWP::UserAgent->new();
	my $response = $ua->post( URL . 'GetDeliveries2', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
		'recID' => $recID,
	});

	my $content  = $response->decoded_content();

	my $cgi = CGI->new();
	print $cgi->header(), $content;
}

sub GetMessages {
	
	my( $self, $location, $from, $index, $count ) = @_;

    my $ua = LWP::UserAgent->new();
	my $response = $ua->post( URL . 'GetMessages', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
		'location' => $location,
		'from' => $from,
		'index' => $text,
		'count' => $count
	});

	my $content  = $response->decoded_content();

	my $cgi = CGI->new();
	print $cgi->header(), $content;
}

sub GetCredit {
	
	my( $self ) = @_;

    my $ua = LWP::UserAgent->new();
	my $response = $ua->post( URL . 'GetCredit', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
	});

	my $content  = $response->decoded_content();

	my $cgi = CGI->new();
	print $cgi->header(), $content;
}

sub GetBasePrice {
	
	my( $self ) = @_;

    my $ua = LWP::UserAgent->new();
	my $response = $ua->post( URL . 'GetBasePrice', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
	});

	my $content  = $response->decoded_content();

	my $cgi = CGI->new();
	print $cgi->header(), $content;
}

sub GetUserNumbers {
	
	my( $self ) = @_;

    my $ua = LWP::UserAgent->new();
	my $response = $ua->post( URL . 'GetUserNumbers', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
	});

	my $content  = $response->decoded_content();

	my $cgi = CGI->new();
	print $cgi->header(), $content;
}
