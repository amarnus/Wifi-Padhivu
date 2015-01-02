#!/usr/bin/env perl

use strict;
use warnings;
use lib( './lib' );
use feature 'state';

use Wifi::Padhivu qw( getCurrentWifiSSID getSpeedTestResults );
use DBI;

my $DATABASE_NAME = 'wifi_padhivu';
my $DATABASE_USER = undef;
my $DATABASE_PASS = undef;

sub getConn {
    state $dbh;
    my $attr = { PrintError => 0 };
    my $haveErrors = 0;
    if ( !defined( $dbh ) ) {
        eval {
            $dbh  = DBI->connect("dbi:Pg:db=$DATABASE_NAME", $DATABASE_USER, $DATABASE_PASS, $attr );
        };
        $haveErrors = $@ if $@;
        $haveErrors = DBI::errstr if DBI::err;
        die "$haveErrors\nRun createdb $DATABASE_NAME if you haven\'t yet.\n" if $haveErrors;
    }
    return $dbh;
}

sub ensureSave {
    my $dbh = getConn;
    $dbh->do( 'SELECT 1 FROM readings;' );
    die "Relation readings not found.\n" .
        "Run psql $DATABASE_NAME < db/schema.sql if you haven\'t yet." if $dbh->err;
}

sub record {
    ensureSave;
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
    my $dbh = getConn;
    my @values = (
        $result->{ssid},
        $result->{provider},
        $result->{record_start},
        $result->{record_end},
        $result->{record_duration},
        $result->{speed_upload},
        $result->{speed_download}
    );
    $dbh->do( '
        INSERT INTO readings(
            ssid, provider, record_start, record_end, record_duration, speed_upload, speed_download
        ) 
        VALUES(?, ?, to_timestamp(?), to_timestamp(?), ?, ?, ?)', {}, @values
    );
    die $dbh->errstr if $dbh->err;
}

record;