package Day05;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub part1 {
    my ($self, $sInput) = @_;
    my @aRules;
    my @aUpdates;
    foreach my $sLine (split(/\n/, $sInput)) {
        next if ($sLine eq "" || $sLine eq "\n");
        if ($sLine =~ m/\d+\|\d+/g) {
            push(@aRules, $sLine)
        } else {
            push(@aUpdates, $sLine);
        }
    }

    my $iSum = 0;
    foreach my $sUpdate (@aUpdates) {
        my @aUpdate = split(/,/, $sUpdate);
        my %hIndices;
        for my $ii ( 0 .. scalar(@aUpdate) - 1 ) {
            $hIndices{$aUpdate[$ii]} = $ii;
        }
        my $bRightOrder = 1;
        foreach my $sRule (@aRules) {
            my ($iBefore, $iAfter) = split(/\|/, $sRule);
            if (exists $hIndices{$iBefore} && exists $hIndices{$iAfter} && $hIndices{$iBefore} > $hIndices{$iAfter}) {
                $bRightOrder = 0;
                last;
            }
        }
        $iSum += $aUpdate[scalar(@aUpdate) / 2] if ($bRightOrder);
    }

    return $iSum;
}

sub part2 {
    my ($self, $sInput) = @_;
    my @aRules;
    my @aUpdates;
    foreach my $sLine (split(/\n/, $sInput)) {
        next if ($sLine eq "" || $sLine eq "\n");
        if ($sLine =~ m/\d+\|\d+/g) {
            push(@aRules, $sLine)
        } else {
            push(@aUpdates, $sLine);
        }
    }

    my @aBadUpdates;
    foreach my $sUpdate (@aUpdates) {
        my @aUpdate = split(/,/, $sUpdate);
        my %hIndices;
        for my $ii ( 0 .. scalar(@aUpdate) - 1 ) {
            $hIndices{$aUpdate[$ii]} = $ii;
        }
        foreach my $sRule (@aRules) {
            my ($iBefore, $iAfter) = split(/\|/, $sRule);
            if (exists $hIndices{$iBefore} && exists $hIndices{$iAfter} && $hIndices{$iBefore} > $hIndices{$iAfter}) {
                push(@aBadUpdates, $sUpdate);
                last;
            }
        }
    }

    my $iSum = 0;
    foreach my $sUpdate (@aBadUpdates) {
        my @aUpdate = split(/,/, $sUpdate);
        my %hIndices;
        for my $ii ( 0 .. scalar(@aUpdate) - 1 ) {
            $hIndices{$aUpdate[$ii]} = $ii;
        }
        my $bRightOrder = 1;
        foreach my $sRule (@aRules) {
            my ($iBefore, $iAfter) = split(/\|/, $sRule);
            if (exists $hIndices{$iBefore} && exists $hIndices{$iAfter} && $hIndices{$iBefore} > $hIndices{$iAfter}) {
                $aUpdate[$hIndices{$iBefore}] = $iAfter;
                $aUpdate[$hIndices{$iAfter}]  = $iBefore;
                $sUpdate = join(',', @aUpdate);
                $bRightOrder = 0;
                last;
            }
        }
        redo if (!$bRightOrder); # Swap around until we get it right...
        $iSum += $aUpdate[scalar(@aUpdate) / 2] if ($bRightOrder);
    }

    return $iSum;
}

1;
