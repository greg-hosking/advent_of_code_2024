#!/usr/bin/perl
use strict;
use warnings;
use HTTP::Request;
use LWP::UserAgent;
use HTTP::Cookies;
use Getopt::Long;
use lib 'C:\advent_of_code_2024';

sub main {
    my ($iDay, $iPart, $bSubmit) = parse_arguments();

    # Load the module for the specific day
    my $oDay = load_day_module($iDay, $iPart);

    # Parse example input/output
    my $sExampleFn = "C:/advent_of_code_2024/day" . sprintf("%02d", $iDay) . "/example_part$iPart.txt";
    my ($sExampleInput, $sExampleOutput) = parse_example($sExampleFn);

    print "\n";
    print "====== Advent of Code 2024 ======\n";
    print "Day $iDay, Part $iPart\n";
    print "=================================\n";

    print "\n[INFO] Running example...\n";
    my $sPartSub = "part$iPart";
    my $sExampleResult = $oDay->$sPartSub($sExampleInput);
    if ($sExampleResult eq $sExampleOutput) {
        print "[SUCCESS] Example passed!\n";

        print "[INFO] Fetching puzzle input...\n";
        my $sInput = fetch_input($iDay);

        print "[INFO] Running solution...\n";
        my $sOutput = $oDay->$sPartSub($sInput);
        print "\n[SOLUTION] Result for Day $iDay, Part $iPart:\n";
        print "-----------------------------------\n";
        print "$sOutput\n";
        print "-----------------------------------\n";

        if ($bSubmit) {
            print "\n[INFO] Submitting answer...\n";
            submit_answer($iDay, $iPart, $sOutput);
        } else {
            print "[INFO] Submission skipped. Run with --submit to submit the answer.\n";
        }
    } else {
        print "[FAILURE] Example failed!\n";
        print "[EXPECTED]: $sExampleOutput\n";
        print "[ACTUAL]:   $sExampleResult\n";
    }
}

sub parse_arguments {
    my ($iDay, $iPart, $bSubmit, $bHelp);
    GetOptions(
        'day=i'    => \$iDay,
        'd=i'      => \$iDay,
        'part=i'   => \$iPart,
        'p=i'      => \$iPart,
        'submit'   => \$bSubmit,
        'help'     => \$bHelp,
    ) or show_usage();

    show_help() if $bHelp;
    show_usage() unless $iDay && $iDay >= 1 && $iDay <= 25;
    show_usage() unless $iPart && ($iPart == 1 || $iPart == 2);

    return ($iDay, $iPart, $bSubmit);
}

sub show_usage {
    print "Usage: perl run_day.pl --day <day_number> --part <part_number> [--submit] [--help]\n";
    exit;
}

sub show_help {
    print <<'HELP';
Usage: perl run_day.pl --day <day_number> --part <part_number> [OPTIONS]

Options:
  --day         Specify the day number (1-25).
  --part        Specify the part number (1 or 2).
  --submit      Submit the answer after solving. Defaults to skipping submission.
  --help        Display this help message.

Examples:
  perl run_day.pl --day 3 --part 1 --submit
  perl run_day.pl --day 5 --part 2 --submit
  perl run_day.pl --day 5 --part 2

HELP
    exit;
}

sub load_day_module {
    my ($iDay, $iPart) = @_;

    my $sDayDir = "C:/advent_of_code_2024/day" . sprintf("%02d", $iDay);
    eval "use lib '$sDayDir'";

    my $sDayMod = "Day" . sprintf("%02d", $iDay);
    eval "use $sDayMod";
    if ($@) {
        die "[ERROR] Day $iDay is not implemented. Please implement the '$sDayMod' module in $sDayDir\n";
    }

    my $oDay = $sDayMod->new();
    my $sPartSub = "part$iPart";
    die "[ERROR] Part $iPart is not implemented for Day $iDay.\n" unless $oDay->can($sPartSub);

    return $oDay;
}

sub parse_example {
    my ($sFilename) = @_;
    open my $fh, '<', $sFilename or die "[ERROR] Cannot open file $sFilename: $!\n";
    local $/ = undef;
    my $sContent = <$fh>;
    close $fh;

    my ($sInput)  = $sContent =~ /# Input:\s*(.*?)\s*# Output:/s;
    my ($sOutput) = $sContent =~ /# Output:\s*(.+?)\s*$/s;

    die "[ERROR] Invalid example file format in $sFilename\n" unless defined $sInput && defined $sOutput;
    return ($sInput, $sOutput);
}

sub fetch_input {
    my ($iDay) = @_;
    my $sSession = $ENV{'AOC_SESSION'};
    die "[ERROR] AOC_SESSION environment variable not set.\n"
      . "Please set it with your Advent of Code session cookie.\n" unless $sSession;

    my $sUrl = "https://adventofcode.com/2024/day/$iDay/input";
    my $oUserAgent = LWP::UserAgent->new;
    $oUserAgent->cookie_jar(HTTP::Cookies->new);

    my $oReq = HTTP::Request->new(GET => $sUrl);
    $oReq->header('Cookie' => "session=$sSession");

    my $oResp = $oUserAgent->request($oReq);
    die "[ERROR] Fetching input failed: " . $oResp->status_line . "\n" unless $oResp->is_success;

    return $oResp->decoded_content;
}

sub submit_answer {
    my ($iDay, $iPart, $sAnswer) = @_;
    my $sSession = $ENV{'AOC_SESSION'};
    die "[ERROR] AOC_SESSION environment variable not set.\n" unless $sSession;

    my $sUrl = "https://adventofcode.com/2024/day/$iDay/answer";
    my $oUserAgent = LWP::UserAgent->new;
    $oUserAgent->cookie_jar(HTTP::Cookies->new);

    my $oReq = HTTP::Request->new(POST => $sUrl);
    $oReq->content_type('application/x-www-form-urlencoded');
    $oReq->header('Cookie' => "session=$sSession");
    $oReq->content("level=$iPart&answer=$sAnswer");

    my $oResp = $oUserAgent->request($oReq);

    if ($oResp->is_success) {
        my $sContent = $oResp->decoded_content;
        if ($sContent =~ /<article><p>(.*?)<\/p><\/article>/s) {
            my $sMessage = $1;
            $sMessage =~ s/<[^>]+>//g;
            print "[RESPONSE] $sMessage\n";
        }
    } else {
        die "[ERROR] Submitting answer failed: " . $oResp->status_line . "\n";
    }
}

main();
