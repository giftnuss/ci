  package dIngle::CI::Library;
# ****************************
  our $VERSION = '0.01';
# **********************

; use Sub::Uplevel

; use dIngle::Library 
    ( { # use the sitelib of dingle installation
        configpath => Path::Tiny::path(dIngle::Light->basepath)
            ->child('config')
      }
 #   , { # use the project site-lib
 #       basepath => Path::Tiny::path(__FILE__)->parent->parent
 #     }
    )

; 1

__END__


  
