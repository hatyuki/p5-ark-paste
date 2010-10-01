package Ark::Paste::API::Entry;
use Any::Moose;

has skinny => (
    is       => 'rw',
    isa      => 'Ark::Paste::API::Skinny',
    required => 1,
    lazy     => 1,
    builder  => '_build_skinny',
);

sub _build_skinny
{
    Any::Moose::load_class('Ark::Paste::Models');
    Ark::Paste::Models->get('Skinny');
}

no Any::Moose;


sub get_date_list
{
    my $self = shift;
    my $attr = {
        select   => ['DISTINCT substr(created_at, 1, 10) AS date'],
        order_by => [ { date => 'desc' } ],
    };

    return $self->skinny->search(entries => undef, $attr);
}


sub get_entries
{
    my ($self, $date) = @_;

    my $cond = { 'substr(created_at, 1, 10)' => $date->ymd('/') };
    my $attr = {
        select   => [qw/ title language uuid created_at updated_at /],
        order_by => [ { created_at => 'desc' } ],
    };

    return $self->skinny->search(entries => $cond, $attr);
}


sub find
{
    my ($self, $uuid) = @_;
    return $self->skinny->single(entries => { uuid => $uuid });
}


sub create
{
    my ($self, $args) = @_;
    return $self->skinny->create(entries => $args);
}


__PACKAGE__->meta->make_immutable;
