package Day09;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub part1 {
    my ($self, $sInput) = @_;

    my @aDisk;
    my @aDigits = split(//, $sInput);
    for (my $ii = 0; $ii < scalar(@aDigits); $ii++) {
        my $iId = ($ii % 2 == 0) ? $ii / 2 : ".";
        for (my $ij = 0; $ij < $aDigits[$ii]; $ij++) {
            push(@aDisk, $iId);
        }
    }

    # TODO: what if "file" size is 0...?

    print "Input: $sInput\n";
    print "Disk:  " . join("", @aDisk) . "\n";

    return -1;
}


# sub part2 {
#     my ($self, $sInput) = @_;
#     # Solution...
# }

1;
