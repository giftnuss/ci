#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'dIngle::CI',
    dist_version => '0.01',
    dist_author => [
        'Sebastian Knapp <sknpp@cpan.org>'
    ],
    license => 'gpl3',
    dist_abstract => 'a continuous integration tool',
    requires => {
       'perl' => '5.12.0',
       'System::Command' => '1.122'
    },
);

$builder->create_build_script();
