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
    our @EXPORT_OK = qw( _sendURL _smartURL _sharedURL _voiceURL );  # what to export

    use constant _sendURL => 'https://rest.payamak-panel.com/api/SendSMS/'; # define your constant
	use constant _smartURL => 'https://rest.payamak-panel.com/api/SmartSMS/';
	use constant _sharedURL => 'https://rest.payamak-panel.com/api/ShareService/';
	use constant _voiceURL => 'https://rest.payamak-panel.com/api/Voice/';
}


package RestClient;

use Constants qw( _sendURL _smartURL _sharedURL _voiceURL );  # use it like normal
use JSON::PP qw(encode_json);

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



sub _postJson {
    my ($self, $baseAddress, $endpoint, $payload) = @_;

    my $response = threads->create(sub {
        return $self->{_ua}->post(
            $baseAddress . $endpoint,
            'Content-Type' => 'application/json; charset=utf-8',
            Content => encode_json($payload)
        );
    })->join();

    return $response->decoded_content();
}






sub SendSMS {

	my( $self, $to, $from, $text ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( _sendURL . 'SendSMS', { 
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

	my $response = threads->create(sub {return ($self->{_ua}->post( _sendURL . 'BaseServiceNumber', { 
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

	my $response = threads->create(sub {return ($self->{_ua}->post( _sendURL . 'GetDeliveries2', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
		'recID' => $recID,
	})); })->join();

	return ($response->decoded_content());
}

sub GetMessages {
	
	my( $self, $location, $from, $index, $count ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( _sendURL . 'GetMessages', { 
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

	my $response = threads->create(sub {return ($self->{_ua}->post( _sendURL . 'GetCredit', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
	})); })->join();

	return ($response->decoded_content());
}

sub GetBasePrice {
	
	my( $self ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( _sendURL . 'GetBasePrice', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
	})); })->join();

	return ($response->decoded_content());
}

sub GetUserNumbers {
	
	my( $self ) = @_;

	my $response = threads->create(sub {return ($self->{_ua}->post( _sendURL . 'GetUserNumbers', { 
		'username' => $self->{_username}, 
		'password' => $self->{_password}, 
	})); })->join();

	return ($response->decoded_content());
}





# v2

sub SendOTP {
	my ($self, $from, $to, $text) = @_;

    return $self->_postJson(_sendURL, 'SendOTP', {
        username => $self->{_username},
        password => $self->{_password},
        from     => $from,
        to       => $to,
        text     => $text
    });
}

sub SendMultipleSMS {
    my ($self, $from, $to, $text) = @_;

    return $self->_postJson(_sendURL, 'SendMultipleSMS', {
        username => $self->{_username},
        password => $self->{_password},
        from     => $from,
        to       => $to,
        text     => $text
    });
}

sub SendSchedule {
	my ($self, $from, $to, $text, $scheduleDate, $period) = @_;

    return $self->_postJson(_sendURL, 'SendSchedule', {
        username => $self->{_username},
        password => $self->{_password},
        from     => $from,
        to       => $to,
        text     => $text,
		scheduleDate => $scheduleDate,
		period => $period
    });
}

sub GetSchedule {
	my ($self, $scheduleId) = @_;

    return $self->_postJson(_sendURL, 'GetSchedule', {
        username => $self->{_username},
        password => $self->{_password},
        scheduleId     => $scheduleId
    });
}

sub GetDeliveries {
	my ($self, $recID) = @_;

    return $self->_postJson(_sendURL, 'GetDeliveries', {
        username => $self->{_username},
        password => $self->{_password},
        recID     => $recID
    });
}

sub GetNewDeliveries {
	my ($self, $recID) = @_;

    return $self->_postJson(_sendURL, 'GetNewDeliveries', {
        username => $self->{_username},
        password => $self->{_password},
        recID     => $recID
    });
}

sub GetInboxCount {
	my ($self, $isRead) = @_;

    return $self->_postJson(_sendURL, 'GetInboxCount', {
        username => $self->{_username},
        password => $self->{_password},
        isRead     => $isRead
    });
}

sub GetCredit2 {
	my ($self) = @_;

    return $self->_postJson(_sendURL, 'GetCredit2', {
        username => $self->{_username},
        password => $self->{_password}
    });
}

sub GetSmsPrice {
	my ($self, $irancellCount, $mciCount, $from, $text) = @_;

    return $self->_postJson(_sendURL, 'GetSmsPrice', {
        username => $self->{_username},
        password => $self->{_password},
        irancellCount     => $irancellCount,
        mciCount       => $mciCount,
		from => $from,
        text     => $text
    });
}

sub BaseServiceNumber {
	my ($self, $bodyId, $to, $text) = @_;

    return $self->_postJson(_sendURL, 'BaseServiceNumber', {
        username => $self->{_username},
        password => $self->{_password},
        bodyId     => $bodyId,
        to       => $to,
        text     => $text
    });
}

sub BaseServiceNumberSchedule {
	my ($self, $bodyId, $to, $text, $scheduleDate) = @_;

    return $self->_postJson(_sendURL, 'BaseServiceNumberSchedule', {
        username => $self->{_username},
        password => $self->{_password},
        bodyId     => $bodyId,
        to       => $to,
        text     => $text,
		scheduleDate => $scheduleDate
    });
}

sub SendSmartSms {
	my ($self, $from, $to, $text, $fromSupportOne, $fromSupportTwo) = @_;

    return $self->_postJson(_smartURL, 'Send', {
        username => $self->{_username},
        password => $self->{_password},
        from     => $from,
        to       => $to,
        text     => $text,
		fromSupportOne => $fromSupportOne,
		fromSupportTwo => $fromSupportTwo
    });
}

sub SendMultipleSmartSms {
	my ($self, $from, $to, $text, $fromSupportOne, $fromSupportTwo) = @_;

    return $self->_postJson(_smartURL, 'SendMultiple', {
        username => $self->{_username},
        password => $self->{_password},
        from     => $from,
        to       => $to,
        text     => $text,
		fromSupportOne => $fromSupportOne,
		fromSupportTwo => $fromSupportTwo
    });
}

sub GetDeliveries2SmartSms {
	my ($self, $Id) = @_;

    return $self->_postJson(_smartURL, 'GetDeliveries2', {
        username => $self->{_username},
        password => $self->{_password},
        Id     => $Id
    });
}

sub GetDeliveriesSmartSms {
	my ($self, $Ids) = @_;

    return $self->_postJson(_smartURL, 'GetDeliveries', {
        username => $self->{_username},
        password => $self->{_password},
        Ids     => $Ids
    });
}

sub AddBody {
	my ($self, $title, $body) = @_;

    return $self->_postJson(_sharedURL, 'AddBody', {
        username => $self->{_username},
        password => $self->{_password},
        title     => $title,
        body       => $body
    });
}

sub EditBody {
	my ($self, $bodyId, $title, $body) = @_;

    return $self->_postJson(_sharedURL, 'EditBody', {
        username => $self->{_username},
        password => $self->{_password},
        bodyId     => $bodyId,
        title       => $title,
        body     => $body
    });
}

sub DeleteBody {
	my ($self, $bodyId) = @_;

    return $self->_postJson(_sharedURL, 'DeleteBody', {
        username => $self->{_username},
        password => $self->{_password},
        bodyId     => $bodyId
    });
}

sub GetBodies {
	my ($self, $keyword, $status) = @_;

    return $self->_postJson(_sharedURL, 'GetBodies', {
        username => $self->{_username},
        password => $self->{_password},
        keyword     => $keyword,
        status       => $status
    });
}

sub SendSpeechText {
	my ($self, $to, $text) = @_;

    return $self->_postJson(_voiceURL, 'SendSpeechText', {
        username => $self->{_username},
        password => $self->{_password},
        to       => $to,
        text     => $text
    });
}

sub SendVoiceOtp {
	my ($self, $to, $code) = @_;

    return $self->_postJson(_voiceURL, 'SendVoiceOtp', {
        username => $self->{_username},
        password => $self->{_password},
        to       => $to,
        code     => $code
    });
}

sub SendSMSWithSpeechText {
	my ($self, $smsBody, $speechBody, $to, $from) = @_;

    return $self->_postJson(_voiceURL, 'SendSMSWithSpeechText', {
        username => $self->{_username},
        password => $self->{_password},
        smsBody     => $smsBody,
		speechBody	=> $speechBody,
        to       => $to,
        from     => $from
    });
}

sub SendSMSWithSpeechTextBySchduleDate {
	my ($self, $smsBody, $speechBody, $from, $to, $scheduleDate) = @_;

    return $self->_postJson(_voiceURL, 'SendSMSWithSpeechTextBySchduleDate', {
        username => $self->{_username},
        password => $self->{_password},
        smsBody     => $smsBody,
        speechBody       => $speechBody,
        from     => $from,
		to	=> $to,
		scheduleDate	=> $scheduleDate
    });
}

sub GetSendSpeechTextStatus {
	my ($self, $recId) = @_;

    return $self->_postJson(_voiceURL, 'GetSendSpeechTextStatus', {
        username => $self->{_username},
        password => $self->{_password},
        recId     => $recId
    });
}

sub GetSendSpeechTextStatuses {
	my ($self, $recIds) = @_;

    return $self->_postJson(_voiceURL, 'GetSendSpeechTextStatuses', {
        username => $self->{_username},
        password => $self->{_password},
        recIds     => $recIds
    });
}

sub GetSendSMSWithSpeechTextStatus {
	my ($self, $recId) = @_;

    return $self->_postJson(_voiceURL, 'GetSendSMSWithSpeechTextStatus', {
        username => $self->{_username},
        password => $self->{_password},
        from     => $recId
    });
}

sub SendBulkSpeechText {
	my ($self, $title, $body, $receivers, $DateToSend, $RepeatCount) = @_;

    return $self->_postJson(_voiceURL, 'SendBulkSpeechText', {
        username => $self->{_username},
        password => $self->{_password},
        title     => $title,
        body       => $body,
        receivers     => $receivers,
		DateToSend	=> $DateToSend,
		RepeatCount	=> $RepeatCount
    });
}

sub UploadVoiceFile {
	my ($self, $title, $base64StringFile) = @_;

    return $self->_postJson(_voiceURL, 'UploadVoiceFile', {
        username => $self->{_username},
        password => $self->{_password},
        title     => $title,
        base64StringFile       => $base64StringFile
    });
}

sub UploadVoiceFileByte {
	my ($self, $title, $file) = @_;

    return $self->_postJson(_voiceURL, 'UploadVoiceFileByte', {
        username => $self->{_username},
        password => $self->{_password},
        title     => $title,
        file       => $file
    });
}


1;


# rest tester
# my $rest = new RestClient( "username", "password");
# print($rest->SendSMS('09123456789', '5000...', 'perl rest test'));
