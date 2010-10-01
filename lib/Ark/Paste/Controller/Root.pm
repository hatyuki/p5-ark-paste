package Ark::Paste::Controller::Root;
use Ark 'Controller::Form';
use Ark::Paste::Models;


has '+namespace' => default => '';


# default 404 handler
sub default :Path :Args {
    my ($self, $c) = @_;

    $c->res->status(404);
    $c->res->body('404 Not Found');
}


sub begin :Private
{
    my ($self, $c) = @_;
}


sub end :Private
{
    my ($self, $c) = @_;

    unless ($c->res->body or $c->res->status =~ /^3\d\d/) {
        $c->forward( $c->view('Tiffany') );
    }
}


sub index :Path :Args(0) :Form('Ark::Paste::Form::Entry')
{
    my ($self, $c) = @_;

    if ($c->req->method eq 'POST' && $self->form->submitted_and_valid) {
        my $entry = models('API::Entry')->create($self->form->params);

        $c->redirect_and_detach( $c->uri_for('entry', $entry->uuid) );
    }
}


1;
