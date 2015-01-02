#!/usr/bin/env perl

use strict;
use warnings;
use lib( './lib' );

use Wifi::Padhivu qw( getCurrentWifiSSID getSpeedTestResults );
use Data::Dumper;

sub ensureSave {
    #-- Ensure that the database (and the relation) we will be saving results 
    #-- to, is present.
}

sub record {
    my $result;
    my $startTime = time;
    my $endTime;
    my $SSID;
    $SSID = getCurrentWifiSSID;
    $result = getSpeedTestResults;
    $endTime = time;
    $result->{ssid} = $SSID;
    $result->{record_start} = $startTime;
    $result->{record_end} = $endTime;
    $result->{record_duration} = ( $endTime - $startTime );
    save( $result );
}

sub save {
    my $result = shift;
    #-- TODO: Write results to PostgreSQL
    warn Dumper( $result );
}

record;