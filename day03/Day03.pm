package Day03;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

sub part1 {
    my ($self, $sInput) = @_;
    my @aMatches = $sInput =~ m/mul\(\d+,\d+\)/g;
    my $iSum = 0;
    foreach my $sMatch (@aMatches) {
        if ($sMatch =~ m/mul\((\d+),(\d+)\)/) {
            $iSum += ($1 * $2);
        }
    }
    return $iSum;
}

# sub part2 {
# }

1;
