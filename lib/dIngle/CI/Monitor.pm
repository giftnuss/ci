  package dIngle::CI::Monitor;
# ****************************
  our $VERSION = '0.01';
# **********************
; use strict; use warnings; use utf8

; use Ref::Util()
; use File::Monitor()
; use Path::Tiny()
; use System::Command()

; use HO::class
   _ro => integration => '$',
   _ro => monitor => sub { new File::Monitor:: },
   _ro => changes => '@',
   _ro => script => '@',
   init => 'hash'
   
; sub check 
    { my ($self) = @_
    ; $self->[&_changes] = [ $self->monitor->scan ]
    }

; sub add_files
    { my ($self,$basepath,$files) = @_
    ; foreach my $file ( @$files )
        { my $path = Path::Tiny::path($basepath)->child($file)
        ; $self->monitor->watch($path->absolute)
        }
    ; $self->monitor->scan
    }

; sub add_script
    { my ($self,$commands) = @_
    ; $self->[&_script] = $commands
    }

; sub run_script
    { my ($self) = @_
    ; foreach my $line ( $self->script )
        { my $command = $self->integration->resolve_command($line->[0])
        ; my $cmd = System::Command->new
            ( ($command, $line->[1]), { interactive => 1 })
        ; if( $cmd->exit != 0)
            { warn $command
            }
        }
    }
   
; sub DESTROY
    { $_[0]->[&_integration] = undef
    }

; 1

__END__
 
