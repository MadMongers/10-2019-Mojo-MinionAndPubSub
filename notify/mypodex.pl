#!/usr/bin/env perl
use Mojolicious::Lite;

plugin Minion => { Pg => 'postgresql://devel:new_password@localhost/music'};

plugin 'Minion::Notifier';

app->minion->add_task( Bob3 => sub {
    my ($job, @args) = @_;
    sleep 5;
    say 'This is a background worker process.';
  });


any '/doit' => sub {
    my $c = shift;
    my $id = $c->minion->enqueue(Bob3 => ['beavis', 'butthead',] );
    $c->minion_notifier->on(job => sub {
      my ($notifier, $job_id, $message) = @_;
      return unless $job_id eq $id;
      $c->render( text => "job $id: $message" );
    });
};

app->start;
