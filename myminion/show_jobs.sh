#!/bin/bash
# example of a specific job
#perl myapp.pl minion job 1

# show jobs associated with a queue
#perl myapp.pl minion job -q default

# list all jobs
export CMD='perl minion.pl minion job ';
export QUE=' -q default';
echo $CMD $1 $QUE;
$CMD $1 $QUE;
