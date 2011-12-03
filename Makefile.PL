use inc::Module::Install;
name 'Exporter-Base';
all_from 'lib/Exporter/Base.pm';

requires 'Sub::Identify;';

test_requires 'Test::More' => '0.94';
test_requires 'Smart::Args';

tests 't/*.t';
author_tests 'xt';

auto_set_repository;
auto_include;
WriteAll;
