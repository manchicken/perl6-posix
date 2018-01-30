use v6;

use NativeCall;

unit package POSIX::types_h;

constant dev_t is export = int32;
constant ino_t is export = do given ($*KERNEL) {
  when 'darwin' { uint64; }
  default { uint32; }
}
constant nlink_t is export = uint16;
constant mode_t is export = uint16;
constant off_t is export = int64;
constant blksize_t is export = int32;
constant blkcnt_t is export = int64;
constant uid_t is export  = uint32;
constant gid_t is export = uint32;
