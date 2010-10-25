package Ark::Paste::Controller::Chained;
use Ark 'Controller::Form';
use Ark::Paste::Models;


# /entrylist
sub list :Chained('/') :PathPart('entrylist') :Args(0)
{
    my ($self, $c) = @_;
    my $list = models('API::Entry')->get_date_list;

    $c->stash->{list} = [ map { $_->date } $list->all ];
}


# /entrylist/${date}
sub entrylist :Chained('/') :PathPart('entrylist') :Args(1)
{
    my ($self, $c, $args) = @_;

    $c->detach('/default') unless $args =~ /^\d{8}$/;

    my $date = models('API::DateUtil')->from_date($args, '');
    my $list = models('API::Entry')->get_entries($date);

    $c->stash->{list} = [ map { $_->get_columns } $list->all ];
    $c->stash->{date} = $date;
}


# /entry/{$uuid}
sub entry :Chained('/') :PathPart :Args(1)
{
    my ($self, $c, $uuid) = @_;
    my $entry = models('API::Entry')->find($uuid);

    $c->detach('/default') unless $entry;

    $c->stash->{entry} = {
        uuid       => $uuid,
        title      => $entry->title,
        language   => $entry->language,
        content    => $entry->content,
        created_at => $entry->created_at,
    };
}


# /edit/{$uuid}
sub edit :Chained('/') :PathPart :Args(1) :Form('Ark::Paste::Form::Entry')
{
    my ($self, $c, $uuid) = @_;
    my $entry = models('API::Entry')->find($uuid);

    $c->detach('/default') unless $entry;

    if ($c->req->method eq 'POST' && $self->form->submitted_and_valid) {
        my $entry = models('API::Entry')->update($entry, $self->form->params);

        $c->redirect_and_detach( $c->uri_for('entry', $uuid) );
    }

    $self->form->fill( {
        title      => $entry->title,
        language   => $entry->language,
        content    => $entry->content,
    } );

    $c->stash->{entry} = {
        uuid       => $uuid,
        title      => $entry->title,
        created_at => $entry->created_at,
    };
}


1;
