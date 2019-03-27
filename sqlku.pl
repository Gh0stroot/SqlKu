#!/usr/bin/env perl
#Author : Ms.ambari
#Date : 2018-12-23
#Version: V.1.0

use LWP::UserAgent;
use Term::ANSIColor;
my $ua = LWP::UserAgent->new;
my %err = ("OK" => "error in your SQL syntax",);
my @result = ();
$max = 5;
sub main{
	while(1){
		print color("reset"),"[",color("green"),"*",color("reset"),"] Dork: ";
		$dork = <STDIN>; chomp($dork);
		for (my $i = 1; $i <= $max; $i++) {
			$target = "http://www.search-results.com/web?q=".$dork."&hl=en&page=".$i;
			$req = $ua->get($target);
			$resp = $req->content;
			while ($resp =~ m/<cite..class=\"algo-display[\D]*url\">(.*)<\/cite>/g) {
				$hasil = $1."'";
				push @result, $hasil;
			}
		}
		my %has = map{$_ => 1} @result;
		my @res = keys %has;
		for (my $x = 0; $x < @res.length; $x++) {
			$targets = @res[$x];
			$reqs = $ua->get($targets);
			$respcon = $reqs->content;
			foreach $key(keys %err) {
				$f = "'";
				$rep = "";
				$targets =~ s/$f/$rep/;
				if ($respcon =~ %err{$key}) {
					open(my $vulnweb,">>","sql_vuln.txt") || do ("$!");
					say $vulnweb $targets;
					print color("reset"),"[ ",color("red"),$key,color("reset")," ] ",color("red"),$targets,"\n",color("reset");
				}else{
					print color("reset"),"[ ",color("green"),"NO",color("reset")," ] ",$targets,"\n",color("reset");
				}
			}
		}
	}
}

print color("green"),"              __ __          \n";
print " .-----.-----|  |  |--.--.--.\n";
print " |__ --|  _  |  |    <|  |  |\n";
print " |_____|__   |__|__|__|_____|",color("reset")," V.1.0\n",color("green");
print "          |__|\n\n"; main();