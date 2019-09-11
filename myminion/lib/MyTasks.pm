package MyTasks;
use strict;
use warnings;
use utf8::all;
use feature qw(say signatures);
no warnings qw(experimental::signatures);    ## no critic
use Carp 'croak';
use English;
use Ouch;
use lib 'lib';
use Minion;

our $VERSION = '1.00';

sub add_task_pack ($minion) {
    eval {
        $minion->add_task(pack => sub ($job){
          say 'Task pack started';
          sleep 5;
          say 'Task pack ended';
          $job->finish( {Task => 'pack'} );
        });
        1;
    } or do {
        ouch 'Bad Task Added', "Add Task (pack) failed: $@";
    };
}

sub add_task_bob1 ($minion) {
    eval {
        $minion->add_task(bob1 => sub ($job){
          say 'Task bob1 started';
          sleep 5;
          say 'Task bob1 ended';
          $job->finish( {Task => 'bob1'} );
        });
        1;
    } or do {
        ouch 'Bad Task Added', "Add Task (bob1) failed: $@";
    };
}

sub add_task_bob2 ($minion) {
    eval {
        $minion->add_task(bob2 => sub ($job){
          say 'Task bob2 started';
          sleep 5;
          say 'Task bob2 ended';
          $job->finish( {Task => 'bob2'} );
        });
        1;
    } or do {
        ouch 'Bad Task Added', "Add Task (bob2) failed: $@";
    };
}

sub add_task_Longbob2 ($minion) {
    eval {
        $minion->add_task(longbob2 => sub ($job){
          say 'Task longbob2 started';
          sleep 60;
          say 'Task longbob2 ended';
          $job->finish( {Task => 'longbob2'} );
        });
        1;
    } or do {
        ouch 'Bad Task Added', "Add Task (longbob2) failed: $@";
    };
}

1;
