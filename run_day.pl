#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use lib 'C:\advent_of_code_2024';

my $iDay;
my $iPart;
GetOptions(
    'day=i'  => \$iDay,
    'part=i' => \$iPart,
) or die "Usage: $0 --day <day_number> --part <part_number>\n";

die "Please provide a valid day number (1-25)\n" unless $iDay >= 1 && $iDay <= 25;
die "Please provide a valid part number (1 or 2)\n" unless $iPart == 1 || $iPart == 2;

my $sDayDir          = "C:/advent_of_code_2024/day" . sprintf("%02d", $iDay);
eval "use lib '$sDayDir'";

my $sDayMod = "Day" . sprintf("%02d", $iDay);
eval "use $sDayMod";
if ($@) {
    die "Failed to load class for $sDayMod: $@";
}

my $sExampleInputFn  = "$sDayDir/example_input.txt"; 
my $sExampleOutputFn = "$sDayDir/example_output.txt";
my $sInputFn         = "$sDayDir/input.txt";

my $oDay = $sDayMod->new();
my $sPartSub = $iPart == 1 ? 'part1' : 'part2';
unless ($oDay->can($sPartSub)) {
    die "Error: Part $iPart is not implemented for Day $iDay. Please implement the '$sPartSub' sub in $sDayMod.\n";
}

open my $fh, '<', $sExampleOutputFn or die "Cannot open file $sExampleOutputFn: $!\n";
my $sExpectedOutput = <$fh>;
close $fh;
my ($sExpectedPart1, $sExpectedPart2) = split /\s+/, $sExpectedOutput;
my $sExpectedResult = $iPart == 1 ? $sExpectedPart1 : $sExpectedPart2;

print "Day $iDay, Part $iPart...\n";
print "Running example...\n";

my $sExampleInput = do {
    open my $fh, '<', $sExampleInputFn or die "Cannot open file $sExampleInputFn: $!\n";
    local $/;
    <$fh>;
};

my $sActualResult = $oDay->$sPartSub($sExampleInput);

if ($sActualResult eq $sExpectedResult) {
    print "Example passed!\n";
    print "Running input...\n";
    my $sInput = do {
        open my $fh, '<', $sInputFn or die "Cannot open file $sInputFn: $!\n";
        local $/;
        <$fh>;
    };
    my $finalResult = $oDay->$sPartSub($sInput);
    print "Result for Day $iDay, Part $iPart: $finalResult\n";
} else {
    print "Example failed!\n";
    print "Expected: $sExpectedResult\n";
    print "Actual:   $sActualResult\n";
}
