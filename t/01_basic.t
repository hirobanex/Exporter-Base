use strict;
use warnings;
use Test::More;
use lib 't/lib';
use Calc::Addition;

my $c = Calc::Addition->new;

can_ok($c,'args');
can_ok($c,'args_pos');

$c->input(5,4);

is $c->output,9;

done_testing;

