#!/usr/bin/perl

my $usage= "

tagseq_trim_launch.anna.pl :

Prints out a series of commands to trim Illumina tag-seq reads, one for each reads file
(e.g. tagseq_clipper.pl | fasx_clipper | fastx_quality_filter )

prints to STDOUT

Arguments:
1: Regular expression pattern to find Fastq files.
2: (optional) Position of name-deriving string in the file name
   if separated by underscores, such as input file
     Sample_RNA_2DVH_L002_R1.cat.fastq
   specifying arg2 as '3' would create output file with a name '2DVH.fastq'
3: (optional) Length of after-header substring to use for de-duplicating
   Default 32. Must be between 20 and 36.
4: (optional) Output directory. Default ./trimmed
5: (optional) Minimum quality score for quality filtering; if -1, no quality
   filtering is performed. Default 10.
6: (optional) Minimum sequence length that is retained after clipping.
   Default 20.

Example:
tagseq_trim_launch.anna.pl '\.fastq.gz$' > clean.sh

NOTE: use this script if your qualities in the fastq files are 33-based;
if not, use tagseq_trim_launch_bgi.pl instead

";

if (!$ARGV[0]) { die $usage;}
my $glob=$ARGV[0];
my $name_part=$ARGV[1] || 0;
my $dedup_strlen=$ARGV[2] || 32;
my $out_dir=$ARGV[3] || './trimmed';
my $minQ=$ARGV[4] || 10;
my $minLen=$ARGV[5] || 20;

opendir THIS, ".";
my @fqs=grep /$glob/,readdir THIS;
my $outname="";
$dedup_strlen=($dedup_strlen > 36 ? 36 :
  ($dedup_strlen < 20 ? 20 : $dedup_strlen));

print STDERR "tagseq_trim_launch.anna '$glob' $name_part $dedup_strlen $out_dir $minQ $minLen\n";
die "No files matching pattern '$glob' found" unless @fqs;

foreach $fqf (sort @fqs) {
  if ($name_part) {
    my @parts=split('_',$fqf);
    $pfx=$parts[$name_part-1];
    $outname="$pfx.trim.fastq";
  }
  else {
    $pfx=$fqf;
    $pfx=~s/[.]gz//; $pfx=~s/[.]fq//; $pfx=~s/[.]fastq//; $pfx=~s/_001//;
    $outname="$pfx.trim.fastq";
  }
  $outname=$outname.".gz" if $fqf =~/[.]gz$/;
  #print STDERR "pfx: $pfx ($outname)\n";
  # See
  #  https://superuser.com/questions/7448/can-the-output-of-one-command-be-piped-to-two-other-commands
  #  https://unix.stackexchange.com/questions/28503/how-can-i-send-stdout-to-multiple-commands
  my $cmd = "mkdir -p $out_dir; pfx=$pfx; tagseq_clipper.anna.pl $fqf '' 0 $dedup_strlen $out_dir ";
  $cmd = $cmd."| fastx_clipper -a AAAAAAAA -l $minLen -Q33 | fastx_clipper -a AGATCGGAAG -l $minLen -Q33 ";
  $cmd = $cmd."| tee >(wc -l | awk '{print \"$pfx\",\$1/4}' > $out_dir/$pfx.clipped.txt) ";
  if ($minQ > 0) {
    $cmd = $cmd."| fastq_quality_filter -Q33 -q $minQ -p 90 ";
    $cmd = $cmd."| tee >(wc -l | awk '{print \"$pfx\",\$1/4}' > $out_dir/$pfx.qualfilt.txt) ";
  }
  if ($outname =~/[.]gz$/) {
    $cmd = $cmd."| gzip -c >$out_dir/$outname\n";
  } else {
    $cmd = $cmd."| cat - >$out_dir/$outname\n";
  }
  print $cmd;
  #print "tagseq_clipper.pl $fqf | fastx_clipper -a AAAAAAAA -l 20 -Q33 | fastx_clipper -a AGATCGGAAG -l 20 -Q33 | fastq_quality_filter -Q33 -q 20 -p 90 >$outname\n";
}

