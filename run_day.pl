#!/usr/bin/perl
use strict;
use warnings;
use HTTP::Request;
use LWP::UserAgent;
use HTTP::Cookies;
use Getopt::Long;
use lib 'C:\advent_of_code_2024';

my $iDay;
my $iPart;
GetOptions(
    'day=i'  => \$iDay,
    'part=i' => \$iPart,
) or die "Usage: $0 --day <day_number> --part <part_number>\n";

die "Please provide a valid day number (1-25)\n"
  unless $iDay >= 1 && $iDay <= 25;
die "Please provide a valid part number (1 or 2)\n"
  unless $iPart == 1 || $iPart == 2;

my $sDayDir = "C:/advent_of_code_2024/day" . sprintf( "%02d", $iDay );
eval "use lib '$sDayDir'";

my $sDayMod = "Day" . sprintf( "%02d", $iDay );
eval "use $sDayMod";
if ($@) {
    die
"Error: Day $iDay is not implemented. Please implement the '$sDayMod' module in $sDayDir";
}

my $sExampleInputFn  = "$sDayDir/example_input.txt";
my $sExampleOutputFn = "$sDayDir/example_output.txt";
my $sInputFn         = "$sDayDir/input.txt";

my $oDay = $sDayMod->new();
my $sPartSub = $iPart == 1 ? 'part1' : 'part2';
unless ( $oDay->can($sPartSub) ) {
    die
"Error: Part $iPart is not implemented for Day $iDay. Please implement the '$sPartSub' sub in $sDayMod";
}

open my $fh, '<', $sExampleOutputFn
  or die "Cannot open file $sExampleOutputFn: $!\n";
my $sExpectedOutput = <$fh>;
close $fh;
my ( $sExpectedPart1, $sExpectedPart2 ) = split /\s+/, $sExpectedOutput;
my $sExpectedResult = $iPart == 1 ? $sExpectedPart1 : $sExpectedPart2;

print "Day $iDay, Part $iPart...\n";
print "Running example...\n";

my $sExampleInput = do {
    open my $fh, '<', $sExampleInputFn
      or die "Cannot open file $sExampleInputFn: $!\n";
    local $/;
    <$fh>;
};

my $sActualResult = $oDay->$sPartSub($sExampleInput);
if ( $sActualResult eq $sExpectedResult ) {
    print "Example passed!\n";
    print "Running input...\n";
    my $sInput = do {
        open my $fh, '<', $sInputFn or die "Cannot open file $sInputFn: $!\n";
        local $/;
        <$fh>;
    };
    my $sFinalResult = $oDay->$sPartSub($sInput);
    print "Result for Day $iDay, Part $iPart: $sFinalResult\n";

    print "Submitting answer...\n";
    my $sSession = $ENV{'AOC_SESSION'};
    if ( !$sSession ) {
        die "Error: AOC_SESSION environment variable not set.\n"
          . "Please set the AOC_SESSION environment variable with your Advent of Code session cookie.\n"
          . "For Windows: set AOC_SESSION=YOUR_SESSION_COOKIE\n" 
          . "For Linux:   export AOC_SESSION=YOUR_SESSION_COOKIE\n";
    }

    my $sUrl       = "https://adventofcode.com/2024/day/$iDay/answer";
    my $oUserAgent = LWP::UserAgent->new;
    $oUserAgent->cookie_jar( HTTP::Cookies->new );
    $oUserAgent->max_redirect(3);    # Allow redirections

    my $oReq = HTTP::Request->new( POST => $sUrl );
    $oReq->content_type('application/x-www-form-urlencoded');
    $oReq->header( 'Cookie' => "session=$sSession" );
    $oReq->content("level=$iPart&answer=$sFinalResult");

    my $oResp = $oUserAgent->request($oReq);

    if ( $oResp->code == 303 ) {
        my $sLocation = $oResp->header('Location');
        if ($sLocation) {
            print "Received redirect to: $sLocation\n";
            my $oRedirectResp = $oUserAgent->get($sLocation);
            if ( $oRedirectResp->is_success ) {
                my $sContent = $oRedirectResp->decoded_content;
                if ( $sContent =~ /<article><p>(.*?)<\/p><\/article>/s ) {
                    my $sMessage = $1;
                    $sMessage =~ s/<[^>]+>//g;
                    $sMessage =~ s/\[Return to.*?\]//g;
                    $sMessage =~ s/\s+/ /g;
                    print "$sMessage\n";
                }
            }
            else {
                die "Error following redirect: "
                  . $oRedirectResp->status_line . "\n";
            }
        }
        else {
            die "Error: No Location header found in 303 response.\n";
        }
    }
    elsif ( $oResp->is_success ) {
        my $sContent = $oResp->decoded_content;
        if ( $sContent =~ /<article><p>(.*?)<\/p><\/article>/s ) {
            my $sMessage = $1;
            $sMessage =~ s/<[^>]+>//g;
            $sMessage =~ s/\[Return to.*?\]//g;
            $sMessage =~ s/\s+/ /g;
            print "$sMessage\n";
        }
    }
    else {
        die "Error: " . $oResp->status_line . "\n";
    }
}
else {
    print "Example failed!\n";
    print "Expected result: $sExpectedResult\n";
    print "Actual result:   $sActualResult\n";
}
