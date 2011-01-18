package Ark::Paste::API::Entry::Parser::Xatena;
use strict;
use warnings;
use Text::Xatena;

sub parse
{
    my ($klass, $language, $content) = @_;
    my $parser = Text::Xatena->new;
    my $format = $parser->format($content);

    return qq{<div class="$language">$format</div>};
}

1;
