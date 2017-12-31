use v6;

use NativeCall;

unit package POSIX::time_h;

constant darwin_time_t is export = uint64;
constant timespec is export = do given ($*KERNEL) {
  when 'darwin' {
    class :: is repr('CStruct') {
      has darwin_time_t $.tv_sec;
      has long $.tv_nsec;

      submethod TWEAK {
        $!tv_sec = 0;
        $!tv_nsec = 0;
      }
    }
  };

  default {
    class :: is repr('CStruct') {
      has long $.tv_sec;
      has long $.tv_nsec;

      submethod TWEAK {
        $!tv_sec = 0;
        $!tv_nsec = 0;
      }
    }
  };
};
