#!/usr/bin/env perl
use Mojolicious::Lite;

plugin Minion => { Pg => 'postgresql://devel:new_password@localhost/music'};
plugin 'Minion::Admin', {
    # Host Admin UI at /
    route => app->routes->any('/'),
};

app->start;
