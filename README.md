# NAME

Wifi::Padhivu

# SYNOPSIS

    carton exec perl script/recorder.pl

# DESCRIPTION

Wifi::Padhivu is a really simple script for your Mac that detects and records the name and speed of the Wifi network that you are currently connected to. In conjunction with `crontab`, this tool can be used to monitor the speed of all the Wifi networks that you connect to over time.

# INSTALLATION

You need to have a running [PostgreSQL](https://www.postgresql.org) server and [Speedtest CLI](https://github.com/sivel/speedtest-cli) installed at `/usr/local/bin`.

Install [Carton](https://github.com/perl-carton/carton) on your machine, clone this repository and install its dependencies.

    cpanm Carton
    git clone https://github.com/amarnus/Wifi-Padhivu
    cd Wifi-Padhivu/
    carton install

# LICENSE

Copyright (C) 2015 Amarnath Ravikumar.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Amarnath Ravikumar <amarnus@gmail.com>
