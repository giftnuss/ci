; use lib 'lib/'
; use strict; use warnings

; use Path::Tiny()

; BEGIN 
    { $ENV{'DINGLE_CONFIG_PATH'} = 
              Path::Tiny::path(__FILE__)->parent->child('config').""
    }

; use dIngle::CI::Library

; use Test2::V0 qw(diag ok done_testing)

; BEGIN
   { diag("Basepath " . dIngle::Light->basepath)
   ; diag("Configpath " . dIngle::Light->configpath)
   }

; use dIngle::CI::Project
; use dIngle::CI::Runner
; use dIngle::CI::Runner::Tasks

; ok(1)
; done_testing

; END
    { #print join(" ",@$_),"\n" for dIngle::Library->get_library
    }

