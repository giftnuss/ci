  package dIngle::CI::Monitor;
# ****************************
  our $VERSION = '0.01';
# **********************
; use strict; use warnings; use utf8

; use File::Monitor()

; use HO::class
   _ro => integration => '$',
   _rw => files => '%',
   _ro => monitor => sub { new File::Monitor:: },
   init => 'hash'
   
; sub DESTROY
    { $_[0]->[&_integration] = undef
    }

; 1

__END__
 
