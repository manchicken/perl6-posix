use v6;

use NativeCall;
use POSIX::time_h;
use POSIX::types_h;
use POSIX::errno;
use POSIX::passwd;

unit package POSIX::stat;

class stat_t is export is repr('CStruct') {
  has dev_t $.st_dev; # device inode resides on
  has ino_t $.st_ino; # inode's number
  has mode_t $.st_mode; # inode protection mode
  has nlink_t $.st_nlink; # number of hard links to the file
  has uid_t $.st_uid; # user-id of owner
  has gid_t $.st_gid; # group-id of owner
  has dev_t $.st_rdev; # device type, for special file inode
  has off_t $.st_size; # file size, in bytes
  HAS timespec $.st_atimespec; # time of last access
  HAS timespec $.st_mtimespec; # time of last data modification
  HAS timespec $.st_ctimespec; # time of last file status change
  has blksize_t $.st_blksize;# optimal file sys I/O ops blocksize
  has blkcnt_t $.st_blocks; # blocks allocated for file

  submethod TWEAK {
    $!st_dev = 0;
    $!st_ino = 0;
    $!st_mode = 0;
    $!st_nlink = 0;
    $!st_uid = 0;
    $!st_gid = 0;
    $!st_rdev = 0;
    $!st_size = 0;
    $!st_blksize = 0;
    $!st_blocks = 0;
  }
}

sub _stat( Str, stat_t is rw --> int32 ) is native is symbol('stat') { * };
#| The stat implementation here allocates your memory and returns it for you.
sub stat( Str $path --> stat_t ) is export {
  my $output = stat_t.new();
  return $output if (!_stat($path, $output));

  return -1;
}
