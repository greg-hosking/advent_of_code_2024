package Day02;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

sub part1 {
    my ($self, $sInput) = @_;

    foreach my $sLine (split(/\n/, $sInput)) {
        print "$sLine\n";
    }

    return -1;
}

# sub part2 {

# }

1;
