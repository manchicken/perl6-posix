#!/usr/bin/env perl6
#Note `zef build .` will run this script
use v6.c;

use LibraryMake;

class Build {
  method build($workdir) {
    process-makefile($workdir, {});
  }
}

# Build.pm can also be run standalone
sub MAIN(Str $working-directory = '.' ) {
  Build.new.build($working-directory);
}
