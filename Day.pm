package Day;

use strict;
use warnings;

# Constructor to initialize the solution with an input file
sub new {
    my ($class, %args) = @_;
    my $self = {
        input_file => $args{input_file},  # Path to the input file for the day
    };
    bless $self, $class;
    return $self;
}

# sub part1 {}

# sub part2 {}

1;
