use v6;

use POSIX::passwd;
use POSIX::time_h;
use POSIX::types_h;
use POSIX::errno;
use POSIX::stat;

# my %export-matrix = <getuid>.map({ $^a => &POSIX::passwd::{$^a} });
# %export-matrix.perl.say;

sub EXPORT {
  Map.new: (
    | POSIX::passwd::EXPORT::DEFAULT::,
    | POSIX::time_h::EXPORT::DEFAULT::,
    | POSIX::errno::EXPORT::DEFAULT::,
    | POSIX::stat::EXPORT::DEFAULT::,
  )
}
