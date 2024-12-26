package Day10;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

sub try_hike {
    my ($iPrevHeight, $iRow, $iCol, $paaGrid, $phVisited) = @_;

    my $iRows = scalar(@$paaGrid);
    my $iCols = scalar(@{$paaGrid->[0]});
    return 0 if ($iRow < 0 || $iRow >= $iRows || $iCol < 0 || $iCol >= $iCols);
    return 0 if (exists $phVisited->{"$iRow,$iCol"});
    $phVisited->{"$iRow,$iCol"} = 1;

    my $iHeight = $paaGrid->[$iRow]->[$iCol]; 
    return 0 if ($iHeight != $iPrevHeight + 1);
    return 1 if ($iPrevHeight == 8 && $iHeight == 9);

    return try_hike($iHeight, $iRow - 1, $iCol, $paaGrid, $phVisited) + try_hike($iHeight, $iRow + 1, $iCol, $paaGrid, $phVisited) + 
           try_hike($iHeight, $iRow, $iCol - 1, $paaGrid, $phVisited) + try_hike($iHeight, $iRow, $iCol + 1, $paaGrid, $phVisited); 
}

sub part1 {
    my ($self, $sInput) = @_;

    my @aaGrid;
    foreach my $sRow (split(/\n/, $sInput)) {
        push(@aaGrid, [split(//, $sRow)]);
    }

    my $iRows = scalar(@aaGrid);
    my $iCols = scalar(@{$aaGrid[0]});
    my $iSum = 0;
    for my $iR (0..$iRows - 1) {
        for my $iC (0..$iCols - 1) {
            if ($aaGrid[$iR]->[$iC] == 0) {
                my %hVisited = ();
                $iSum += try_hike(-1, $iR, $iC, \@aaGrid, \%hVisited);
            }
        }
    }

    return $iSum;
}

# sub part2 {
#     my ($self, $sInput) = @_;
#     # Solution...
# }

1;
