  package dIngle::CI::Project;
# ****************************
  our $VERSION = '0.01';
# **********************

; use strict; use warnings; use utf8

; use dIngle::CI::Integration

; use parent 'dIngle::Project'

; use HO::class
    _rw => integrations => '@'

; sub init
    { my ($self,@name) = (@_,'dingle-ci')
    ; $self->name(@name)
    ; $self->set_namespace('dIngle::CI')
    ; $self
    }
    
; sub get_integrations
    { my ($self) = @_
    ; unless($self->integrations)
        { my %integrations = $self->configuration->get_entry('integration')
        ; foreach my $name (keys %integrations)
            { my $integration = new dIngle::CI::Integration($name)
            ; $self->integrations('<',$integration)
            }
        }
    ; $self->integrations
    }
    
; 1

__END__

