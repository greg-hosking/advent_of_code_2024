use strict;
use warnings;


sub main() {
    
    
    open my $oFh, "<", "./day01/input.txt" or die "Nope!";
    
    my @aNums1;
    my @aNums2;
    while (my $sLine = <$oFh>) {
        chomp $sLine;

        my ($part1, $part2) = split(/\s+/, $sLine);
        
        push (@aNums1, $part1);
        push (@aNums2, $part2);
    }
    close $oFh;


    @aNums1 = sort @aNums1;
    @aNums2 = sort @aNums2;

    my $sum = 0;
    for (my $i = 0; $i < scalar(@aNums1); $i++) {
        $sum += abs($aNums1[$i] - $aNums2[$i]);
    }    

    print "SUM: $sum\n";
}


main();
