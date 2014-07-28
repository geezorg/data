#!/usr/bin/perl -I../..

use LiveGeez::Local;
use LiveGeez::Request;
use LiveGeez::Services;


main:
{
my %input = ();
my $r = LiveGeez::Request->new ( 0 ); # don't parse input


	$r->ParseCookie;

	$input{sysOut}  = ( $r->{'cookie-geezsys'} )
	                ? ( $r->{'cookie-geezsys'} )
	                : "FirstTime"
	                ;
	$input{'7-bit'} = ( $r->{'cookie-7-bit'} )
	                ? ( $r->{'cookie-7-bit'} )
	                : ( $ENV{HTTP_USER_AGENT} =~ /Mac/i )
	                  ? "true"
	                  : "false"
	                ;

	$input{file}  = "Literature/MinelikII/index.sera.html";

	$r->ParseQuery ( \%input );
	undef ( %input );

	ProcessRequest ( $r ) || $r->DieCgi ( "Unrecognized Request." );

	exit (0);

}


__END__


=head1 NAME

ENH/Tobia Zobel -- Remote Processing of Ethiopic Web Pages

=head1 SYNOPSIS

http://www.xyz.com/G.pl?sys=MyFont&file=http://www.zyx.com/dir/file.html

or

% G.pl sys=MyFont file=http://www.zyx.com/dir/file.html

=head1 DESCRIPTION

G.pl is the ENH & Tobia front version of the Zobel default "Z.pl" script.
Requires the ENH.pm module found in the same directory G.pl is distributed
in.

=head1 AUTHOR

Daniel Yacob,  L<LibEth@EthiopiaOnline.Net|mailto:LibEth@EthiopiaOnline.Net>

=head1 SEE ALSO

S<perl(1).  LiveGeez(3).  Ethiopic(3).  L<http://libeth.netpedia.net|http://libeth.netpedia.net>>

=cut
