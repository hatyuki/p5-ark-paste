use inc::Module::Install;
name 'Ark-Paste';
all_from 'lib/Ark/Paste.pm';

requires 'Ark';

tests 't/*.t';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
