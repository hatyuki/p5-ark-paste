my $home = Ark::Paste::Models->get('home');

return +{
    database => {
        dsn      => 'dbi:SQLite:'.$home->file('ark-paste.db'),
        username => '',
        password => '',
    },
};
