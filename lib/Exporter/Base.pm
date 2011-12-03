package Exporter::Base;
use strict;
use warnings;
use utf8;
use Sub::Identify;

our $VERSION = '0.01';

sub import {
    my ($class,$name) = @_;
    my $caller = caller(0);

    if($class eq __PACKAGE__ && ($name||'') eq '-import'){
        no strict 'refs';
        *{"${caller}::import"} = \&import;
        return;
    }

    my $parent = $class;
    my $child  = $caller;

    if ( ($name||'') =~ /^-base/ ) {
        no strict 'refs';

        if ( ! $child->isa($parent) ) {
            push @{"$child\::ISA"}, $parent;
        }

        for my $func (sort keys %{"${parent}::"}) {
            next if $func =~ /^(?:BEGIN|CHECK|END)$/;
            next if $func =~ /^_/;
            my $code = *{"${parent}::${func}"}{CODE};
            next unless $code;
            next if $parent eq Sub::Identify::stash_name($code);
            next if __PACKAGE__ eq Sub::Identify::stash_name($code);

            *{"$child\::$func"} = $code;
        }

        strict->import;
        warnings->import;
        utf8->import;
    }
}

1;
__END__

=head1 NAME

Exporter::Base - inheritance and export

=head1 SYNOPSIS

  # your parent class
  package Hoge;
  use strict;
  use warnings;
  use utf8;
  use Exporter::Base qw/-import/;
  use Smart::Args;

  sub new { bless +{}, +shift }

  sub name {
    print 'hoge';
  }

  # your child class
  package Hoge::A;
  use Hoge qw/-base/;

  sub get {
    args my $self, #use can use Smart::Args function 'args', unless you declare 'use Smart::Args' in Hoge::A;
         my $foo,
         my $bar;
  }

 #your main script
 #!/usr/bin/perl
 use Hoge::A;
 
 my $hoge = Hoge::A->new;

 $hoge->name;#Hoge::A isa Hoge.

=head1 DESCRIPTION

Exporter::Base is support easily inheritance and export. For inheritance, you generally use parent. At your child class, you can't use exported functions in parenet class.If you declare 'use Exporter::Base qw/-import/' in your parent class, you can use exported functions in parenet class that is like List::Util's 'shuffle', Smart::Args's 'args', Try::Tiny's 'try''catch',and so on.

=head1 AUTHOR

hirobanex E<lt>hirobanex _at_ gmail _dot_ comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
