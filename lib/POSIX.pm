use v6;

use POSIX::passwd;
use POSIX::time_h;

# my %export-matrix = <getuid>.map({ $^a => &POSIX::passwd::{$^a} });
# %export-matrix.perl.say;

sub EXPORT {
  Map.new: (
    | POSIX::passwd::DEFAULT::,
    | POSIX::time_h::DEFAULT::,
  )
}
