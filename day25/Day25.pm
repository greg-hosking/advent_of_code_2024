package Day25;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

sub part1 {
    my ($self, $sInput) = @_;
    chomp $sInput;

    my @aaLocks;
    my @aaKeys;
    my @aLines = split(/\n/, $sInput);
    for (my $ii = 0; $ii < scalar(@aLines); $ii += 8) {
        my @aSchema = (0) x length($aLines[$ii]);
        for (my $ij = $ii + 1; $ij < $ii + 6; $ij++) {
            my @aLine = split(//, $aLines[$ij]);
            for (my $ik = 0; $ik < scalar(@aLine); $ik++) {
                $aSchema[$ik]++ if ($aLine[$ik] eq "#");
            }
        }
        if ($aLines[$ii] =~ /#/) {
            push(@aaLocks, [@aSchema]);
        } else {
            push(@aaKeys, [@aSchema]);
        }
    }

    my $iPairs = 0;
    my $bFits;
    foreach my $paLock (@aaLocks) {
        foreach my $paKey (@aaKeys) {
            $bFits = 1;
            for (my $ii = 0; $ii < scalar(@$paLock); $ii++) {
                $bFits = 0 if ($paLock->[$ii] + $paKey->[$ii] > 5);
            }
            $iPairs++ if ($bFits);
        }
    }

    return $iPairs;
}

1;
