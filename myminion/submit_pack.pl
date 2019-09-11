#!/usr/bin/env perl
use strict; use warnings; use feature 'say';
use lib 'lib';
use Minion;
use Config::Any::Perl;

eval {
    my $config = Config::Any::Perl->load('awb.conf');
    my $minion = Minion->new( Pg => $config->{Pg});

    # Perform jobs for testing
    my $id1 = $minion->enqueue(Bob1     => ['stan', 'ollie'], {queue => 'notdefault'});
    my $id2 = $minion->enqueue(Longbob2 => ['bob' , 'ray'  ], {queue => 'notdefault'});

    my $packer = $minion->enqueue( 'Pack' => [ 'dummy' ], {queue => 'notdefault',
	 parents => [ $id1, $id2 ] } );
    1;
} or do {
    dir $@;
};

1;
