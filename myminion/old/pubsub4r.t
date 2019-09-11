use Mojo::Base -strict;

#BEGIN { $ENV{MOJO_REACTOR} = 'Mojo::Reactor::Poll' }

use Test::More 'no_plan';

#plan skip_all => 'set TEST_ONLINE to enable this test' unless $ENV{TEST_ONLINE};

use Mojo::IOLoop;
use Mojo::JSON 'true';
use Mojo::Pg;
use Config::Any::Perl;
use feature 'say';
use utf8::all;

# Notifications with event loop
#my $pg = Mojo::Pg->new($ENV{TEST_ONLINE});
my $config = Config::Any::Perl->load('awb.conf');
my $pg = Mojo::Pg->new( $config->{Pg} );

my ($db, @all, @test);
$pg->pubsub->on(reconnect => sub { $db = pop });
$pg->pubsub->listen(
  pstest => sub {
    my ($pubsub, $payload) = @_;
    push @test, $payload;
    say 'payload: ', $payload;
#    Mojo::IOLoop->next_tick(sub { say 'next tick'; $pubsub->pg->db->notify(pstest => 'stop') });
    if ($payload eq 'stop') {
	say 'stop';
        Mojo::IOLoop->stop;
    }
  }
);
$db->on(notification => sub { say 'notify', $_[3]; });
Mojo::IOLoop->start;
done_testing;
