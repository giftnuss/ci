

__DIR__=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

export DINGLE_BASE_PATH=$(cd $__DIR__/../clean && pwd)
export DINGLE_CONFIG_PATH=$__DIR__/config

export PERL5LIB=$DINGLE_BASE_PATH/vendor/lib/perl5
PERL5LIB=$DINGLE_BASE_PATH/lib:$PERL5LIB
export DINGLE_DEV_START=$(date)
