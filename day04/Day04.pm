package Day04;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

sub part1 {
    my ( $self, $sInput ) = @_;
    my @aaGrid;
    foreach my $sLine ( split( /\n/, $sInput ) ) {
        my @asRow = split( //, $sLine );
        push( @aaGrid, [@asRow] );
    }

    my $sWord    = "XMAS";
    my $sWordRev = reverse($sWord);
    my $iCount   = 0;

    # Check rows
    foreach my $pasRow (@aaGrid) {
        my $sRow     = join( '', @$pasRow );
        my @aiMatches = $sRow =~ m/(?=$sWord)|(?=$sWordRev)/g;
        $iCount += scalar(@aiMatches);
    }

    # Check columns
    my $iRows = scalar(@aaGrid);
    my $iCols = scalar( @{ $aaGrid[0] } );
    for my $iCol ( 0 .. $iCols - 1 ) {
        my $sCol = "";
        for my $iRow ( 0 .. $iRows - 1 ) {
            $sCol .= $aaGrid[$iRow]->[$iCol];
        }
        my @aiMatches = $sCol =~ m/(?=$sWord)|(?=$sWordRev)/g;
        $iCount += scalar(@aiMatches);
    }

    # Check diagonals: down-and-to-the-right
    for my $iStartRow ( 0 .. $iRows - 1 ) {
        my ( $iRow, $iCol ) = ( $iStartRow, 0 );
        my $sDiag = "";
        while ( $iRow < $iRows && $iCol < $iCols ) {
            $sDiag .= $aaGrid[$iRow++]->[$iCol++];
        }
        my @aiMatches = $sDiag =~ m/(?=$sWord)|(?=$sWordRev)/g;
        $iCount += scalar(@aiMatches);
    }
    for my $iStartCol ( 1 .. $iCols - 1 ) {
        my ( $iRow, $iCol ) = ( 0, $iStartCol );
        my $sDiag = "";
        while ( $iRow < $iRows && $iCol < $iCols ) {
            $sDiag .= $aaGrid[$iRow++]->[$iCol++];
        }
        my @aiMatches = $sDiag =~ m/(?=$sWord)|(?=$sWordRev)/g;
        $iCount += scalar(@aiMatches);
    }

    # Check diagonals: down-and-to-the-left
    for my $iStartRow ( 0 .. $iRows - 1 ) {
        my ( $iRow, $iCol ) = ( $iStartRow, $iCols - 1 );
        my $sDiag = "";
        while ( $iRow < $iRows && $iCol >= 0 ) {
            $sDiag .= $aaGrid[$iRow++]->[$iCol--];
        }
        my @aiMatches = $sDiag =~ m/(?=$sWord)|(?=$sWordRev)/g;
        $iCount += scalar(@aiMatches);
    }
    for my $iStartCol ( 0 .. $iCols - 2 ) {
        my ( $iRow, $iCol ) = ( 0, $iStartCol );
        my $sDiag = "";
        while ( $iRow < $iRows && $iCol >= 0 ) {
            $sDiag .= $aaGrid[$iRow++]->[$iCol--];
        }
        my @aiMatches = $sDiag =~ m/(?=$sWord)|(?=$sWordRev)/g;
        $iCount += scalar(@aiMatches);
    }

    return $iCount;
}

sub part2 {
    my ($self, $sInput) = @_;
    my @aaGrid;
    foreach my $sLine ( split( /\n/, $sInput ) ) {
        my @asRow = split( //, $sLine );
        push( @aaGrid, [@asRow] );
    }

    my $sWord    = "MAS";
    my $sWordRev = reverse($sWord);
    my $iCount   = 0;

    my $iRows = scalar(@aaGrid);
    my $iCols = scalar( @{ $aaGrid[0] } );

    # Assume grid at least 3x3
    my $iRowStart = 1;
    my $iRowEnd   = $iRows - 2;
    my $iColStart = 1;
    my $iColEnd   = $iCols - 2;
    for my $iRow ( $iRowStart .. $iRowEnd ) {
        for my $iCol ( $iColStart .. $iColEnd ) {
            my $sDiagDownRight = $aaGrid[$iRow-1]->[$iCol-1] . $aaGrid[$iRow]->[$iCol] . $aaGrid[$iRow+1]->[$iCol+1];
            my $sDiagDownLeft  = $aaGrid[$iRow-1]->[$iCol+1] . $aaGrid[$iRow]->[$iCol] . $aaGrid[$iRow+1]->[$iCol-1];
            $iCount++ if ($sDiagDownRight =~ /$sWord|$sWordRev/ && $sDiagDownLeft =~ /$sWord|$sWordRev/);
        }
    }

    return $iCount;
}

1;
