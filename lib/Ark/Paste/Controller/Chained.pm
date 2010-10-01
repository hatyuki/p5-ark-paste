package Ark::Paste::Controller::Chained;
use Ark 'Controller';
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

    $c->stash->{entry} = {
        title      => $entry->title,
        language   => $entry->language,
        content    => $entry->content,
        created_at => $entry->created_at,
    };
}


1;
