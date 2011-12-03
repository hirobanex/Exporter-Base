package Calc::Addition;
use Calc qw/-base/;

sub calc {
    args_pos my $self,
             my $inp_a => 'Int',
             my $inp_b => 'Int';

    $self->{_result} = $inp_a + $inp_b;
}
1;
