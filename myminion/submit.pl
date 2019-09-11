#!/usr/bin/env perl
use strict; use warnings;
use lib 'lib';
use Minion;
use Config::Any::Perl;

eval {
    my $config = Config::Any::Perl->load('awb.conf');
    my $minion = Minion->new( Pg => $config->{Pg});

    # Perform jobs for testing
    $minion->enqueue(Bob1 => ['stan', 'ollie'], {queue => 'notdefault'});
    $minion->enqueue(Bob2 => ['bob' , 'ray'  ], {queue => 'notdefault'});
    1;
} or do {
    die $@;
};

1;
