#!/usr/bin/perl



while ( $ARGV = shift ) {

$fileIn  = "$ARGV";
$fileOut = "$ARGV.x";

open ( IN,  $fileIn  );
open ( OUT, ">$fileOut" );


while ( <IN> ) {

print OUT;
if ( /\\\\(\s*)$/ ) {  
print OUT<<EXTRA;
\\cline{1-7}
    \\xme     &\\xme     &\\xme     &\\xme     &\\xme     &\\xme    & \\\\
\\hline
EXTRA
}  # end if

} #end while


close (IN);
close (OUT);

`mv $fileOut $fileIn`;


} #end while
