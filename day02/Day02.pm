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

# sub part2 {

# }

1;
