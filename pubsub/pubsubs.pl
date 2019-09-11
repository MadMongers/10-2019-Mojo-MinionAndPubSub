#!/usr/bin/env perl
use strict; use warnings;
use Mojo::IOLoop;
use Mojo::Pg;
use Config::Any::Perl;
use feature 'say';
use utf8::all;

my $config = Config::Any::Perl->load('pubsub.conf');
my $pg = Mojo::Pg->new( $config->{Pg} );

my $db;
$pg->pubsub->on(reconnect => sub { $db = pop });
$pg->db->notify(pstest => '♥donuts♥');
$pg->db->notify(pstest => 'JT♥YAML');
$pg->db->notify(pstest => 'stop');
