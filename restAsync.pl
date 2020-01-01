use threads ('yield',
             'stack_size' => 64*4096,
             'exit' => 'threads_only',
             'stringify');
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
        _ua => LWP::UserAgent->new()
    };
    bless $self, $class;
    return $self;
}



sub SendSMS {

	my( $self, $to, $from, $text ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( URL . 'SendSMS', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
		'to' => $to,
		'from' => $from,
		'text' => $text
	})); })->join();
	
	return ($response->decoded_content());
}

sub SendByBaseNumber {

	my( $self, $text, $to, $bodyId ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( URL . 'BaseServiceNumber', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
		'text' => $text,
		'to' => $to,
		'bodyId' => $bodyId
	})); })->join();

	return ($response->decoded_content());
}

sub GetDeliveries2 {
	
	my( $self, $recID ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( URL . 'GetDeliveries2', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
		'recID' => $recID,
	})); })->join();

	return ($response->decoded_content());
}

sub GetMessages {
	
	my( $self, $location, $from, $index, $count ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( URL . 'GetMessages', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
		'location' => $location,
		'from' => $from,
		'index' => $index,
		'count' => $count
	})); })->join();

	return ($response->decoded_content());
}

sub GetCredit {
	
	my( $self ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( URL . 'GetCredit', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
	})); })->join();

	return ($response->decoded_content());
}

sub GetBasePrice {
	
	my( $self ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( URL . 'GetBasePrice', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
	})); })->join();

	return ($response->decoded_content());
}

sub GetUserNumbers {
	
	my( $self ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( URL . 'GetUserNumbers', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
	})); })->join();

	return ($response->decoded_content());
}



# rest tester
my $rest = new RestClient( "username", "password");
print($rest->SendSMS('09123456789', '5000...', 'perl rest test'));
print($rest->SendSMS('09123456789', '5000...', 'perl rest test'));
print($rest->SendSMS('09123456789', '5000...', 'perl rest test'));
