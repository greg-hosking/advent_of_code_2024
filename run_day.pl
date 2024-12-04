#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

my $iDay;
my $iPart;
GetOptions(
    'day=i'  => \$iDay,
    'part=i' => \$iPart,
) or die "Usage: $0 --day <day_number> --part <part_number>\n";

die "Please provide a valid day number (1-25)\n" unless $iDay >= 1 && $iDay <= 25;
die "Please provide a valid part number (1 or 2)\n" unless $iPart == 1 || $iPart == 2;

my $sDayModule = "Day" . sprintf("%02d", $iDay);
eval "use $sDayModule";
if ($@) {
    die "Failed to load class for $sDayModule: $@";
}

my $sDayDir      = "C:/advent_of_code_2024/day" . sprintf("%02d", $iDay);
my $exampleFile  = "$sDayDir/example.txt";
my $inputFile    = "$sDayDir/input.txt";
my $exampleOut   = "$sDayDir/example_output.txt";

my $dayObject = $sDayModule->new(input_file => $inputFile);

# Check if the method for the specified part is implemented
my $method = $iPart == 1 ? 'part1' : 'part2';
unless ($dayObject->can($method)) {
    die "Error: Part $iPart is not implemented for Day $iDay. Please implement the '$method' method in $sDayModule.\n";
}

# Read example output file
open my $fh, '<', $exampleOut or die "Cannot open file $exampleOut: $!\n";
my $expectedOutput = <$fh>;
close $fh;
my ($expectedPart1, $expectedPart2) = split /\s+/, $expectedOutput;
my $expectedResult = $iPart == 1 ? $expectedPart1 : $expectedPart2;

# Run the example
print "Day $iDay, Part $iPart...\n";
print "Running example...\n";

my $exampleInput = do {
    open my $fh, '<', $exampleFile or die "Cannot open file $exampleFile: $!\n";
    local $/; # Slurp mode
    <$fh>;
};

my $actualResult = $dayObject->$method($exampleInput);

if ($actualResult eq $expectedResult) {
    print "Example passed!\n";

    # Run the actual input if the example passed
    print "Running actual input...\n";

    my $inputContent = do {
        open my $fh, '<', $inputFile or die "Cannot open file $inputFile: $!\n";
        local $/; # Slurp mode
        <$fh>;
    };

    my $finalResult = $dayObject->$method($inputContent);
    print "Result for Day $iDay, Part $iPart: $finalResult\n";
} else {
    print "Example failed!\n";
    print "Expected: $expectedResult\n";
    print "Actual  : $actualResult\n";
}
