package Day15;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub translate_move {
    my ($sChar) = @_;
    return (-1, 0) if ($sChar) eq "^";
    return (1, 0)  if ($sChar) eq "v";
    return (0, -1) if ($sChar) eq "<";
    return (0, 1)  if ($sChar) eq ">";
}

sub part1 {
    my ($self, $sInput) = @_;
    chomp $sInput;

    my @aaGrid;
    my @aMovements;
    foreach my $sLine (split(/\n/, $sInput)) {
        next if ($sLine eq "\n");
        if ($sLine =~ /^#/) {
            push(@aaGrid, [split(//, $sLine)])
        } else {
            push(@aMovements, split(//, $sLine));
        }
    }

    my %hRobot;
    for (my $ii = 0; $ii < scalar(@aaGrid); $ii++) {
        for (my $ij = 0; $ij < scalar(@{$aaGrid[$ii]}); $ij++) {
            if ($aaGrid[$ii]->[$ij] eq "@") {
                $hRobot{r} = $ii;
                $hRobot{c} = $ij;
            }
        }
    }

    foreach my $sMove (@aMovements) {
        my ($iDR, $iDC) = translate_move($sMove);
        my $sTarget = $aaGrid[$hRobot{r} + $iDR]->[$hRobot{c} + $iDC];
        next if ($sTarget eq "#");
        if ($sTarget eq ".") {
            $aaGrid[$hRobot{r}]->[$hRobot{c}] = ".";
            $hRobot{r} += $iDR;
            $hRobot{c} += $iDC;
            $aaGrid[$hRobot{r}]->[$hRobot{c}] = "@";
        } else {
            # Look for an empty space...
            my $iR = $hRobot{r} + $iDR;
            my $iC = $hRobot{c} + $iDC;
            my $bCanMove = 0;
            while (1) {
                $iR += $iDR;
                $iC += $iDC;
                $sTarget = $aaGrid[$iR]->[$iC];
                last if ($sTarget eq "#");
                if ($sTarget eq ".") {
                    $bCanMove = 1;
                    last;
                }
            }
            next if (!$bCanMove);
            while ($iR != $hRobot{r} || $iC != $hRobot{c}) {
                $aaGrid[$iR]->[$iC] = $aaGrid[$iR - $iDR]->[$iC - $iDC];
                $iR -= $iDR;
                $iC -= $iDC;
            }
            $aaGrid[$iR]->[$iC] = ".";
            $hRobot{r} = $iR + $iDR;
            $hRobot{c} = $iC + $iDC;
        }
    }

    my $iSum = 0;
    for (my $ii = 0; $ii < scalar(@aaGrid); $ii++) {
        for (my $ij = 0; $ij < scalar(@{$aaGrid[$ii]}); $ij++) {
            $iSum += (100 * $ii) + $ij if ($aaGrid[$ii]->[$ij] eq "O");
        }
    }

    return $iSum;
}

# sub part2 {
#     my ($self, $sInput) = @_;
#     # Solution...
# }

1;
