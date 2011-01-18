use File::Spec;
use lib 'lib', File::Spec->catdir(qw/extlib lib perl5/);
use Plack::Builder;
use Ark::Paste;


my $app = Ark::Paste->new;
$app->setup;

builder {
    enable 'ReverseProxy';
    enable AccessLog => format => 'combined';
    mount '/ark-paste' => builder { $app->handler };
};
