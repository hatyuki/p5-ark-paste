package Ark::Paste;
use Ark;
use Text::Xslate qw/ html_builder /;

our $VERSION = '0.004';


use_model 'Ark::Paste::Models';

my $home = Ark::Paste::Models->get('home');
my $conf = Ark::Paste::Models->get('conf');

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
            parse_content => html_builder {
                my $args   = shift;
                my $parser = Ark::Paste::Models->get('Entry::Parser');

                return $parser->parse($args->{language}, $args->{content});
            },
        },
        module => ['String::CamelCase' => [qw/ camelize /]],
        %{ $conf->{Xslate} || +{ } },
    },
};


1;
