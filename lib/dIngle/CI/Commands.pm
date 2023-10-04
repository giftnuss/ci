  package dIngle::CI::Commands;
# *****************************
  our $VERSION = '0.011';
# **********************
; use strict; use warnings; use utf8

; use Carp()

; use HO::class
    _rw => commands => '%'

; sub add_command
    { my ($self,$name,$commandline) = @_
    ; if( exists $self->commands->{$name} )
        { Carp::croak("Command '$name' is already defined.")
        }
    ; $self->commands->{$name} = $commandline
    }
 
; sub _setup_commands
    { my ($self,$commands) = @_
    ; foreach my $cmd (keys %$commands)
        { $self->add_command($cmd,$commands->{$cmd})
        }
    }

; sub get_commandline
    { my ($self,$name) = @_
    ; return $self->commands->{$name} if exists $self->commands->{$name}
    ; Carp::croak("Command '$name' is not defined.")
    }

; 1

__END__


