package P;
use strict;
use warnings;

use Data::Dumper ( );


sub import
{
    my $caller = caller;
    my @funcs  = qw/ p pp /;

    no strict 'refs';

    for my $func (@funcs) {
        *{"$caller\::$func"} = \&$func;
    }
}


sub pp
{
    print STDERR p(@_), "\n";
}


sub p
{
    my $args = scalar @_ == 1 ? shift : \@_;

    local $Data::Dumper::Terse  = 1;

    my $msg = Data::Dumper::Dumper($args);
    $msg =~ s/\x0D?\x0A?$//g;

    return $msg;
}

1;
