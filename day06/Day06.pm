package Day06;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub turn_right {
    my ($paDir) = @_;
    return [$paDir->[1], -1 * $paDir->[0]];
}

sub part1 {
    my ($self, $sInput) = @_;
    my %hSeen;
    my %hGuard = (
        "pos" => { "r" => -1, "c" => -1 },
        "dir" => { "r" => -1, "c" => 0 },  # Starting direction (up)
    );
    my @aaWalkable;
    my @aLines = split(/\n/, $sInput);
    for my $ir ( 0 .. scalar(@aLines) - 1 ) {
        my @aRow = split(//, $aLines[$ir]);
        my @aWalkable;
        for my $ic ( 0 .. scalar(@aRow) - 1 ) {
            if ($aRow[$ic] eq '^') {
                $hSeen{"$ir,$ic"} = 1;
                $hGuard{"pos"} = { "r" => $ir, "c" => $ic };
                push(@aWalkable, 1);
            } else {
                my $bWalkable = ($aRow[$ic] eq '#') ? 0 : 1;
                push(@aWalkable, $bWalkable);
            }
        }
        push(@aaWalkable, [@aWalkable]);
    }

    my $iRows = scalar(@aaWalkable);
    my $iCols = scalar($aaWalkable[0]);
    while ($hGuard{"pos"}{"r"} >= 0 && $hGuard{"pos"}{"r"} < $iRows
        && $hGuard{"pos"}{"c"} >= 0 && $hGuard{"pos"}{"c"} < $iCols) {
        my $sKey = $hGuard{"pos"}{"r"} . "," . $hGuard{"pos"}{"c"};
        $hSeen{$sKey} = 1;
        my $iTargetR = $hGuard{"pos"}{"r"} + $hGuard{"dir"}{"r"};
        my $iTargetC = $hGuard{"pos"}{"c"} + $hGuard{"dir"}{"c"};
        last if ($iTargetR < 0 || $iTargetR >= $iRows || $iTargetC < 0 || $iTargetC >= $iCols);
        my $bTargetWalkable = $aaWalkable[$iTargetR]->[$iTargetC];
        if ($bTargetWalkable) {
            $hGuard{"pos"}{"r"} = $iTargetR;
            $hGuard{"pos"}{"c"} = $iTargetC;
        } else {
            my ($newR, $newC) = @{turn_right([$hGuard{"dir"}{"r"}, $hGuard{"dir"}{"c"}])};
            $hGuard{"dir"} = { "r" => $newR, "c" => $newC };
        }
    }

    return scalar(keys %hSeen);
}


sub part2 {
    my ($self, $sInput) = @_;
    my %hGuard = (
        "pos" => { "r" => -1, "c" => -1 },
        "dir" => { "r" => -1, "c" => 0 },  # Starting direction (up)
    );    
    my @aaWalkable;
    my @aLines = split(/\n/, $sInput);
    for my $ir ( 0 .. scalar(@aLines) - 1 ) {
        my @aRow = split(//, $aLines[$ir]);
        my @aWalkable;
        for my $ic ( 0 .. scalar(@aRow) - 1 ) {
            if ($aRow[$ic] eq '^') {
                $hGuard{"pos"} = { "r" => $ir, "c" => $ic };
                push(@aWalkable, 1);
            } else {
                my $bWalkable = ($aRow[$ic] eq '#') ? 0 : 1;
                push(@aWalkable, $bWalkable);
            }
        }
        push(@aaWalkable, [@aWalkable]);
    }

    my $iRows = scalar(@aaWalkable);
    my $iCols = scalar(@{$aaWalkable[0]});
    my $iObstructionPositions = 0;
    for my $ir ( 0 .. $iRows - 1 ) {
        for my $ic ( 0 .. $iCols - 1 ) {
            next if (!$aaWalkable[$ir]->[$ic]);
            next if ($ir == $hGuard{"pos"}{"r"} && $ic == $hGuard{"pos"}{"c"});
            my %hHare = (
                "pos"   => { "r" => $hGuard{"pos"}{"r"}, "c" => $hGuard{"pos"}{"c"} },
                "dir"   => { "r" => $hGuard{"dir"}{"r"}, "c" => $hGuard{"dir"}{"c"} },
                "walks" => 0,
            );
            my %hTortoise = (
                "pos" => { "r" => $hGuard{"pos"}{"r"}, "c" => $hGuard{"pos"}{"c"} },
                "dir" => { "r" => $hGuard{"dir"}{"r"}, "c" => $hGuard{"dir"}{"c"} },
                "shouldWalk" => 0, 
            );
            $aaWalkable[$ir]->[$ic] = 0; # Place the obstruction
            while ($hHare{"pos"}{"r"} >= 0 && $hHare{"pos"}{"r"} < $iRows
                && $hHare{"pos"}{"c"} >= 0 && $hHare{"pos"}{"c"} < $iCols) {
                my $iTargetR = $hHare{"pos"}{"r"} + $hHare{"dir"}{"r"};
                my $iTargetC = $hHare{"pos"}{"c"} + $hHare{"dir"}{"c"};
                last if ($iTargetR < 0 || $iTargetR >= $iRows || $iTargetC < 0 || $iTargetC >= $iCols);
                my $bTargetWalkable = $aaWalkable[$iTargetR]->[$iTargetC];
                if ($bTargetWalkable) {
                    $hHare{"pos"}{"r"} = $iTargetR;
                    $hHare{"pos"}{"c"} = $iTargetC;
                    $hHare{"walks"}++;
                    $hTortoise{"shouldWalk"} = 1 if ($hHare{"walks"} % 2 == 0);
                } else {
                    my ($newR, $newC) = @{turn_right([$hHare{"dir"}{"r"}, $hHare{"dir"}{"c"}])};
                    $hHare{"dir"} = { "r" => $newR, "c" => $newC };
                    redo;
                }

                # Detect loop...
                if ($hHare{"pos"}{"r"} == $hTortoise{"pos"}{"r"} && $hHare{"pos"}{"c"} == $hTortoise{"pos"}{"c"} 
                 && $hHare{"dir"}{"r"} == $hTortoise{"dir"}{"r"} && $hHare{"dir"}{"c"} == $hTortoise{"dir"}{"c"}) {
                    $iObstructionPositions++;
                    last;
                }

                while ($hTortoise{"shouldWalk"}) {
                    $iTargetR = $hTortoise{"pos"}{"r"} + $hTortoise{"dir"}{"r"};
                    $iTargetC = $hTortoise{"pos"}{"c"} + $hTortoise{"dir"}{"c"};
                    $bTargetWalkable = $aaWalkable[$iTargetR]->[$iTargetC];
                    if ($bTargetWalkable) {
                        $hTortoise{"pos"}{"r"} = $iTargetR;
                        $hTortoise{"pos"}{"c"} = $iTargetC;
                        $hTortoise{"shouldWalk"} = 0;
                    } else {
                        my ($newR, $newC) = @{turn_right([$hTortoise{"dir"}{"r"}, $hTortoise{"dir"}{"c"}])};
                        $hTortoise{"dir"} = { "r" => $newR, "c" => $newC };
                    }
                }
            }
            $aaWalkable[$ir]->[$ic] = 1; # Remove the obstruction
        } 
    }

    return $iObstructionPositions;
}

1;
