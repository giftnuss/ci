  package dIngle::CI::Project;
# ****************************
  our $VERSION = '0.01';
# **********************

; use strict; use warnings; use utf8
; use Carp()

; use dIngle::CI::Integration

; use parent 'dIngle::Project'

; use HO::mixin 'dIngle::CI::Commands'

; use HO::class
    _rw => integrations => '@'

# no SUPER::init by intention
; sub init
    { my ($self,@name) = (@_,'dingle-ci')
    ; $self->name(@name)
    ; $self->set_namespace('dIngle::CI')
    ; $self
    }
    
; sub load_config
    { my ($self,%args) = @_
    ; $self->SUPER::load_config(%args)
    ; if(my $commands = $self->configuration->get_entry('commands'))
        { $self->_setup_commands($commands)
        }
    ; $self->_setup_integrations
    ; return $self
    }
    
; sub _setup_integrations
    { my ($self) = @_
    ; my %integrations = $self->configuration->get_entry('integration')
    ; foreach my $name (keys %integrations)
        { my $integration = new dIngle::CI::Integration
            (name => $name, project => $self)
        ; $integration->setup($integrations{$name})
        ; $self->integrations('<',$integration)
        }
    }

; sub get_integrations
    { my ($self) = @_
    ; $self->integrations
    }
    
; 1

__END__

=NAME

dIngle::CI::Project - a continuous integration project

=SYNOPSIS

   my $project = dIngle::CI::Project->new("prj-ci");
   
   $project->load_modules
   $project->load_config

