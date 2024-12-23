package Day09;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub part1 {
    my ($self, $sInput) = @_;
    chomp $sInput;

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
    chomp $sInput;

    my @aDisk;
    my @aDigits = split(//, $sInput);
    my $iMaxId = -1;
    for (my $ii = 0; $ii < scalar(@aDigits); $ii++) {
        my $iId = ($ii % 2 == 0) ? $ii / 2 : ".";
        $iMaxId = $iId if ($iId ne "." && $iId > $iMaxId);
        for (my $ij = 0; $ij < $aDigits[$ii]; $ij++) {
            push(@aDisk, $iId);
        }
    }

    my $iRight = scalar(@aDisk);
    my $iId = $iMaxId;
    while ($iId > -1) {
        my @aFile;
        for (my $ii = 0; $ii < $iRight; $ii++) {
            push(@aFile, $ii) if ($aDisk[$ii] eq $iId);
        }        
        my @aaFree;
        for (my $ii = 0; $ii < $iRight; $ii++) {
            last if ($ii > $aFile[0]);
            next if ($aDisk[$ii] ne ".");
            my @aFree;
            while ($ii < $iRight) {
                last if ($aDisk[$ii] ne ".");
                push(@aFree, $ii);
                $ii++;    
            }
            next if (scalar(@aFree) < scalar(@aFile));
            for (my $ii = 0; $ii < scalar(@aFile); $ii++) {
                $aDisk[$aFree[$ii]] = $iId;
                $aDisk[$aFile[$ii]] = ".";
            }
            last;
        }
        $iRight = $aFile[0];
        $iId--;
    }

    my $iChecksum = 0;
    for (my $ii = 0; $ii < scalar(@aDisk); $ii++) {
        next if ($aDisk[$ii] eq ".");
        $iChecksum += $ii * $aDisk[$ii];
    }

    return $iChecksum;
}

1;
