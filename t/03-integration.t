; use lib 'lib/'
; use strict; use warnings

; use Path::Tiny

; BEGIN
    { my $testconfig = Path::Tiny::path(__FILE__)
            ->parent->child( 'config' )
    ; $ENV{'DINGLE_CONFIG_PATH'} = $testconfig
    }

; use dIngle::CI::Library

; BEGIN { $dIngle::LOGGING = 'testing' }

; $dIngle::Log::Testing::LEVEL->{'debug'} = 1;
; $dIngle::Log::Testing::LEVEL->{'info'} = 1;

; use Test2::V0 qw(is ok isa_ok done_testing)


; use dIngle::CI::Project

; my $project = new dIngle::CI::Project::('testintegration')

; use dIngle::CI::Integration

; my $one = dIngle::CI::Integration->new
    ( name => 'integration1', project => $project )

; is($one->name,'integration1','name')
; is($one->project->name,'testintegration','project')
; is($one->basepath,'.','basepath')
; isa_ok($one->monitor,['dIngle::CI::Monitor'],'monitor')
; is($one->starttask,'Run integration','starttask')

; done_testing

    
