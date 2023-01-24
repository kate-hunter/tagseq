#!/usr/bin/perl

$usage= "

tagseq_clipper.anna.pl  :

Clips 5'-leader off Illumina fastq reads in RNA-seq

Removes duplicated reads sharing the same degenerate header and
the first 20 bases of the sequence (reads containing N bases in this
region are discarded, too)

prints to STDOUT

arguments:
1 : Fastq file name
2 : String to define the leading sequence
    default '[ATGC]?[ATGC][AC][AT][AT][AC][AT][ACT]GGG+|[ATGC]?[ATGC][AC][AT]GGG+|[ATGC]?[ATGC]TGC[AC][AT]GGG+|[ATGC]?[ATGC]GC[AT]TC[ACT][AC][AT]GGG+'
3 : (optional) Flag to say whether the sequences without leader should be kept.
    By default 0 (they are discarded).
4 : (optional) Length of after-header substring to use for de-duplicating (default 20).
5 : (optional) Duplicate histogram output directory. Default empty (no duplicate
    histogram files written).

Example:
tagseq_clipper.pl D6.fastq '' 0 25 ../fq.trim

";
# -----------------------------------------
# TagSeq UMIs
# -----------------------------------------
# name    sequence       pattern
# -----------------------------------------
# swMWWM  NNMWWMWHGGG    [ATGC]?[ATGC][AC][AT][AT][AC][AT][ACT]GGG+
# swGC    NNGCWTCHMWGGG  [ATGC]?[ATGC]GC[AT]TC[ACT][AC][AT]GGG+
# swTG    NNTGCMWGGG     [ATGC]?[ATGC]TGC[AC][AT]GGG+
# swMW    NNMWGGG        [ATGC]?[ATGC][AC][AT]GGG+
# -----------------------------------------
# M=AC (amino)
# W=AT (weak)
# H=ACT
# -----------------------------------------

my $fq=shift or die $usage;
my $pfx=$fq; $pfx=~s/[.]gz//; $pfx=~s/[.]fq//; $pfx=~s/[.]fastq//; $pfx=~s/_001//;
my $lead="";
my $keep=0;
if ($ARGV[0]) { $lead=$ARGV[0];}
else { $lead="[ATGC]?[ATGC][AC][AT][AT][AC][AT][ACT]GGG+|[ATGC]?[ATGC][AC][AT]GGG+|[ATGC]?[ATGC]TGC[AC][AT]GGG+|[ATGC]?[ATGC]GC[AT]TC[ACT][AC][AT]GGG+";}
if ($ARGV[1]) {$keep=1;}
my $substr_len=$ARGV[2] || 20;
my $out_dir=$ARGV[3];
my $trim=0;
my $name="";
my $name2="";
my $seq="";
my $qua="";
my %seen;
if ($fq =~ /\.gz$/) {
  open INP, "gzip -dc $fq |" or die "Cannot open file $fq for input\n";
} else {
  open INP, $fq or die "Cannot open file $fq for input\n";
}my $ll=3;
my $nohead=0;
my $dups=0;
my $ntag;
my $tot=0;
my $goods=0;
while (<INP>) {
  if ($ll==3 && $_=~/^(\@.+)$/ ) {
    $tot++;
    $name2=$1;
    if ($seq=~/^($lead)(.+)/) {
      my $start=substr($2,0,$substr_len);
      my $idtag=$1.$start;
      if (!$seen{$idtag} and $idtag!~/N/) {
        $seen{$idtag}=1;
        $trim=length($1);
        print "$name\n$2\n+\n",substr($qua,$trim),"\n";
        $goods++;
      }
      elsif ($seen{$idtag}) { $dups++; $seen{$idtag}++; }
      else { $ntag++; }
    }
    elsif ($keep and $name) { print "$name\n$seq\n+\n",$qua,"\n";}
    else {$nohead++ if $name;}
    $seq="";
    $ll=0;
    $qua="";
    @sites=();
    $name=$name2;
  }
  elsif ($ll==0){
    chomp;
    $seq=$_;
    $ll=1;
  }
  elsif ($ll==2) {
    chomp;
    $qua=$_;
    $ll=3;
  }
  else { $ll=2;}
}

if ($seq=~/^($lead)(.+)/) {
  my $start=substr($2,0,$substr_len);
  my $idtag=$1.$start;
  if (!$seen{$idtag} and $idtag!~/N/) {
      $seen{$idtag}=1;
      $trim=length($1);
      print "$name\n$2\n+\n",substr($qua,$trim),"\n";
      $goods++;
  }
  elsif ($seen{$idtag}) { $dups++; $seen{$idtag}++; }
  else { $ntag++; }
}
elsif ($keep and $name) { print "$name\n$seq\n+\n",$qua,"\n";}
else {$nohead++ if $name;}
close INP;

my $tot2=$goods+$dups+$nohead+$ntag;
die("Total sequences $tot does not match sum $tot2\n") unless $tot==$tot2;
warn "$fq\ttotal:$tot\tgoods:$goods\tdups:$dups\tnoheader:$nohead\tN.in.header:$ntag\n";

open(FH, '>', "$fq.summ.txt");
print FH "$fq\ttotal:$tot\tgoods:$goods\tdups:$dups\tnoheader:$nohead\tN.in.header:$ntag\n";
close (FH);

# Optionally write histograms of number of dups / number IDs with that number of dups
if ($out_dir) {
  my %ct_hash; my %cat_hash;
  foreach my $val (values %seen) {
    $ct_hash{$val}++;
    if ($val == 1) {
      $cat_hash{"1"}++;
    } elsif ($val == 2) {
      $cat_hash{"2"}++;
    } elsif ($val == 3) {
      $cat_hash{"3"}++;
    } elsif ($val == 4) {
      $cat_hash{"4"}++;
    } elsif ($val <= 10) {
      $cat_hash{"5-10"}++;
    } elsif ($val <= 100) {
      $cat_hash{"11-100"}++;
    } elsif ($val <= 1000) {
      $cat_hash{"101-1000"}++;
    } elsif ($val > 1000) {
      $cat_hash{"1000+"}++;
    }
  }
  my $out_hist="$out_dir/$pfx.trim.dupcategories.tsv";
  open OUT, ">$out_hist" or die "Cannot open file '$out_hist' for output\n";
  my @categories = ("1","2","3","4","5-10","11-100","101-1000","1000+");
  foreach $key (@categories) {
    print OUT "$key\t$cat_hash{$key}\n" if $key;
  }
  close OUT;
  $out_hist="$out_dir/$pfx.trim.duphist.tsv";
  open OUT, ">$out_hist" or die "Cannot open file '$out_hist' for output\n";
  foreach $key (sort {$a <=> $b} keys %ct_hash) {
    print OUT "$key\t$ct_hash{$key}\n" if $key;
  }
  close OUT;
}


