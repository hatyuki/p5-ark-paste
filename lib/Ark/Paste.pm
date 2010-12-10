package Ark::Paste;
use Ark;
use Text::Xslate qw/ html_builder /;

our $VERSION = '0.01';


use_model 'Ark::Paste::Models';

my $home = Ark::Paste::Models->get('home');


config 'View::Tiffany' => {
    view      => 'Text::Xslate',
    extension => '.tx',
    options   => {
        path      => $home->subdir('root', 'tmpl'),
        cache_dir => $home->subdir('tmp', 'xslate_cache'),
        cache     => 2,
        function  => {
            form => sub {
                __PACKAGE__->context->stash->{form};
            },
            form_input => html_builder {
                __PACKAGE__->context->stash->{form}->input(@_);
            },
        },
        module => ['String::CamelCase' => [qw/ camelize /]],
    },
};


1;
