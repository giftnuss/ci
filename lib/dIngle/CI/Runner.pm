  package dIngle::CI::Runner;
# ***************************
  our $VERSION = '0.01';
# **********************

; use strict; use warnings; use utf8

; use parent 'dIngle::Generator'

; use dIngle::System ()
; use dIngle::CI::Project ()

; sub init
    { my ($self,%args) = @_
    ; $args{'project'} = dIngle::CI::Project->new
        unless exists $args{'project'}
    ; $self->SUPER::init(%args)
    ; $self->starttask("CI run all")
    ; $self
    }
    
; sub setup_hive
    { my ($self) = @_
    ; $self->SUPER::setup_hive
    ; my $system = new dIngle::System::
    ; $self->hive->add_layer($system->name)
    ; $self->setup_project
        ( project => $system
        , modules => [ 'Config' ]
        )
    }

; 1

__END__

