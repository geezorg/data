#!/usr/bin/perl



@bigArray;
$#bigArray = 400;
@Cols;

main:
{
$col = $row = $elements = $rowBase = 0;

while (<>) {

	if ( /G}/ ) {
		$elements++;
		@verbs = split ( /&/ );
		# print "$elements \[$row+$rowBase,$col\] $verbs[0]\n";
		$bigArray[$rowBase + $row++][$col] = &RelativeClass3 ( $verbs[0], $verbs[3] );

		$row %= 14;
		if ( !$row ) {
		  $col++;
		  $col %= 6;
		  $Cols[$rowBase/14] = 6;
		  $rowBase += 14 if ( !$col );  # new table
		}
	}

}
$Cols[$rowBase/14] = $col + 1;
$count = $cycle = 0;
PRINT:
$col = $Cols[$cycle/14];
# print "%  $cycle : $col\n";
print "\n\n\\newpage\n\n" if ( $count );

print "\\noi
\\subsection*{Class 9 Verbs}
\\hspace*{-1.50in}
\\begin{tabular}{|*{$col}{\@{}c\@{}|}} \\hline\n\n";

for ($i=0; ($i<14 && $count<$elements); $i++) {
	# print "%  $i: $count < $elements\n";
	for ( $j=0; $j<$col; $j++ ) {
		print "$bigArray[$i + $cycle][$j] ";
		print "& "       if ( $j < $col-1 );
	}
	print "\\\\\n";
	print "\\hline\n";
	for ( $j=0; ($j<$col && $j*14+$i < $elements); $j++ ) {
		print "\\xme     ";
		print "&" if ( $j < $col-1 );
		$count++;
	}
	print "\\\\\n";
	print "\\hline\n";


} # end for
print "\\end{tabular}\n";
# print "\n% $count < $elements  |  $col \n\n";
$cycle += 14;
goto PRINT if ($count < $elements);
}



#
#  The Class 7 relative forms are: 
#
#  A: (1a)(2e)  =>  yemi(1a)(2)
sub RelativeClass3
{
local ( $simple  ) = shift;
local ( $jussive ) = shift;


	@letters = ( $jussive =~ "G" )
	         ? split ( /{/, $jussive )
	         : split ( /{/, $simple )
	         ;
	shift ( @letters );
	local ( $numLetters ) = $#letters;
	return ( RelativeClass1 ( $simple, $jussive) ) if ($numLetters > 3);
	for ($i=0; $i<=$numLetters; $i++) {
		$letters[$i] = "{$letters[$i]";
	}
	if ( $letters[0] =~ "yaG" ) {	  # special for ya
		$letters[0] =  "{\\miG}{\\yaG}";
		$letters[1] =~ s/(\w)G/$1eG/ if ( $letters[1] !~ "aG" );
	} else {
		$letters[0] =~ s/yG/miG/;
	}
	$relative = "{\\yeG}".join ("",@letters);

}



#
#  The Class 1 relative forms are: 
#
#  A: (1e)(2e)(3e)  =>  yemi(1e)(2)(3)
#  B: (1e)(2e)(3e)  =>  yemi(1a)(2e)(3)        # those having 1a in the jussive
#  C: (1e)(2e)(3e)  =>  yemi(1)(2e)(3e)(2e)(3) # those that double in jussive
#  D: (1e)(2e)(3e)  =>  yemi(te)(1a)(2e)(3)    # those having te in jussive
#

sub RelativeClass1
{
local ( $simple  ) = shift;
local ( $jussive ) = shift;


	@letters = ( $jussive =~ "G" )
	         ? split ( /{/, $jussive )
	         : split ( /{/, $simple )
	         ;
	shift ( @letters );
	local ($numLetters) = $#letters;
	for ($i=0; $i<=$numLetters; $i++) {
		$letters[$i] = "{$letters[$i]";
	}
	# print "\n";


	if ( $jussive !~ "G" ) {
		#
		#  We have only the simple form, we assume Rule A
		#
		$letters[0] = "{\\miG}$letters[0]";
		$letters[1] =~ s/(\w)[euiaEo]G/$1G/;
		$letters[2] =~ s/(\w)[euiaEo]G/$1G/;

	} else {  # we are starting with the jussive


		$Rule =  0;
		$Rule = "A" if ( $numLetters == 3 );  # Assume Simple
		$Rule = "B" if ( $letters[1] =~ "aG" || $letters[0] =~ "yaG" );
		$Rule = "C" if ( $numLetters == 5 );
			  #
			  #  We should check the Rule C pattern, but just use length
			  #  for now
			  #
			  #  && $letters[2] ~~ $letter[4]
		  	  #  && $letters[3] ~~ $letter[5]
			  #
		$Rule = "D" if ( $numLetters == 4 && $letters[1] =~ "teG" );
		print STDERR "$jussive is of Rule Class 1 $Rule\n";

		# die ( "Unknown verb $jussive ($numLetters)\n" ) if ( !$Rule );


		$sads2geez = ( $Rule eq "C" ) ? 3 : ( $Rule eq "B" ) ? 2 : 1;


		#
		# Rule A
		#
		if ( $Rule eq "A" ) {
			$sads2geez = 0 if ( $letters[1] =~ /(\w)eG/ );
			$letters[2] =~ s/(\w)eG/$1G/;
		}


		#
		# Rule B
		#
		if ( $Rule eq "B" ) {
			if ( $letters[0] =~ "yaG" ) {	  # special for ya
				$letters[0] = "{\\miG}{\\yaG}";
				$sads2geez = ( $letters[1] =~ "aG" ) ? 0 : 1;
			} else {
				$sads2geez = 0 if ( $letters[2] =~ "eG" );
				$letters[0] =~ s/yG/miG/;
			}
		}
		#
		# Rule A, C, D, 0
		#
		else {  
			$letters[0] =~ s/yG/miG/;
		}


		$letters[$sads2geez] =~ s/(\w)G/$1eG/
			if ( $Rule ne "D" && $sads2geez );

	}

	$relative = "{\\yeG}".join ("",@letters);
	# print STDERR "$relative\n";
	return ($Rule) ? $relative : "$relative ?";

}
