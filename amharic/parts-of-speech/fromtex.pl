#!/usr/bin/perl -w

binmode(STDOUT, ":utf8");
use strict;
use utf8;
use encoding 'utf8';

my $foo;
my $commentOn = 0;

my %Maps =(
	ssaG 	=> "ሣ",
	reG	=> "ረ",
	rEG	=> "ሬ",
	roG	=> "ሮ",
	rG	=> "ር",
	seG	=> "ሰ",
	saG 	=> "ሳ",
	sG	=> "ስ",
	meG	=> "መ",
	maG	=> "ማ",
	mG	=> "ም",
	eG	=> "አ",
	iG	=> "ኢ",
	AG	=> "ኣ",
	IG	=> "እ",
	eeG	=> "ዐ",
	IIG	=> "ዕ",
	leG	=> "ለ",
	luG	=> "ሉ",
	lG	=> "ል",
	keG	=> "ከ",
	kuG	=> "ኩ",
	kiG	=> "ኪ",
	kG	=> "ክ",
	beG	=> "በ",
	biG	=> "ቢ",
	bEG	=> "ቤ",
	bG	=> "ብ",
	boG	=> "ቦ",
	deG	=> "ደ",
	daG	=> "ዳ",
	dG	=> "ድ",
	geG	=> "ገ",
	gaG	=> "ጋ",
	gG	=> "ግ",
	goG	=> "ጎ",
	neG	=> "ነ",
	naG	=> "ና",
	nG	=> "ን",
	NaG	=> "ኛ",
	NG	=> "ኝ",
	teG	=> "ተ",
	tuG	=> "ቱ",
	taG	=> "ታ",
	tG	=> "ት",
	xiG	=> "ሺ",
	weG	=> "ወ",
	wiG	=> "ዊ",
	waG	=> "ዋ",
	wG	=> "ው",
	yeG	=> "የ",
	yaG	=> "ያ",
	yEG	=> "ዬ",
	yG	=> "ይ",
	spaceG	=> "፡",
	ssG	=> "ሥ",
	HG	=> "ሕ",
	sEG	=> "ሴ",
	yoG	=> "ዮ",
	qeG	=> "ቀ",
	qaG	=> "ቃ",
	qG	=> "ቅ",
	TG	=> "ጠ",
	feG	=> "ፈ",
	fG	=> "ፍ",
	zeG	=> "ዘ",
	zG	=> "ዝ",
	xaG	=> "ሻ",
	CaG	=> "ጫ",
	dEG	=> "ዴ",
	TeG	=> "ጠ",
	hoG	=> "ሆ",
	huG	=> "ሁ",
	nEG	=> "ኔ",
	tEG	=> "ቴ",
	caG	=> "ቻ",
	laG	=> "ላ",
	baG	=> "ባ",
	jG	=> "ጅ",
	SSaG	=> "ጻ",
	SSoG	=> "ጾ",
	SSeG	=> "ፀ",
	SSG	=> "ፅ",
	uuG	=> "ዑ",
	ooG	=> "ዖ",
	noG	=> "ኖ",
	kaG	=> "ካ",
	cG	=> "ች",
	qWG	=> "ቊ",
	zuG	=> "ዙ",
	HeG	=> "ሐ",
	raG	=> "ራ",
	precolonG	=> "፦",
	periodG	=> "።",
	commaG	=> "፣",
	zaG	=> "ዛ",
	faG	=> "ፋ",
	hG	=> "ህ",
	hheG	=> "ኀ",
	fiG	=> "ፊ",
	giG	=> "ጊ",
	zEG	=> "ዜ",
	quG	=> "ቁ",
	ruG	=> "ሩ",
	SeG	=> "ጸ",
	SG	=> "ጽ",
	moG	=> "ሞ",
);
my $title;

print<<HEAD;
<html>
<head>
  <meta http-equiv="content-type" content="text/html; charset=utf8"/>
  <title>Noun Tables</title>
</head>
<body>
HEAD

while (<>) {
	if ( /begin{tabular}/ ) {
		print "<table border=\"1\">\n<tr>\n  <td>";
		next;
	}
	elsif ( /end{tabular}/ ) {
		print "</table>\n";
	}
	elsif ( /\\hspace\*\{(.*?)\}\{(\\large\\bf)? (.*?)$/ ) {
		# print STDERR "$1 / $2 / $3\n";
		$title = $3;
		$title =~ s/}(\s+)?\\\\(\s+)?$//;
		$_ = "<h3>$title</h3>\n";
	}
	elsif ( /{\\tableTitle[ABC]}\[(.*?)\]/ ) {
		if ( $commentOn ) {
			print "</pre>\n";
				$commentOn = 0;
		}
print<<TITLE;
<tr>
  <th>Allowable Prefixes</th>
  <th>Required Midfix</th>
  <th>$1</th>
  <th>Stem & Allowable Suffixes</th>
</tr>
TITLE
		next;
	}
	if ( /continuants/ ) {
		# {(({\mG},{\sG}) + ({\naG}+{\AG}))}
		s/\\continuantsA/((ም,ስ) + (ና+ኣ))/;

		# {({\mG},{\sG},{\maG},{\saG})}
		s/\\continuantsFour/(ም,ስ,ማ,ሳ)/;

		# {({\mG},{\sG},{\maG},{\saG},{\naG})}
		s/\\continuantsxsa/(ም,ስ,ማ,ሳ,ና)/;

		# {({\mG},{\sG},{\naG},{\maG},{\AG})}
		s/\\continuantsxa/(ም,ስ,ና,ማ,ኣ)/;

		# {({\mG},{\sG},{\maG},{\naG})}
		s/\\continuantsx/(ም,ስ,ማ,ና)/;

		# {({\mG},{\sG},{\nG},{\maG},{\naG})}
		s/\\continuantsn/(ም,ስ,ን,ማ,ና)/;

		# {(({\mG}+{\naG}),{\sG},{\maG})}
		s/\\continuantsy/((ም+ና),ስ,ማ)/;

		# {({\mG},{\sG}) + ({\naG},{\maG},{\saG})}
		s/\\continuantsz/((ም,ስ) + (ና,ማ,ሳ))/;

		# {(({\mG},{\sG})+{\gaG}+{\naG}),({\gaG}+\continuantssa)}
		s/\\continuantssaga/((ም,ስ)+ጋ+ና),(ጋ+(((ም,ስ) + ና),ማ,ሳ))/;

		# {({\mG},{\sG}) + {\gaG} + \continuantssa$^{\tinyga}$}
		s/\\continuantsgazna/(ም,ስ) + ጋ + (((ም,ስ) + ና),ማ,ሳ))<sup>ጋ<\/sup>/;

		#{({\mG},{\sG}) + {\gaG} + ({\mG},{\sG},{\maG})$^{\tinyga}$}
		s/\\continuantsgazz/(ም,ስ) + ጋ + (ም,ስ,ማ)<sup>ጋ<\/sup>/;

		# {({\mG},{\sG}) + {\gaG} + \continuantsFour}
		s/\\continuantsgaz/(ም,ስ) + ጋ + (ም,ስ,ማ,ሳ)/;

		# {(({\mG},{\sG})+{\gaG}+{\naG}),({\gaG}+\continuants)}
		s/\\continuantsga/((ም,ስ)+ጋ+ና),(ጋ+(((ም,ስ) + ና),ማ))/;

		# {((({\mG},{\sG}) + {\naG}),{\maG},{\saG})}
		s/\\continuantssa/(((ም,ስ) + ና),ማ,ሳ)/;

		# "((({\mG},{\sG}) + {\naG}),{\maG})}\n";
		s/\\continuants/(((ም,ስ) + ና),ማ)/;
	}
	chomp if ( /hline/ );
	s/^\s+//;
	s/\s+$//;
	s/( )+/ /g;
	s|(\s+)?\\\\ (\\hline)+|</td>\n</tr>\n<tr>\n  <td>|;
	s|(\\hline)+|\n</tr>\n<tr>\n  <td>|;
	s|(\s+)?\\\\(\s+)?$|</td>\n</tr>\n<tr>\n  <td>|;

	next unless ( /G/ || /<h3/ );
	s/\\geminateG{(.*?)G}/$1\x{135f}/g;
	if ( /\{\\(\w+G)\}/ ) {
		my $found = $1;
		# print "\nFound: $found\n";
		# if ( exists($Maps{$found}) && defined($Maps{$found}) ) {
		if ( exists $Maps{$found} ) {
			# print "\nMapping: $found\n";
			s/\{\\(\w+G)\}/$Maps{$1}/g;
		}
		else {
			print "\nUnmapped: $found\n";
		}
	}
	s|(\s+)?&(\s+)?|</td>\n  <td>|g;
	s|\\tinyIye|<sub>እየ</sub>|g;
	s|\\tinyIne|<sub>እነ</sub>|g;
	s|\\tinyit|<sub>ኢት</sub>|g;
	s|\\tinyInd|<sub>እንድ</sub>|g;
	s|\\tinyale|<sub>አለ</sub>|g;
	s|\\tinysEt|<sub>ሴት</sub>|g;
	s|\\downstarnet|<sub>*,ነት</sub>|g;
	s|\\downstar|<sub>*</sub>|g;
	s|\$^\\star\$|<sup>*</sup>|;
	s|\$?\\star(\$)?|*|;

	if ( /^%/ ) {
		s/^%//;
		unless ( $commentOn ) {
			print "<pre>\n";
			$commentOn = 1;
		}
	}
	elsif ( $commentOn ) {
		print "</pre>\n";
			$commentOn = 0;
	}

if ( 0 ) {
	s/\{\\//g;
	s/G}//g;
	s/\\\\//g;
	s/( )+\t/\t/g;
	s/\t( )/\t/g;
	s/;/,/g;
	s/,(\w)/, $1/g;
	s/[ \t]+$//;
	s/ \)/)/;
	s/\( /(/;
	s/\t\t/\t(\\none\\ )\t/g;
	s/(\w)\(/$1 (/;
	$foo = reverse($_);
	$foo =~ s/\t/ \\\t/;
	$_ = reverse($foo);
	s/\n/\\\n/;
}
	print;
}

print "\n</pre>\n\n</body>\n</html>";
