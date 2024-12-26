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

    # print Dumper(\@aaGrid);
    # print Dumper(\@aMovements);

    foreach my $sMove (@aMovements) {
        my ($iDx, $iDy) = translate_move($sMove);
        print "$iDx, $iDy\n";
    }

    return -1;

}

# sub part2 {
#     my ($self, $sInput) = @_;
#     # Solution...
# }

1;
