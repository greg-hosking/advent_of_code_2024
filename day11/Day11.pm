package Day11;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub part1 {
    my ($self, $sInput) = @_;
    return partN($self, $sInput, 25);
}

sub part2 {
    my ($self, $sInput) = @_;
    return partN($self, $sInput, 75);
}

sub partN {
    my ($self, $sInput, $iBlinks) = @_;
    chomp $sInput;

    my %hStones;
    $hStones{int($_)} = 1 for split / /, $sInput;

    for (1..$iBlinks) {
        %hStones = %{blink(\%hStones)};
    }

    return sum(values %hStones);
}

sub blink {
    my ($phStones) = @_;
    my %hNewStones;
    for my $sKey (keys %$phStones) {
        my $iVal = $phStones->{$sKey};
        my $iKey = int($sKey);
        my $iKeyLen = length($sKey);
        if ($iKey == 0) {
            $hNewStones{1} += $iVal;
        } elsif ($iKeyLen % 2 == 0) {
            my $iHalf = $iKeyLen / 2;
            $hNewStones{int(substr($sKey, 0, $iHalf))} += $iVal;
            $hNewStones{int(substr($sKey, $iHalf))} += $iVal;
        } else {
            $hNewStones{int($iKey * 2024)} += $iVal;
        }
    }
    return \%hNewStones;
}

sub sum {
    my @aValues = @_;
    my $iSum = 0;
    $iSum += $_ for @aValues;
    return $iSum;
}

# sub partNNaive {
#     my ($self, $sInput, $iBlinks) = @_;
#     chomp $sInput;
#     my @aStones = split(/ /, $sInput);
#     for (my $ii = 0; $ii < $iBlinks; $ii++) {
#         my @aStonesTemp;
#         foreach my $iStone (@aStones) {
#             my $iDigits = length($iStone);
#             if ($iStone == 0) {
#                 push(@aStonesTemp, 1);
#             } elsif ($iDigits % 2 == 0) {
#                 push(@aStonesTemp, int(substr($iStone, 0, $iDigits / 2)));
#                 push(@aStonesTemp, int(substr($iStone, $iDigits / 2)));
#             } else {
#                 push(@aStonesTemp, $iStone * 2024);
#             }
#         }
#         @aStones = @aStonesTemp;
#     }    
#     return scalar(@aStones);
# }

# sub partNRecurNaive {
#     my ($self, $sInput, $iBlinks) = @_;
#     chomp $sInput;
#     my @aStones; 
#     foreach my $iValue (split(/ /, $sInput)) {
#         blinkNaive($iValue, $iBlinks, \@aStones);
#     }
#     return scalar(@aStones);
# }

# sub blinkNaive {
#     my ($iValue, $iBlinks, $paStones) = @_;
#     if ($iBlinks == 0) {
#         push(@$paStones, $iValue);
#         return;
#     }
#     if ($iValue == 0) {
#         blinkNaive(1, $iBlinks - 1, $paStones);
#         return;
#     }
#     my $iDigits = length($iValue);
#     if ($iDigits % 2 == 0) {
#         blinkNaive(int(substr($iValue, 0, $iDigits / 2)), $iBlinks - 1, $paStones);
#         blinkNaive(int(substr($iValue, $iDigits / 2)), $iBlinks - 1, $paStones);
#         return;
#     } 
#     blinkNaive($iValue * 2024, $iBlinks - 1, $paStones);
# }

# sub partNRecurOblivious {
#     my ($self, $sInput, $iBlinks) = @_;
#     chomp $sInput;
#     my $iStones = 0;
#     foreach my $iValue (split(/ /, $sInput)) {
#         $iStones += blinkOblivious($iValue, $iBlinks);
#     }
#     return $iStones;
# }

# sub blinkOblivious {
#     my ($iValue, $iBlinks) = @_;
#     if ($iBlinks == 0) {
#         return 1;
#     }
#     if ($iValue == 0) {
#         return blinkOblivious(1, $iBlinks - 1);
#     }
#     my $iDigits = length($iValue);
#     if ($iDigits % 2 == 0) {
#         return blinkOblivious(int(substr($iValue, 0, $iDigits / 2)), $iBlinks - 1) + blinkOblivious(int(substr($iValue, $iDigits / 2)), $iBlinks - 1);
#     } 
#     return blinkOblivious($iValue * 2024, $iBlinks - 1);
# }

1;
