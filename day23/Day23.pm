package Day23;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

sub part1 {
    my ($self, $sInput) = @_;
    my %hLAN;

    foreach my $sLine (split(/\n/, $sInput)) {
        my ($sPc1, $sPc2) = split("-", $sLine);
        $hLAN{$sPc1}{$sPc2} = 1;
        $hLAN{$sPc2}{$sPc1} = 1;
    }

    my %hSets;
    foreach my $sPc1 (keys %hLAN) {
        foreach my $sPc2 (keys %{ $hLAN{$sPc1} }) {
            next if $sPc1 eq $sPc2;
            foreach my $sPc3 (keys %{ $hLAN{$sPc2} }) {
                next if $sPc3 eq $sPc1 || $sPc3 eq $sPc2;
                if (exists $hLAN{$sPc3}{$sPc1}) {
                    my $sSet = join(",", sort ($sPc1, $sPc2, $sPc3));
                    $hSets{$sSet} = 1 if ($sSet =~ /\bt\S*/);
                }
            }
        }
    }

    return scalar(keys %hSets);
}

# sub part2 {
#     my ($self, $sInput) = @_;
#     # Solution...
# }

1;
