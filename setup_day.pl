#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;
use File::Path qw(make_path);

sub main {
    my $iDay;
    GetOptions('day=i' => \$iDay) or die "Usage: setup_day --day=<day_number>\n";
    die "Usage: setup_day --day=<day_number>\n" unless defined $iDay;

    my $sDayDir = sprintf("day%02d", $iDay);
    my $sModuleFile = "$sDayDir/Day" . sprintf("%02d", $iDay) . ".pm";
    my $sExamplePart1 = "$sDayDir/example_part1.txt";
    my $sExamplePart2 = "$sDayDir/example_part2.txt";

    # Create the directory
    make_path($sDayDir) or die "Error creating directory $sDayDir: does it already exist?\n";

    # Create the Perl module file
    open my $fhModule, '>', $sModuleFile or die "Error creating file $sModuleFile: $!\n";
    print $fhModule <<"MODULE";
package Day${\sprintf("%02d", $iDay)};

use strict;
use warnings;
use lib 'C:\\advent_of_code_2024';
use parent 'Day';

# sub part1 {
#     my (\$self, \$sInput) = \@_;
#     # Solution...
# }

# sub part2 {
#     my (\$self, \$sInput) = \@_;
#     # Solution...
# }

1;
MODULE
    close $fhModule;

    # Create example_part1.txt
    open my $fhExample1, '>', $sExamplePart1 or die "Error creating file $sExamplePart1: $!\n";
    print $fhExample1 "# Input:\nexample_input_here\n# Output:\nexample_output_here";
    close $fhExample1;

    # Create example_part2.txt
    open my $fhExample2, '>', $sExamplePart2 or die "Error creating file $sExamplePart2: $!\n";
    print $fhExample2 "# Input:\nexample_input_here\n# Output:\nexample_output_here";
    close $fhExample2;

    print "[SUCCESS] Created files for day $iDay in $sDayDir\n";
}

main();
