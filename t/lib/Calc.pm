package Calc;
use strict;
use warnings;
use utf8;
use Smart::Args;
use Exporter::Base qw/-import/;

sub new {bless +{ _result => '' }, +shift }

sub input {
    args_pos my $self,
             my $inp_a => 'Int',
             my $inp_b => 'Int';


    $self->calc($inp_a,$inp_b);
}

sub calc {
    die 'you must be override this mothod';
}

sub output { $_[0]->{_result} }

1;
