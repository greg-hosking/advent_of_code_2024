package Day12;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub check_neighbors {
    my ($iRow, $iCol, $paaGarden, $phRegion, $phChecked) = @_;

    $phChecked->{"$iRow,$iCol"} = 1;
    
    my %hNeighbors = (
        "-1,0" => 1,
        "1,0"  => 1,
        "0,-1" => 1,
        "0,1"  => 1,
    );
    my $iNeighbors = 4;
    foreach my $sKey (keys %hNeighbors) {
        my ($iRowDiff, $iColDiff) = split(/,/, $sKey);
        my $iNeighborRow = $iRow + $iRowDiff;
        my $iNeighborCol = $iCol + $iColDiff;
        if ($iNeighborRow < 0 || $iNeighborRow > scalar(@$paaGarden) - 1 || 
            $iNeighborCol < 0 || $iNeighborCol > scalar(@{$paaGarden->[0]}) - 1 ||
            $paaGarden->[$iNeighborRow]->[$iNeighborCol] ne $paaGarden->[$iRow]->[$iCol]) {
            $hNeighbors{$sKey} = 0;
            $iNeighbors--;
        } else {
            next if (exists $phChecked->{"$iNeighborRow,$iNeighborCol"});
            check_neighbors($iNeighborRow, $iNeighborCol, $paaGarden, $phRegion, $phChecked);
        }
    }
    
    $phRegion->{"$iRow,$iCol"}  = $iNeighbors;
}

sub part1 {
    my ($self, $sInput) = @_;
    
    my @aaGarden;
    foreach my $sRow (split(/\n/, $sInput)) {
        push(@aaGarden, [split(//, $sRow)]);
    }
    
    my @ahRegions;
    my %hChecked;
    for (my $iRow = 0; $iRow < scalar(@aaGarden); $iRow++) {
        for (my $iCol = 0; $iCol < scalar(@{$aaGarden[$iRow]}); $iCol++) {
            next if (exists $hChecked{"$iRow,$iCol"});
            my %hRegion;
            check_neighbors($iRow, $iCol, \@aaGarden, \%hRegion, \%hChecked);
            push(@ahRegions, \%hRegion);
        }
    }

    my $iTotal = 0;
    foreach my $phRegion (@ahRegions) {
        my $iArea = scalar(keys %$phRegion);
        my $iPerim = $iArea * 4;
        foreach my $iNeighbors (values %$phRegion) {
            $iPerim -= $iNeighbors;
        }
        $iTotal += ($iArea * $iPerim);
    }

    return $iTotal;
}

# sub part2 {
#     my ($self, $sInput) = @_;
#     # Solution...
# }

1;
