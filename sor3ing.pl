#!/usr/bin/env perl
use strict;
use warnings;
use List::MoreUtils qw(first_index last_index);

our @a = (3,1,2,3,2,1,2);
our $n = 0; # number of exchanges

sub xchg {
  my ($i, $j) = @_;
  print "@a ($i, $j)\n";
  ($a[$i], $a[$j]) = ($a[$j], $a[$i]); 
  ++$n;
}
# Get last position of 1 in (p, q)
sub last {
  my ($p, $q) = @_;
  ++$p; --$q;
  my $j = last_index { $_ eq 1 } @a[$p..$q]; # utf-8 is that?
  if ($j != -1) {
    $j += $p;
  }
  return $j;
}
# Get first position of 3 in (p, q)
sub first {
  my ($p, $q) = @_;
  ++$p; --$q;
  my $j = first_index { $_ eq 3 } @a[$p..$q];
  if ($j != -1) {
    $j += $p;
  }
  return $j;
}
my $p = -1;
my $q = scalar @a;

while (++$p < --$q) {
  # eat 1's
  while ($a[$p] == 1) {
    if (++$p == scalar @a) { goto spit; }
  }
  # eat 3's
  while ($a[$q] == 3) {
    if (--$q == -1) { goto spit; }
  }
  if ($a[$p] == 3) {
    if ($a[$q] == 2) { # 3..1..2
      my $k = &last($p, $q);
      if ($k != -1) {
        xchg($k, $q);
      }
    }
  } else {
    if ($a[$q] == 1) { # 2..3..1
      my $m = &first($p, $q);
      if ($m != -1) {
        xchg($p, $m);
      }
    } else { # 2..3..1..2
      my $k = &last($p, $q);
      my $m = &first($p, $q);
      if (($k & $m) == -1) { goto spit; }
      if ($k != -1) { xchg($p, $k); }
      if ($m != -1) { xchg($m, $q); }
      next; # continue
    }
  }
  xchg($p, $q);
}
spit: print "@a\nNumber of exchanges: $n\n";

#log:
