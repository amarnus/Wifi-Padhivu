requires 'perl', '5.008001';
requires 'DBD::Pg';
requires 'DBI';

on 'test' => sub {
    requires 'Test::More', '0.98';
};