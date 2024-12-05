package Day03;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

sub part1 {
    my ($self, $sInput) = @_;
    my @aMatches = $sInput =~ m/mul\(\d+,\d+\)/g;
    my $iSum = 0;
    foreach my $sMatch (@aMatches) {
        if ($sMatch =~ m/mul\((\d+),(\d+)\)/) {
            $iSum += ($1 * $2);
        }
    }
    return $iSum;
}

sub part2 {
    my ($self, $sInput) = @_;
    my @aMatches = $sInput =~ m/(mul\(\d+,\d+\)|do\(\)|don\'t\(\))/g;
    my $iSum   = 0;
    my $bDoMul = 1;
    foreach my $sMatch (@aMatches) {
        $bDoMul = 1 if ($sMatch =~ m/do\(\)/);
        $bDoMul = 0 if ($sMatch =~ m/don\'t\(\)/);
        if ($sMatch =~ m/mul\((\d+),(\d+)\)/) {
            $iSum += ($1 * $2) if $bDoMul;
        }
    }
    return $iSum;
}

1;
