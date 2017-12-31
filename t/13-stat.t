use v6;

use Test;
use POSIX;

plan 1;

{
  my $return = stat($?FILE);
  $return.perl.say;
  isnt($return, -1, 'Make sure that we got a stat.');
}
