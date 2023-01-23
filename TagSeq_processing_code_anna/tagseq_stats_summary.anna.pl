#!/usr/bin/perl

my $stats_dir=$ARGV[0] || './trimmed';
my $stats_file=$ARGV[1] || 'trim_stats.txt';
my $sample_pattern=$ARGV[2] || '_S\d+.*';
my $verbose=$ARGV[3] || 0;

my $trim_stats="$stats_dir/$stats_file";
my $out_file1="$stats_dir/all.tagseq_summary_stats.tsv";
my $out_file2="$stats_dir/all.sample_results.tsv";

print STDERR "tagseq_stats_summary.anna.pl\n";
print STDERR "  trimmed directory:   '$stats_dir'\n";
print STDERR "  trimmed stats file:  '$stats_file'\n";
print STDERR "  sample name pattern: '$sample_pattern'\n";
print STDERR "  output file1:        '$out_file1'\n";
print STDERR "  output file2:        '$out_file2'\n";
print STDERR "  verbose:             $verbose\n";

sub readFileLine {
  my ($path) = @_;
  my @lines = ();
  open my $fh, $path or die "Cannot open file '$path'\n";
  return <$fh>;
}

open(INP,  '<', $trim_stats)  or die "Cannot open file '$trim_stats' for input\n";
open(OUT1, '>', "$out_file1") or die "Cannot open $out_file1 for output\n";
open(OUT2, '>', "$out_file2") or die "Cannot open $out_file2 for output\n";
print OUT1 "Name\tFinal\tDuplicates\tNo_Header\tN_in_Header\tNum_Clipped\tNum_Quality_Filtered\n";
print OUT2 "Sample\tM_Orig\tM_Trim\tPct_Trim\n";
my %samps_orig; my %samps_trim;
while (<INP>) {
  next unless $_ =~/goods/;
  chomp($_); @F = split(/\t/, $_);
  my ($infile, $tot, $good, $dups, $noHdr, $nHdr) = @F;
  my $pfx=$infile;
  $pfx=~s/[.]gz//; $pfx=~s/[.]fq//; $pfx=~s/[.]fastq//; $pfx=~s/_001//;
  $samp=$pfx; $samp=~s/$sample_pattern//;
  print STDERR "$infile - $pfx\t$samp\n" if $verbose;
  $tot=~s/total[:]//;
  $good=~s/goods[:]//;
  $dups=~s/dups[:]//;
  $noHdr=~s/noheader[:]//;
  $nHdr=~s/N[.]in[.]header[:]//;
  my $sum1 = $good + $dups + $noHdr + $nHdr;
  die("$pfx: Sum1 $sum1 should equal total input sequences $tot") unless $sum1 == $tot;

  my $clipped  = readFileLine("$stats_dir/$pfx.clipped.txt");
  my $qualFilt = readFileLine("$stats_dir/$pfx.qualfilt.txt") if -e "$stats_dir/$pfx.qualfilt.txt";
  $clipped   = $1 if $clipped =~/ (\d+)$/;
  $qualFilt  = $qualFilt =~/ (\d+)$/ ? $1 : $clipped;
  my $final  = $qualFilt;
  my $nClip  = $good - $clipped;
  my $nQfilt = $clipped - $qualFilt;
  my $sum2   = $good - ($nClip + $nQfilt);
  my $sum3   = $final+ $dups + $noHdr + $nHdr + $nClip + $nQfilt;
  #print STDERR join(",", $tot, $good, $dups, $noHdr, $nHdr, $clipped, $qualFilt, $nClip, $nQfilt, $final, $sum2, $sum3), "\n";
  die("$pfx: Sum2 $sum2 should equal final input sequences $final") unless $sum2 == $final;
  die("$pfx: Sum3 $sum3 should equal total input sequences $tot") unless $sum3 == $tot;

  print OUT1 "${pfx}.trim\t$final\t$dups\t$noHdr\t$nHdr\t$nClip\t$nQfilt\n";
  $samps_orig{$samp} += $tot; $samps_trim{$samp} += $final;
}
foreach my $key (sort keys(%samps_orig)) {
  my $pct = 0;
  $pct = 100 * $samps_trim{$key}/$samps_orig{$key} if $samps_orig{$key};
  print OUT2 "$key\t$samps_orig{$key}\t$samps_trim{$key}\t$pct\n" if $key;
}
close INP; close OUT1; close OUT2;

print STDERR "tagseq_stats-summary.anna.pl complete!\n";


