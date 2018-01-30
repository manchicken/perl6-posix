#!/usr/bin/env perl6
#Note `zef build .` will run this script
use v6.c;

class ConstantWriter {
  has @.headers;
  has @.constants;

  method make-include-chunk {@!headers.map:{qq«#include <$^a>\n»}}
  method make-constants-output {@!constants.map:{qq«#ifdef $^a\n  fprintf(outfile, "$^a=\%d;\\n", $^a);\n#else\n  fprintf(outfile, "$^a=0;\\n");\n#endif\n»}}

  method generate-library(:$package, :$outfile) {
    given $outfile.IO.open: :w {
      .print: qq«#include <stdio.h>\n»;
      .print: self.make-include-chunk;
      .print: qq«int main() \{\n»;
      .print: qq«  FILE *outfile = fopen("constants.pm", "w");\n»;
      .print: qq«  fprintf(outfile, "use v6;\\nunit package $package;\\n\\n");\n»;
      .print: self.make-constants-output;
      .print: qq«  fclose(outfile);\n»;
      .print: qq«  return 0;\n»;
      .print: '}';
    }
  }
}

class Build {
  need LibraryMake;

  method build($me :$workdir) {
    say 'HERE';
    my $cw = ConstantWriter.new(
      headers => <errno.h>,
      constants => <E2BIG EACCES EADDRINUSE EADDRNOTAVAIL EAFNOSUPPORT EAGAIN EALREADY EBADF EBADMSG>
       # EBUSY ECANCELED ECHILD ECONNABORTED ECONNREFUSED ECONNRESET EDEADLK EDESTADDRREQ EDOM EDQUOT EEXIST EFAULT EFBIG EHOSTDOWN EHOSTUNREACH EIDRM EILSEQ EINPROGRESS EINTR EINVAL EIO EISCONN EISDIR ELOOP EMFILE EMLINK EMSGSIZE ENAMETOOLONG ENETDOWN ENETRESET ENETUNREACH ENFILE ENOBUFS ENODATA ENODEV ENOENT ENOEXEC ENOLCK ENOLINK ENOMEM ENOMSG ENOPROTOOPT ENOSPC ENOSR ENOSTR ENOSYS ENOTBLK ENOTCONN ENOTDIR ENOTEMPTY ENOTRECOVERABLE ENOTSOCK ENOTSUP ENOTTY ENXIO EOPNOTSUPP EOTHER EOVERFLOW EOWNERDEAD EPERM EPFNOSUPPORT EPIPE EPROCLIM EPROTO EPROTONOSUPPORT EPROTOTYPE ERANGE EREMOTE ERESTART EROFS ESHUTDOWN ESOCKTNOSUPPORT ESPIPE ESRCH ESTALE ETIME ETIMEDOUT ETOOMANYREFS ETXTBSY EUSERS EWOULDBLOCK EXDEV>
    );
    $cw.generate-library(outfile => 'src/make-constants.c', package => 'POSIX::constants');

    for <
      resources/bin make-constants
    > -> $dir, $obj {
      make(folder=>$workdir, destfolder=>$dir, outname=>$obj);
    }
  }

  sub make(:$folder, :$destfolder, :$outname) {
      my %vars = LibraryMake::get-vars($destfolder);
      "VARS: ".say;
      %vars.perl.say;

      mkdir($destfolder);
      LibraryMake::process-makefile($folder, %vars);
      shell(%vars<MAKE>);
  }
}

# Build.pm can also be run standalone
sub MAIN(Str $working-directory = '.' ) {
  Build.new.build(workdir => $working-directory);
}
