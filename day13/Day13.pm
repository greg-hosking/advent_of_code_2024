package Day13;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub part1 {
    my ($self, $sInput) = @_;
    chomp $sInput;

    my @aLines = split(/\n/, $sInput);
    my @aMachines;
    for (my $ii = 0; $ii < scalar(@aLines); $ii += 4) {
        my %hMachine;
        if ($aLines[$ii] =~ /Button A: X\+(.*), Y\+(.*)/) {
            $hMachine{a}{x} = $1;
            $hMachine{a}{y} = $2;            
        }
        if ($aLines[$ii + 1] =~ /Button B: X\+(.*), Y\+(.*)/) {
            $hMachine{b}{x} = $1;
            $hMachine{b}{y} = $2;
        }
        if ($aLines[$ii + 2] =~ /Prize: X=(.*), Y=(.*)/) {
            $hMachine{prize}{x} = $1;
            $hMachine{prize}{y} = $2;
        }
        push(@aMachines, \%hMachine);
    }
    
    my $iTokens = 0;
    foreach my $phMachine (@aMachines) {
        my $bPossible = 0;
        for my $iA (0..100) {
            for my $iB (0..100) {
                my $iX = ($phMachine->{a}->{x} * $iA) + ($phMachine->{b}->{x} * $iB);
                my $iY = ($phMachine->{a}->{y} * $iA) + ($phMachine->{b}->{y} * $iB);
                if ($iX == $phMachine->{prize}->{x} && $iY == $phMachine->{prize}->{y}) {
                    $iTokens += (3 * $iA) + $iB;
                    $bPossible = 1;
                    last;
                }
            }
            last if ($bPossible);
        }
    }

    return $iTokens;
}

# sub part2 {
#     my ($self, $sInput) = @_;
#     chomp $sInput;

#     my @aLines = split(/\n/, $sInput);
#     my @aMachines;
#     for (my $ii = 0; $ii < scalar(@aLines); $ii += 4) {
#         my %hMachine;
#         if ($aLines[$ii] =~ /Button A: X\+(.*), Y\+(.*)/) {
#             $hMachine{a}{x} = $1;
#             $hMachine{a}{y} = $2;            
#         }
#         if ($aLines[$ii + 1] =~ /Button B: X\+(.*), Y\+(.*)/) {
#             $hMachine{b}{x} = $1;
#             $hMachine{b}{y} = $2;
#         }
#         if ($aLines[$ii + 2] =~ /Prize: X=(.*), Y=(.*)/) {
#             $hMachine{prize}{x} = $1 + 10000000000000;
#             $hMachine{prize}{y} = $2 + 10000000000000;
#         }
#         push(@aMachines, \%hMachine);
#     }
    
#     my $iTokens = 0;
#     foreach my $phMachine (@aMachines) {
#         my $bPossible = 0;
#         for my $iA (reverse 10000..1000000) {
#             for my $iB (reverse 10000..1000000) {
#                 my $iX = ($phMachine->{a}->{x} * $iA) + ($phMachine->{b}->{x} * $iB);
#                 my $iY = ($phMachine->{a}->{y} * $iA) + ($phMachine->{b}->{y} * $iB);
#                 if ($iX == $phMachine->{prize}->{x} && $iY == $phMachine->{prize}->{y}) {
#                     $iTokens += (3 * $iA) + $iB;
#                     $bPossible = 1;
#                     last;
#                 }
#             }
#             last if ($bPossible);
#         }
#     }

#     return $iTokens;
# }
1;
