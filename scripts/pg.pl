use strict;
use warnings;

use File::Basename qw/ dirname /;
my $base_dir;
BEGIN { $base_dir = dirname __FILE__ }

use lib "$base_dir/../lib";
use local::lib "$base_dir/../extlib";


use Ark::Paste::Models;
my $skinny = models('Skinny');

$skinny->do( q{
    CREATE TABLE entries (
        id         SERIAL PRIMARY KEY,
        title      TEXT,
        content    TEXT,
        language   TEXT,
        uuid       TEXT,
        created_at TEXT,
        updated_at TEXT
    )
} );

$skinny->do( q{ CREATE INDEX index_entries_on_language ON entries(language) } );
$skinny->do( q{ CREATE INDEX index_entries_on_uuid ON entries(uuid) } );
