package Ark::View::Tiffany;
use Ark 'View';
use Tiffany;

has view => (
    is      => 'rw',
    isa     => 'Str',
    lazy    => 1,
    default => 'Text::MicroTemplate::Extended',
);

has extension => (
    is      => 'rw',
    isa     => 'Str',
    lazy    => 1,
    default => '',
);

has options => (
    is      => 'rw',
    isa     => 'HashRef',
    lazy    => 1,
    default => sub { +{ } },
);

has tiffany => (
    is      => 'rw',
    isa     => 'Object',
    lazy    => 1,
    default => sub { Tiffany->load($_[0]->view, $_[0]->options) },
);

sub template
{
    my ($self, $template) = @_;
    $self->context->stash->{__view_tiffany_template} = $template;

    return $self;
}

sub render
{
    my $self     = shift;
    my $template = shift;
    my $context  = $self->context;

    $template ||= $self->context->stash->{__view_tiffany_template}
              ||  $self->context->request->action->reverse
              ||  return;

    return $self->tiffany->render(
        $template.$self->extension,
        {
            %{ $context->stash },
            c => $context,
            @_,
        }
    );
}

sub process
{
    # my ($self, $c) = @_;
    # $c->response->body( $self->render );

    $_[1]->response->body( $_[0]->render );
}

__PACKAGE__->meta->make_immutable;
