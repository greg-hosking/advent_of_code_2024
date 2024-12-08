package Day07;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub part1 {
    my ($self, $sInput) = @_;

    my $iSum = 0;
    foreach my $sLine (split(/\n/, $sInput)) {
        my ($iTargetVal, $sNums) = split(/: /, $sLine);
        my @aNums    = split(/ /, $sNums);
        my $iNumOps  = scalar(@aNums) - 1;
        for (my $ii = 0; $ii < 2 ** $iNumOps; $ii++) {
            my @aOps = split(//, sprintf("%0" . $iNumOps . "b", $ii));
            my $iVal = $aNums[0];
            for (my $ij = 0; $ij < scalar(@aOps); $ij++) {
                my $iOp = $aOps[$ij]; # 0 => add; 1 => multiply
                if ($iOp == 0) {
                    $iVal += $aNums[$ij + 1];
                } else {
                    $iVal *= $aNums[$ij + 1];
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

# sub part2 {
    # my ($self, $sInput) = @_;
    
    # my $iSum = 0;
    # foreach my $sLine (split(/\n/, $sInput)) {
    #     my ($iTargetVal, $sNums) = split(/: /, $sLine);
    #     my @aNums    = split(/ /, $sNums);
    #     my $iNumOps  = scalar(@aNums) - 1;
    #     my $bSolveable = 0;
    #     for (my $ii = 0; $ii < 2 ** $iNumOps; $ii++) {
    #         my @aOps = split(//, sprintf("%0" . $iNumOps . "b", $ii));
    #         my $iVal = $aNums[0];
    #         for (my $ij = 0; $ij < scalar(@aOps); $ij++) {
    #             my $iOp = $aOps[$ij]; # 0 => add; 1 => multiply
    #             if ($iOp == 0) {
    #                 $iVal += $aNums[$ij + 1];
    #             } else {
    #                 $iVal *= $aNums[$ij + 1];
    #             }
    #         }
    #         print "val, ops for 445:\n" if ($iTargetVal == 445);
    #         print "ii: $ii... $iVal.\n" if ($iTargetVal == 445);
    #         print Dumper(\@aOps) if ($iTargetVal == 445);
    #         if ($iVal == $iTargetVal) {
    #             $iSum += $iVal;
    #             $bSolveable = 1;
    #             last;
    #         }
    #     }
    #     next if ($bSolveable);
    #     for (my $ii = 0; $ii < 3 ** $iNumOps; $ii++) {
    #         my $sBase3;
    #         if ($ii == 0) {
    #             $sBase3 = "0";
    #         } else {
    #             my $ik = $ii;
    #             while ($ik > 0) {
    #                 $sBase3 .= ($ik % 3);
    #                 $ik = int($ik / 3);
    #             }
    #         }
    #         my @aOps = split(//, reverse(sprintf("%0" . $iNumOps . "d", $sBase3)));
    #         my $iVal = $aNums[0];
    #         for (my $ij = 0; $ij < scalar(@aOps); $ij++) {
    #             my $iOp = $aOps[$ij]; # 0 => add; 1 => multiply; 2 => ||
    #             if ($iOp == 0) {
    #                 $iVal += $aNums[$ij + 1];
    #             } elsif ($iOp == 1) {
    #                 $iVal *= $aNums[$ij + 1];
    #             } else {
    #                 $iVal .= $aNums[$ij + 1];
    #             }
    #         }
    #         print "val, ops for 445:\n" if ($iTargetVal == 445);
    #         print "ii: $ii... $iVal.\n" if ($iTargetVal == 445);
    #         print Dumper(\@aOps) if ($iTargetVal == 445);
    #         if ($iVal == $iTargetVal) {
    #             $iSum += $iVal;
    #             $bSolveable = 1;
    #             last;
    #         }
    #     }

    #     print "$sLine is not solveable?\n" if (!$bSolveable);
    # }

    # return $iSum;
# }

1;
