  package dIngle::CI::Integration;
# ********************************
  our $VERSION = '0.011';
# **********************

; use strict; use warnings; use utf8
; use Carp ()
; use Path::Tiny ()
; use Feature::Compat::Try 0.05

; use dIngle::CI::Monitor

; use subs 'init'

; use HO::mixin 'dIngle::CI::Commands'

; use HO::class
    _ro => name => '$',
    _ro => project => '$',
    _rw => basepath => sub { Path::Tiny::path('.') },
    _ro => monitors => '@',
    _rw => starttask => sub { 'CI run integration' }

; sub init
    { my ($self,%args) = @_
    ; foreach my $attr (qw(name project))
        { my $param = delete $args{$attr}
        ; unless($param)       
            { Carp::croak("New integration needs argument '$attr'.")
            }
        ; my $acc = "_$attr"
        ; $self->[$self->$acc] = $param
        }
    ; $self
    }

; sub DESTROY 
    { $_[0]->project(undef)
    }

; sub setup
    { my ($self,$config) = @_
    ; if(exists $config->{'commands'})
        { $self->_setup_commands($config->{'commands'})
        }
    ; $self->basepath(Path::Tiny::path($config->{'basepath'}))
       if exists $config->{'basepath'}

    ; $self->starttask($config->{'starttask'})
       if exists $config->{'starttask'}

    ; if(exists $config->{'monitor'})
        { my $monitors = $config->{'monitor'}
        ; $monitors = [ $monitors ] 
            unless Ref::Util::is_plain_arrayref( $monitors )
            
        ; foreach my $monitor ( @$monitors )
            { $self->add_monitor($monitor)
            }
        }
    }
    
; sub add_monitor
    { my ($self,$config) = @_
    ; my $monitor = new dIngle::CI::Monitor(integration => $self)

    ; if( exists $config->{'file'} )
        { my $files = $config->{'file'}
        ; $files = [ $files ]
            unless Ref::Util::is_plain_arrayref( $files )
        ; $monitor->add_files($self->basepath,$files)
        }
      else
        { Carp::croak("A monitor needs at least one file to monitor.")
        }

    ; if( exists $config->{'run'} )
        { my @commands
        ; foreach my $linenum (sort keys %{$config->{'run'}})
            { my $line = $config->{'run'}->{$linenum}
            ; my $split = index( $line, " ") 
            ; if( $split == -1 )
                { push @commands, [ $line , "" ]
                }
              else
                { push @commands, 
                    [ substr( $line, 0, $split )
                    , substr( $line, $split+1 )
                    ]
                }
            }
        ; $monitor->add_script(\@commands)
        }

    ; push @{$self->[&_monitors]}, $monitor
    }

; sub run
    { my ($self) = @_
    ; $self->run_monitors
    }
    
; sub run_monitors
    { my ($self) = @_
    ; foreach my $monitor ($self->monitors)
        { $monitor->check
        ; if( $monitor->changes )
            { foreach my $change ($monitor->changes) 
                { warn $change->name, " has changed.";
                }
            ; $monitor->run_script
            }
        }
    }
    
; sub resolve_command
    { my ($self,$name) = @_
    ; try
       { return $self->get_commandline($name)
       }
      catch($e)
       { return $self->project->get_commandline($name)
       }
    }

; 1

__END__

