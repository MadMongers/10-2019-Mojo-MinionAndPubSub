use Mojolicious::Lite;

plugin Minion => { Pg => 'posgressql://...'};

plugin 'Minion::Notifier';

app->minion->add_task( doit => sub { ... } );

any '/doit' => sub {
    my $c = shift;
    my $id = $c->minion->enqueue(doit => [...]);
    $c->minion_notifier->on(job => sub {
        my ($notifier, $job_id, $message) = @_;
        return unless $job_id eq $id;
        $c->render( text => "job $id: $message" );
    });
};
