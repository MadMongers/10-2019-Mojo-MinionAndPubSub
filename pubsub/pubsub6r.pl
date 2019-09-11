#!/usr/bin/env perl
use strict; use warnings;
use Mojo::IOLoop;
use Mojo::Pg;
use Config::Any::Perl;
use feature 'say';
use utf8::all;

my $config = Config::Any::Perl->load('awb.conf');
my $pg = Mojo::Pg->new( $config->{Pg} );

my $db;
$pg->pubsub->on(reconnect => sub { $db = pop });
$pg->pubsub->listen(
  pstest => sub {
    my ($pubsub, $payload) = @_;
    if ($payload eq 'stop') {
	say $0, ' stop';
        Mojo::IOLoop->stop;
    } else {
        say $0, ' payload: ', $payload;
    }
  }
);

# Works, but not needed
#$db->on(notification => sub { say $0. ' notify: ', $_[3]; });

Mojo::IOLoop->start;
