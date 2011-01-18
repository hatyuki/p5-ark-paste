package Ark::Paste::API::Entry::Parser;
use strict;
use warnings;
use feature qw/ switch /;
use Module::Load ( );

sub parse
{
    my ($klass, $language, $content) = @_;
    my $type;

    given ($language) {
        when ('xatena') { $type = 'Xatena' }
        default         { $type = 'Default' }
    }

    my $class = join '::', 'Ark', 'Paste', 'API', 'Entry', 'Parser', $type;
    Module::Load::load($class);

    return $class->parse($language, $content);
}

1;
