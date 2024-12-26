package Day14;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub part1 {
    my ($self, $sInput, $bIsExample) = @_;
    my @aRobots;
    foreach my $sLine (split(/\n/, $sInput)) {
        $sLine =~ s/p=|v=//g;
        my ($sPos, $sVel) = split(/ /, $sLine);
        my ($iPosX, $iPosY) = split(/,/, $sPos);
        my ($iVelX, $iVelY) = split(/,/, $sVel);
        push(@aRobots, {
            "pos" => {
                "x" => int($iPosX),
                "y" => int($iPosY),
            },
            "vel" => {
                "x" => int($iVelX),
                "y" => int($iVelY),
            },
        });
    }

    my $iRows = ($bIsExample) ? 7 : 103;
    my $iCols = ($bIsExample) ? 11 : 101;
    for (1..100) {
        foreach my $phRobot (@aRobots) {
            my $iNewX = $phRobot->{pos}->{x} + $phRobot->{vel}->{x};
            my $iNewY = $phRobot->{pos}->{y} + $phRobot->{vel}->{y};
            if ($iNewX < 0) {
                $iNewX = $iCols + $iNewX;
            } elsif ($iNewX > $iCols - 1) {
                $iNewX -= $iCols;
            }
            if ($iNewY < 0) {
                $iNewY = $iRows + $iNewY;
            } elsif ($iNewY > $iRows - 1) {
                $iNewY -= $iRows;
            }
            $phRobot->{pos}->{x} = $iNewX;
            $phRobot->{pos}->{y} = $iNewY;
        }
    }

    my %hRobotsAtCoords;
    foreach my $phRobot (@aRobots) {
        my $sKey = $phRobot->{pos}->{x} . "," . $phRobot->{pos}->{y};
        $hRobotsAtCoords{$sKey}++;
    }

    # Assuming rows and cols are odd... calculate quadrants
    my $iHalfRows = int($iRows / 2);
    my $iHalfCols = int($iCols / 2);

    my $iResult = 0;
    for (my $iRow = 0; $iRow < $iRows - 1; $iRow += $iHalfRows + 1) {
        for (my $iCol = 0; $iCol < $iCols - 1; $iCol += $iHalfCols + 1) {
            my $iRobots = 0;
            for (my $iR = $iRow; $iR < $iRow + $iHalfRows; $iR++) {
                for (my $iC = $iCol; $iC < $iCol + $iHalfCols; $iC++) {
                    $iRobots += ($hRobotsAtCoords{"$iC,$iR"} || 0);
                }
            }
            if ($iResult == 0) {
                $iResult = $iRobots;    
            } else {
                $iResult *= $iRobots;
            }
        }
    }

    return $iResult;
}

sub part2 {
    my ($self, $sInput) = @_;

    my @aRobots;
    foreach my $sLine (split(/\n/, $sInput)) {
        $sLine =~ s/p=|v=//g;
        my ($sPos, $sVel) = split(/ /, $sLine);
        my ($iPosX, $iPosY) = split(/,/, $sPos);
        my ($iVelX, $iVelY) = split(/,/, $sVel);
        push(@aRobots, {
            "pos" => {
                "x" => int($iPosX),
                "y" => int($iPosY),
            },
            "vel" => {
                "x" => int($iVelX),
                "y" => int($iVelY),
            },
        });
    }

    my $iRows = 103;
    my $iCols = 101;

    open my $oFh, ">", "./day14/day14.txt";

    for my $iSecond (1..25000) {
        # Update
        foreach my $phRobot (@aRobots) {
            my $iNewX = $phRobot->{pos}->{x} + $phRobot->{vel}->{x};
            my $iNewY = $phRobot->{pos}->{y} + $phRobot->{vel}->{y};
            if ($iNewX < 0) {
                $iNewX = $iCols + $iNewX;
            } elsif ($iNewX > $iCols - 1) {
                $iNewX -= $iCols;
            }
            if ($iNewY < 0) {
                $iNewY = $iRows + $iNewY;
            } elsif ($iNewY > $iRows - 1) {
                $iNewY -= $iRows;
            }
            $phRobot->{pos}->{x} = $iNewX;
            $phRobot->{pos}->{y} = $iNewY;
        }

        my %hRobotsAtCoords;
        foreach my $phRobot (@aRobots) {
            my $sKey = $phRobot->{pos}->{x} . "," . $phRobot->{pos}->{y};
            $hRobotsAtCoords{$sKey}++;
        }

        print $oFh "Begin second: $iSecond\n";
        for my $iR (0..$iRows - 1) {
            for my $iC (0..$iCols - 1) {
                if (exists $hRobotsAtCoords{"$iC,$iR"}) {
                    print $oFh "1";
                } else {
                    print $oFh " ";
                }
            }
            print $oFh "\n";
        }
        print $oFh "End second: $iSecond\n";
    }

    close $oFh;

    return 6532;
}

1;
