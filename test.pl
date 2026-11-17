use strict;
use warnings;

# Load SoapClient package
require './soap.pl';

# Your credentials
my $username = 'username';
my $password = 'password';

# Create SoapClient instance
my $soapClient = SoapClient->new($username, $password);

# Example: Get account credit
my $result = $soapClient->GetCredit();
my $result_2 = $soapClient->SendSimpleSMS2("09123456789", "5000...", "test of perl", 0);
print $result;
print $result_2;