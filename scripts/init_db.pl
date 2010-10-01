use strict;
use warnings;

use File::Basename qw/ dirname /;
my $base_dir;
BEGIN { $base_dir = dirname __FILE__ }

use lib "$base_dir/../lib";
use local::lib "$base_dir/../extlib";


use Ark::Paste::Models;
models('Skinny')->do( q{
    CREATE TABLE entries (
        id         INTEGER PRIMARY KEY,
        title      TEXT,
        content    TEXT,
        language   TEXT,
        uuid       TEXT,
        created_at TEXT,
        updated_at TEXT
    )
} );
