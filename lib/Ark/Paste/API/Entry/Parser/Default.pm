package Ark::Paste::API::Entry::Parser::Default;
use strict;
use warnings;

## nop
sub parse {
    my ($klass, $language, $content) = @_;
    return qq{<pre class="brush: $language">$content</pre>};
} 

1;
