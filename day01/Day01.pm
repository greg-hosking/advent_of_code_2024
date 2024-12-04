package Day01;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

sub part1 {
    my ($self, $sInput) = @_;

    my (@aLeft, @aRight);
    foreach my $sLine (split(/\n/, $sInput)) {
        my ($iLeft, $iRight) = split(/\s+/, $sLine);
        push(@aLeft, $iLeft);
        push(@aRight, $iRight);
    }
    @aLeft  = sort @aLeft;
    @aRight = sort @aRight;

    my $iSum = 0;
    for (my $ii = 0; $ii < scalar(@aLeft); $ii++) {
        $iSum += abs($aLeft[$ii] - $aRight[$ii]);
    }

    return $iSum;
}

sub part2 {
    my ($self, $sInput) = @_;

    my (@aLeft, @aRight);
    foreach my $sLine (split(/\n/, $sInput)) {
        my ($iLeft, $iRight) = split(/\s+/, $sLine);
        push(@aLeft, $iLeft);
        push(@aRight, $iRight);
    }

    my %hCounts;
    foreach my $iRight (@aRight) {
        $hCounts{$iRight}++;
    }

    my $iSum = 0;
    foreach my $iLeft (@aLeft) {
        $iSum += $iLeft * $hCounts{$iLeft} if $hCounts{$iLeft};
    }

    return $iSum;
}

1;
