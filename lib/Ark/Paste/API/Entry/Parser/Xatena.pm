package Ark::Paste::API::Entry::Parser::Xatena;
use strict;
use warnings;
use Text::Xatena;

sub parse
{
    my ($klass, $language, $content) = @_;
    my $parser = Text::Xatena->new;
    my $inline = Text::Xatena::Inline->new;
    my $format = $parser->format($content, inline => $inline);
    my $retval = qq{<div class="$language">\n};

    $retval .= "$format\n";

    $retval .= qq{<div class="notes">\n};
    for my $footnote (@{ $inline->footnotes }) {
        $retval .= sprintf qq{<p class="footnote" id="#fn%d">*%d: %s</p>\n},
            $footnote->{number}, $footnote->{number}, $footnote->{note};
    }
    $retval .= qq{</div>\n};  ## footnote
    $retval .= qq{</div>\n};  ## xatena

    return $retval;
}

1;
