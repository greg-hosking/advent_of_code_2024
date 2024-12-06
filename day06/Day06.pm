package Day06;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

# Rotate array representing 2d direction [r, c] 90 degrees clockwise
sub turn_right {
    my ($paDir) = @_;
    my @aDir = @$paDir;

    my $iTemp = $aDir[1];
    $aDir[0] *= -1;
    $aDir[1] = $aDir[0];
    $aDir[0] = $iTemp;

    return \@aDir;
}

sub part1 {
    my ($self, $sInput) = @_;

    my %hSeen;
    my @aGuardPos;
    my @aGuardDir = (-1, 0); # Start pointing up
    my @aaWalkable;
    my @aLines = split(/\n/, $sInput);
    for my $ir ( 0 .. scalar(@aLines) - 1 ) {
        my @aRow = split(//, $aLines[$ir]);
        my @aWalkable;
        for my $ic ( 0 .. scalar(@aRow) - 1 ) {
            if ($aRow[$ic] eq '^') {
                @aGuardPos = ($ir, $ic);
                push(@aWalkable, 1);
                $hSeen{"$ir,$ic"} = 1;
            } else {
                my $bWalkable = ($aRow[$ic] eq '#') ? 0 : 1;
                push(@aWalkable, $bWalkable);
            }
        }
        push(@aaWalkable, [@aWalkable]);
    }

    my $iRows = scalar(@aaWalkable);
    my $iCols = scalar($aaWalkable[0]);
    while ($aGuardPos[0] >= 0 && $aGuardPos[0] <= $iRows - 1 && $aGuardPos[1] >= 0 && $aGuardPos[1] <= $iCols - 1) {
        my $sKey = $aGuardPos[0] . "," . $aGuardPos[1];
        $hSeen{$sKey} = 1;
        my @aTargetPos = ($aGuardPos[0] + $aGuardDir[0], $aGuardPos[1] + $aGuardDir[1]);
        last if ($aTargetPos[0] < 0 || $aTargetPos[0] > $iRows - 1 || $aTargetPos[1] < 0 || $aTargetPos[1] > $iCols - 1);
        my $bTargetWalkable = $aaWalkable[$aTargetPos[0]]->[$aTargetPos[1]];
        if ($bTargetWalkable) {
            $aGuardPos[0] = $aTargetPos[0];
            $aGuardPos[1] = $aTargetPos[1];
        } else {
            @aGuardDir = @{turn_right(\@aGuardDir)};
        }
    }

    return scalar(keys %hSeen);
}

# sub part2 {
#     my ($self, $sInput) = @_;
#     # Solution...
# }

1;
