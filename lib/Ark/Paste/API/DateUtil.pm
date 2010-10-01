package Ark::Paste::API::DateUtil;
use strict;
use warnings;

use Time::Piece ( );

sub import
{
    my ($class, $args) = @_;
    my $caller = caller;

    if ($args) {
        no strict 'refs';
        *{"$caller\::$args"} = \&new;
    }
}


sub new { __PACKAGE__ };


sub datetime
{
    Time::Piece::localtime->strftime('%Y/%m/%d %H:%M:%S');
}


sub from_datetime
{
    Time::Piece->strptime($_[1], '%Y/%m/%d %H:%M:%S');
}


sub from_date
{
    my ($class, $date, $delimiter) = @_;
    $delimiter = '/' unless defined $delimiter;

    Time::Piece->strptime($date, join $delimiter, '%Y', '%m', '%d');
}


1;
