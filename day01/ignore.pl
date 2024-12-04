use strict;
use warnings;





sub main {


    my $sFn = $ARGV[0];
    
    open my $oFh, "<", $sFn or die "Nope!";
    
    while (my $sLine = <$oFh>) {
        chomp $sLine;
        print $sLine . "\n";
    }


    close $oFh;

    
    print $ARGV[0];


}


main();
