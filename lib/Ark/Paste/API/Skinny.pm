package Ark::Paste::API::Skinny;
use DBIx::Skinny;


{
    package Ark::Paste::API::Skinny::Schema;
    use DBIx::Skinny::Schema;

    use Ark::Paste::API::DateUtil qw/ DateUtil /;
    use Data::UUID;

    my $uuid = Data::UUID->new;


    install_table entries => schema {
        pk 'id';
        columns qw/ id title content language uuid created_at updated_at /;

        trigger pre_insert => sub {
            my ($class, $args)  = @_;

            $args->{uuid}       = $uuid->create_str;
            $args->{created_at} = DateUtil->datetime;
            $args->{updated_at} = DateUtil->datetime;
        };

        trigger pre_update => sub {
            my ($class, $args)  = @_;

            $args->{updated_at} = DateUtil->datetime;
        };

        install_inflate_rule '^.*_at$' => callback {
            inflate { DateUtil->from_datetime($_[0]) };
        };

        install_inflate_rule '^date$' => callback {
            inflate { DateUtil->from_date($_[0]) };
        };
    };
}


1;
