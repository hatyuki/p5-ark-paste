package Ark::Paste::Models;
use Ark::Models -base;


register Skinny => sub {
    my $self   = shift;
    my $config = $self->get('conf')->{database};

    $self->ensure_class_loaded('Ark::Paste::API::Skinny');

    Ark::Paste::API::Skinny->new($config);
};

register 'Entry::Parser' => sub {
    my $self = shift;

    $self->ensure_class_loaded('Ark::Paste::API::Entry::Parser');
    'Ark::Paste::API::Entry::Parser';
};

register_namespaces API => 'Ark::Paste::API';


1;
