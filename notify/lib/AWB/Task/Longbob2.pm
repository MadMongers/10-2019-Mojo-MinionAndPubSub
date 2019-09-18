package AWB::Task::Longbob2;
use Mojo::Base 'Mojolicious::Plugin';
use feature 'say';

sub register {
    my ($self, $app) = @_;
    my ($taskname) = __PACKAGE__ =~ m/::(\w+)\z/;
    $app->minion->add_task($taskname => sub {
      my $job = shift;
      say __PACKAGE__, ' started';
      sleep 60;
      say __PACKAGE__, ' ended';
      $job->finish( {Task => $taskname} );
    });
}

1;
