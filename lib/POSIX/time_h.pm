use v6;

use NativeCall;

unit package POSIX::time_h;

our constant darwin_time_t is export(:DEFAULT) = uint64;
