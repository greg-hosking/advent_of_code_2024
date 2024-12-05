#!/usr/bin/perl
use strict;
use warnings;
use File::Path qw(make_path);
use File::Spec;

sub main {
    my $sCurrentDir = File::Spec->curdir();

    # Define the range of Advent of Code days
    my @aDays = map { sprintf("day%02d", $_) } (1..25);

    print "[INFO] Checking for missing day directories...\n";

    # Find missing day directories
    my @aMissingDays = grep { !-d File::Spec->catdir($sCurrentDir, $_) } @aDays;

    if (!@aMissingDays) {
        print "[SUCCESS] All day directories (day01 to day25) are present.\n";
        return;
    }

    print "[INFO] Missing days: ", join(", ", @aMissingDays), "\n";

    # Call setup_day for each missing day
    foreach my $sDay (@aMissingDays) {
        my ($iDay) = $sDay =~ /day(\d+)/;
        print "[INFO] Setting up $sDay...\n";
        system("perl setup_day.pl --day=$iDay") == 0
            or warn "[ERROR] Failed to set up $sDay. Check setup_day script.\n";
    }

    print "[SUCCESS] Finished setting up missing days.\n";
}

main();
