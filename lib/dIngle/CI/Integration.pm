  package dIngle::CI::Integration;
# ********************************
  our $VERSION = '0.01';
# **********************

; use strict; use warnings; use utf8
; use Carp ()

; use subs 'init'

; use HO::class
    _rw => name => '$',
    _rw => starttask => sub { 'Run integration' }

; sub init
    { my ($self,$name) = @_
    ; if(ref($name) || !$name)
       { Carp::croak("A integration needs to be named.")
       }
    ; $self->name($name)
    ; $self
    }
    
; 1

__END__

