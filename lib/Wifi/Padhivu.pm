#/usr/bin/env perl

#-- http://osxdaily.com/2007/01/18/airport-the-little-known-command-line-wireless-utility
#-- https://github.com/sivel/speedtest-cli

package Wifi::Padhivu;

use strict;
use warnings;
use Exporter;

our $VERSION = '0.1.0';
our @ISA = qw( Exporter );
our @EXPORT_OK = qw(
    getCurrentWifiSSID
    getSpeedTestResults
);

sub getCurrentWifiSSID {
    my $SSID;
    my $cmdResult = `/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I`;
    die $cmdResult if $? != 0;
    die 'Wifi has been turned off.' if $cmdResult =~ /Off/;
    $cmdResult =~ /^[\t\s]+SSID: (.*)$/m;
    $SSID = ( $1 =~ s/(^\s+|\s+$)//r );
    die 'Not yet connected to a Wifi network.' if $SSID eq '';
    return $SSID;
}

sub getSpeedTestResults {
    my $result;
    my $cmdResult = `/usr/local/bin/speedtest-cli`;
    die $cmdResult if $? != 0;
    $cmdResult =~ /^Testing from ([^\(]+)\s+\(.*/m;
    $result->{provider} = $1;
    $cmdResult =~ /^Download: (.*)$/m;
    $result->{speed_download} = ($1 =~ s/\s+Mbits\/s//r);
    $cmdResult =~ /^Upload: (.*)$/m;
    $result->{speed_upload} = ($1 =~ s/\s+Mbits\/s//r);
    return $result;
}

1;