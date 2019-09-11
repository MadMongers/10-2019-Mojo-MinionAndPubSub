#!/bin/bash
set -x
perl worker.pl minion worker -q notdefault -q default
