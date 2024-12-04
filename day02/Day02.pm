package Day02;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

sub part1 {
    my ($self, $sInput) = @_;

    my $iSafe = 0;
    foreach my $sLine (split(/\n/, $sInput)) {
        my @aLevels = split(/\s+/, $sLine);
        my @aDiffs;
        for (my $ii = 0; $ii < scalar(@aLevels) - 1; $ii++) {
            push(@aDiffs, $aLevels[$ii + 1] - $aLevels[$ii]);
        }

        my $bSafe = 1;
        my $iSign = 0;
        foreach my $iDiff (@aDiffs) {
            if (!$iDiff) {
                $bSafe = 0;
                last;
            }
            if (!$iSign) {
                $iSign = 1 if ($iDiff > 0);
                $iSign = -1 if ($iDiff < 0);
            }
            if (($iDiff > 0 && $iSign == -1) || ($iDiff < 0 && $iSign == 1)) {
                $bSafe = 0;
                last;
            }
            if (abs($iDiff) < 1 || abs($iDiff) > 3) {
                $bSafe = 0;
                last;
            }
        }
        $iSafe++ if ($bSafe);
    }

    return $iSafe;
}

sub part2 {
    my ($self, $sInput) = @_;

    my $iSafe = 0;
    foreach my $sLine (split(/\n/, $sInput)) {
        my @aLevels = split(/\s+/, $sLine);
        my @aaLevelsDamp = [@aLevels];
        for (my $ii = 0; $ii < scalar(@aLevels); $ii++) {
            my @aTemp = @aLevels;
            splice(@aTemp, $ii, 1);
            push(@aaLevelsDamp, [@aTemp]);
        }

        my @aaDiffs;
        foreach my $paLevelsDamp (@aaLevelsDamp) {
            my @aDiffs;
            for (my $ii = 0; $ii < scalar(@$paLevelsDamp) - 1; $ii++) {
                push(@aDiffs, @$paLevelsDamp[$ii + 1] - @$paLevelsDamp[$ii]);
            }
            push(@aaDiffs, [@aDiffs]);
        }

        foreach my $paDiffs (@aaDiffs) {
            my $bSafe = 1;
            my $iSign = 0;
            foreach my $iDiff (@$paDiffs) {
                if (!$iDiff) {
                    $bSafe = 0;
                    last;
                }
                if (!$iSign) {
                    $iSign = 1 if ($iDiff > 0);
                    $iSign = -1 if ($iDiff < 0);
                }
                if (($iDiff > 0 && $iSign == -1) || ($iDiff < 0 && $iSign == 1)) {
                    $bSafe = 0;
                    last;
                }
                if (abs($iDiff) < 1 || abs($iDiff) > 3) {
                    $bSafe = 0;
                    last;
                }
            }
            if ($bSafe) {
                $iSafe++;
                last;
            }
        }
    }

    return $iSafe;
}

1;
