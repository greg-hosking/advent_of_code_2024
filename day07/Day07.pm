package Day07;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

sub part1 {
    my ($self, $sInput) = @_;
    my @aOps = qw(+ *);
    my %hOpCombosPerLength;
    my $iSum = 0;
    foreach my $sLine (split(/\n/, $sInput)) {
        my ($iTargetVal, $sNums) = split(/: /, $sLine);
        my @aNums = split(/ /, $sNums);
        my $iNumOps  = scalar(@aNums) - 1;
        my %hOpCombos;
        if (exists $hOpCombosPerLength{$iNumOps}) {
            %hOpCombos = %{$hOpCombosPerLength{$iNumOps}};
        } else {
            my $iNumCombos = 0;
            while ($iNumCombos <= scalar(@aOps) ** $iNumOps) {
                my $sCombo = "";
                for (my $ii = 0; $ii < $iNumOps; $ii++) {
                    $sCombo .= $aOps[int(rand(scalar(@aOps)))];
                }
                if (!exists $hOpCombos{$sCombo}) {
                    $hOpCombos{$sCombo} = 1;
                    $iNumCombos++;
                }
                last if ($iNumCombos == scalar(@aOps) ** $iNumOps);
            }
            $hOpCombosPerLength{$iNumOps} = \%hOpCombos;
        }
        foreach my $sCombo (keys %hOpCombos) {
            my @aCombo = split(//, $sCombo);
            my $iVal = $aNums[0];
            for (my $ii = 0; $ii < scalar(@aCombo); $ii++) {
                if ($aCombo[$ii] eq "+") {
                    $iVal += $aNums[$ii + 1]; 
                } else {
                    $iVal *= $aNums[$ii + 1];
                }
            }
            if ($iVal == $iTargetVal) {
                $iSum += $iVal;
                last;
            }
        }
    }

    return $iSum;
}

sub part2 {
    my ($self, $sInput) = @_;
    my @aOps = qw(+ * |);
    my %hOpCombosPerLength;
    my $iSum = 0;
    foreach my $sLine (split(/\n/, $sInput)) {
        my ($iTargetVal, $sNums) = split(/: /, $sLine);
        my @aNums = split(/ /, $sNums);
        my $iNumOps  = scalar(@aNums) - 1;
        my %hOpCombos;
        if (exists $hOpCombosPerLength{$iNumOps}) {
            %hOpCombos = %{$hOpCombosPerLength{$iNumOps}};
        } else {
            my $iNumCombos = 0;
            while ($iNumCombos <= scalar(@aOps) ** $iNumOps) {
                my $sCombo = "";
                for (my $ii = 0; $ii < $iNumOps; $ii++) {
                    $sCombo .= $aOps[int(rand(scalar(@aOps)))];
                }
                if (!exists $hOpCombos{$sCombo}) {
                    $hOpCombos{$sCombo} = 1;
                    $iNumCombos++;
                }
                last if ($iNumCombos == scalar(@aOps) ** $iNumOps);
            }
            $hOpCombosPerLength{$iNumOps} = \%hOpCombos;
        }
        foreach my $sCombo (keys %hOpCombos) {
            my @aCombo = split(//, $sCombo);
            my $iVal = $aNums[0];
            for (my $ii = 0; $ii < scalar(@aCombo); $ii++) {
                if ($aCombo[$ii] eq "+") {
                    $iVal += $aNums[$ii + 1]; 
                } elsif ($aCombo[$ii] eq "*") {
                    $iVal *= $aNums[$ii + 1];
                } else {
                    $iVal .= $aNums[$ii + 1];
                }
            }
            if ($iVal == $iTargetVal) {
                $iSum += $iVal;
                last;
            }
        }
    }

    return $iSum;
}

1;
