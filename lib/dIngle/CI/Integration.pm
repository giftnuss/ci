  package dIngle::CI::Integration;
# ********************************
  our $VERSION = '0.01';
# **********************

; use strict; use warnings; use utf8
; use Carp ()
; use Path::Tiny ()

; use dIngle::CI::Monitor

; use subs 'init'

; use HO::mixin 'dIngle::CI::Commands'

; use HO::class
    _ro => name => '$',
    _ro => project => '$',
    _rw => basepath => sub { Path::Tiny::path('.') },
    _ro => monitor => [ '$', 
        sub { dIngle::CI::Monitor->new(integration => $_[0]) }],
    _rw => starttask => sub { 'Run integration' }

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
        { foreach my $filename (keys %{$config->{'monitor'}})
            {
            }
        }
    }
    
; 1

__END__

