  package dIngle::CI::Runner::Tasks;
# **********************************
  our $VERSION = '0.011';
# **********************

; use dIngle::Hive::API qw(task)
; use dIngle::Tasks::Perform qw(take make)

; sub setup
{
; task("CI run all", sub
    { my ($context) = @_
    ; make("Loop endless",$context,
        [ "CI run all integrations"
        , "CI sleep"
        ])
    })
    
; task("CI run all integrations",sub
    { my ($context) = @_
    ; my $project = $context->project
    ; foreach my $integration ($project->get_integrations)
        { my $taskname = $integration->starttask
        ; make($taskname,$context,$integration)
        }
    })

; task("CI run integration", sub
    { my ($context,$integration) = @_
    
    ; $integration->run
    })
    
; task("CI sleep", sub { sleep(1) })
    
    

} # end setup

; 1

__END__

