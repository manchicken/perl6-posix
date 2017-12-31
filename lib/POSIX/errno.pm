use v6;

use NativeCall;

unit package POSIX::errno;

#| The errno external.
our $errno is export := cglobal('libc', 'errno', int32);

# TODO - We should probably have more than just the value.
