use Plack::Builder;
use Ark::Paste;


my $app = Ark::Paste->new;
$app->setup;


builder {
    enable 'Plack::Middleware::Static',
        path => qr{^/static/},
        root => $app->path_to('root')->stringify;

    $app->handler;
};
