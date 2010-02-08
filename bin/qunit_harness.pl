#!/usr/bin/env perl

use warnings;
use strict;


my %args = (@ARGV);
my $port = $args{'--port'};
my $url = "http://localhost:8008/static/honeycomb/test/index.html";
my $server = QunitServer->new( $port || (10000 + int(rand(10000))));
$server->run();


package QunitServer;
use base 'HTTP::Server::Simple::CGI';
use Data::Dumper;

sub print_banner {
    my $self = shift;
    $self->run_browser();
}

sub run_browser {
    my $self = shift;
    my $command =  "chromium-browser ".$url."#".$self->port;
    `($command)&`;
}

our $counter;

sub handle_request {
    my $self = shift;
    my $cgi = shift;
    my $result;
    if ($cgi->param('type') eq 'startup') {
        $self->stdio_handle->print( "200 OK\n\nOK");
    }
    if ($cgi->param('type') eq 'one-test'){
        print "".( $cgi->param('result')? 'ok':'not ok') . " " .++$counter . " " .$cgi->param('message')."\n";
    } elsif ($cgi->param('type') eq 'done'){ 
        my $result = $cgi->param('done');
        print "1..".$cgi->param('total')."\n"; # crosschecking with the counter on the other side
        exit( $cgi->param('fail') ? 1 : 0);
    }
}

sub stdout_handle {
    return *STDOUT;
}

