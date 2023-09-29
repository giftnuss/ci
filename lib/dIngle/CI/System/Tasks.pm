  package dIngle::CI::System::Tasks;
# **********************************
  our $VERSION = '0.01';
# **********************

; use dIngle::Hive::API qw(task)
; use dIngle::Tasks::Perform qw(make take run)

; use Carp()
; use Ref::Util()

; sub setup
{
; task("Loop endless")
    ->require(sub
        { Ref::Util::is_plain_arrayref($_[1])
        })
    ->perform(sub
        { my ($context,$steps) = @_
        ; my @steps = make("Prepare steps",$context,$steps)
        ; local $_
        ; while(1) { $_->() for @steps }
        })
    
; task("Prepare steps", sub
    { my ($context,$steps) = @_
    ; my (@steps)

    ; foreach my $idx (0..@$steps-1)
        { my $step = $steps->[$idx]
        ; if(Ref::Util::is_ref($step))
            { if(Ref::Util::is_plain_arrayref($step))
                { my $code = Ref::Util::is_ref($step->[0]) ? "task" : "name"
                ; $steps[$idx] = make("Prepare step from $code",$context,@$step)
                }
              else
                { $steps[$idx] = make("Prepare step from task",$context,$step)
                }
            }
          else
            { $steps[$idx] = make("Prepare step from name",$context,$step)
            }
        }
    ; @steps
    })

; task("Prepare step from name")
    ->require(sub
        { !Ref::Util::is_ref($_[1]) && length($_[1])
        })
    ->perform(sub
        { my ($context,$name,@args) = @_
        ; my $task = take($name,$context)
        ; unless($task)
            { Carp::croak("Can not prepare step - task '$name' is unknown.")
            }
        ; sub { run($task,$context,@args) }
        })
 
; task("Prepare step from task")
    ->require(sub
        { Ref::Util::is_blessed_ref($_[1])
            && $_[1]->isa('dIngle::Tasks::Task')
        })
    ->perform(sub
        { my ($context,$task,@args) = @_
        ; sub { run($task,$context,@args) }
        })

} # end setup

; 1

__END__

