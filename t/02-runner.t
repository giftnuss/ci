; use lib 'lib/'
; use strict; use warnings

; use dIngle::CI::Library

; BEGIN { $dIngle::LOGGING = 'testing' }

; $dIngle::Log::Testing::LEVEL->{'debug'} = 1;
; $dIngle::Log::Testing::LEVEL->{'info'} = 1;

; use Test2::V0 qw(is ok done_testing)


; use dIngle::CI::Project

; my $project = new dIngle::CI::Project::('test1')

; $project->load_modules

; use dIngle::CI::Runner

; my $runner = new dIngle::CI::Runner::(project => $project)

; is($runner->starttask,"CI run all","start task")
; is($runner->project->name,'test1','project name')

; $runner->use_projects($runner->project)

; my $main = $project->module('Runner')
; ok($main->buildable,'runner module is buildable')

; $runner->use_module_layer($main->name,$main)

; $runner->build




; my $run2 = new dIngle::CI::Runner::()
; is($run2->project->name,'dingle-ci','project default name')


; dIngle->dump($runner->hive->dump)

; done_testing

; END
    { #print join(" ",@$_),"\n" for dIngle::Library->get_library
    }

