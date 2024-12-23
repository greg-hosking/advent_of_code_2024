package Day22;

use strict;
use warnings;
use lib 'C:\advent_of_code_2024';
use parent 'Day';

use Data::Dumper;

sub part1 {
    my ($self, $sInput) = @_;
    my @aSecrets = split(/\n/, $sInput);
    for (1..2000) {
        foreach my $iSecret (@aSecrets) {
            $iSecret = $iSecret ^ ($iSecret * 64);
            $iSecret = $iSecret % 16777216;
            $iSecret = $iSecret ^ int($iSecret / 32);
            $iSecret = $iSecret % 16777216;
            $iSecret = $iSecret ^ ($iSecret * 2048);
            $iSecret = $iSecret % 16777216;
        }
    }
    my $iSum = 0;
    foreach my $iSecret (@aSecrets) {
        $iSum += $iSecret;
    }
    return $iSum;
}

sub part2 {
    my ($self, $sInput) = @_;
    my @aSecrets = split(/\n/, $sInput);
    my %hSequences;
    foreach my $iSecret (@aSecrets) {
        my @aPrices = ($iSecret);
        my @aChanges;
        for (1..2000) {
            my ($iPrice) = $iSecret =~ /.*(\d)/;
            $iSecret = $iSecret ^ ($iSecret * 64);
            $iSecret = $iSecret % 16777216;
            $iSecret = $iSecret ^ int($iSecret / 32);
            $iSecret = $iSecret % 16777216;
            $iSecret = $iSecret ^ ($iSecret * 2048);
            $iSecret = $iSecret % 16777216;
            my ($iPriceNew) = $iSecret =~ /.*(\d)/;
            push(@aPrices, $iPriceNew);
            push(@aChanges, $iPriceNew - $iPrice);
        }
        my %hSeqs;
        for (my $ii = 3; $ii < scalar(@aChanges); $ii++) {
            my $sSeq = join(",", @aChanges[($ii - 3)..$ii]);
            $hSeqs{$sSeq} = $aPrices[$ii + 1] if (!exists $hSeqs{$sSeq});
        }
        foreach my ($sSeq, $iPrice) (%hSeqs) {
            $hSequences{$sSeq} += $iPrice;
        }
    }
    my $iMax = 0;
    foreach my $iPrice (values %hSequences) {
        $iMax = $iPrice if ($iPrice > $iMax);
    }
    return $iMax;
}

1;
