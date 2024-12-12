package Day09;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub part1 {
    my ($self, $sInput) = @_;

    my @aDisk;
    my @aDigits = split(//, $sInput);
    for (my $ii = 0; $ii < scalar(@aDigits); $ii++) {
        my $iId = ($ii % 2 == 0) ? $ii / 2 : ".";
        for (my $ij = 0; $ij < $aDigits[$ii]; $ij++) {
            push(@aDisk, $iId);
        }
    }

    my $iLeft  = 0;
    my $iRight = scalar(@aDisk) - 1;
    while ($iLeft < $iRight) {
        if ($aDisk[$iLeft] ne ".") {
            $iLeft++;
            next;
        }
        if ($aDisk[$iRight] eq ".") {
            $iRight--;
            next;
        }
        $aDisk[$iLeft]  = $aDisk[$iRight];
        $aDisk[$iRight] = ".";
    }
    
    my $iChecksum = 0;
    for (my $ii = 0; $ii < scalar(@aDisk); $ii++) {
        last if ($aDisk[$ii] eq ".");
        $iChecksum += $ii * $aDisk[$ii];
    }

    return $iChecksum;
}


sub part2 {
    my ($self, $sInput) = @_;

    my @aDisk;
    my @aDigits = split(//, $sInput);
    for (my $ii = 0; $ii < scalar(@aDigits); $ii++) {
        my $iId = ($ii % 2 == 0) ? $ii / 2 : ".";
        for (my $ij = 0; $ij < $aDigits[$ii]; $ij++) {
            push(@aDisk, $iId);
        }
    }

    # TODO...

    my $iChecksum = 0;
    for (my $ii = 0; $ii < scalar(@aDisk); $ii++) {
        last if ($aDisk[$ii] eq ".");
        $iChecksum += $ii * $aDisk[$ii];
    }

    return $iChecksum;
}

1;
