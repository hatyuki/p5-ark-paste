use File::Spec;
use File::Basename;
use local::lib File::Spec->catdir(dirname(__FILE__), 'extlib');
use lib File::Spec->catdir(dirname(__FILE__), 'lib');
use Plack::Builder;
use Ark::Paste;


my $app = Ark::Paste->new;
$app->setup;

builder {
    enable 'ReverseProxy';
    enable AccessLog => format => 'combined';
    enable 'Deflater';
    mount '/ark-paste' => builder { $app->handler };
};
