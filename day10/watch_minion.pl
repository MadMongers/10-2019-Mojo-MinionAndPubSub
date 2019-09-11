#!/usr/bin/env perl
use Mojolicious::Lite;

plugin Minion => { SQLite => 'sqlite:' . app->home->child('minion.db'), };
plugin 'Minion::Admin', {
    # Host Admin UI at /
    route => app->routes->any('/'),
};

app->start;
