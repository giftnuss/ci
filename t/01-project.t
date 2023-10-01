; use lib 'lib/'
; use strict; use warnings

; use Path::Tiny()

; BEGIN 
    { $ENV{'DINGLE_CONFIG_PATH'} = 
              Path::Tiny::path(__FILE__)->parent->child('config').""
    }

; use dIngle::CI::Library

; $dIngle::Log::Testing::LEVEL->{'debug'} = 1;
; $dIngle::Log::Testing::LEVEL->{'info'} = 1;

; use Test2::V0 qw(is ok done_testing)

; use dIngle::Instance
; use dIngle::CI::Project

; my $instance = new dIngle::Instance()->name('testing')->fallback('default')

; my $project = new dIngle::CI::Project::

; is($project->name,'dingle-ci')
; is([$project->modulepath],[])
; is([$project->structurepath],[])

; ok($project->can('add_command'),'mixed in add_command')
; is($project->commands,{},'mixed in commands')

; $project->load_config( instance => $instance )
; $project->load_modules

; is(0+$project->list_modules,3,'count modules: ' 
    . join(", ",$project->list_modules))

; is([$project->get_submodules],['I18N','Tasks'],'submodules')

#; dIngle->dump($project->configuration)
; foreach my $prj ($project->get_integrations)
    { #dIngle->dump($prj)
    }

; done_testing

; END
    { #print join(" ",@$_),"\n" for dIngle::Library->get_library
    }

