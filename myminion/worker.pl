#!/usr/bin/env perl
use v5.28;
use Mojolicious::Lite;
use lib 'lib';

eval {
    my $config = plugin Config => {file => 'awb.conf'};

    plugin Minion => {Pg => $config->{Pg}};

    plugin 'AWB::Task::Bob1';
    plugin 'AWB::Task::Bob2';
    plugin 'AWB::Task::Longbob2';
    plugin 'AWB::Task::Pack';
    1;
} or do {
    die $@;
};
app->start;
