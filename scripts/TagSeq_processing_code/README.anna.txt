==========================================================
 TagSeq reads pre-processing
==========================================================
Because TagSeq enriches reads at the 3' end of mRNA transcripts,
the resulting library is considerably less complex than a standard
RNAseq library that produces reads along the whole of a transcript.
And differential PCR amplification of these fragments can distort
the true ratios of original library molecules.

To correct for this potential bias, unique molecular barcodes (UMI)
are ligated to the original library molecules. After sequencing,
special processsing is peformed to collapse multiple occurrences
of each UMI+read sequence combination, retaining just one copy
of each. This restores the correct ratio of original library
molecules and prepares the reads for downstream differential
expression analysis that relies on accurate quantification.

This directory contains code to perform the necessary TagSeq
pre-processing for downstream analysis, based on Misha Matz' original
tag-based_RNAseq (https://github.com/z0on/tag-based_RNAseq, the
September 30, 2019 version that contains updated UMI definitions).
Its processing collapses multiple UMI+read sequences, removes the
TagSeq adapter+UMI, and optionally performs quality filtering.
Enhancements to the original code also keep track of processing
statistics (e.g. duplicates removed; reads where no adapter/UMI
was found, etc.), allowing visualization of the results in a
MultiQC report.

The directory components are:
  README.anna.txt                   -- this file
  tagseq_trim_launch.anna.pl
  tagseq_clipper.anna.pl
  tagseq_stats_summary.anna.pl
  multiqc_tagseq_trim_template.yaml -- MultiQC report template

Here are the TagSeq UMIs used. Note that the code requires an
exact match to one of the patterns.
-----------------------------------------
 name    sequence       grep pattern
-----------------------------------------
 swMWWM  NNMWWMWHGGG    [ATGC]?[ATGC][AC][AT][AT][AC][AT][ACT]GGG+
 swGC    NNGCWTCHMWGGG  [ATGC]?[ATGC]GC[AT]TC[ACT][AC][AT]GGG+
 swTG    NNTGCMWGGG     [ATGC]?[ATGC]TGC[AC][AT]GGG+
 swMW    NNMWGGG        [ATGC]?[ATGC][AC][AT]GGG+
-----------------------------------------
 M=AC (amino)
 W=AT (weak)
 H=ACT

==========================================================
External programs you will need
==========================================================
Required:
- FASTX-toolkit - http://hannonlab.cshl.edu/fastx_toolkit/
Optional:
- FastQC - https://www.bioinformatics.babraham.ac.uk/projects/fastqc/
- MultiQC - https://github.com/ewels/MultiQC

==========================================================
This code brought to you by:
==========================================================
  Anna Battenhouse <abattenhouse@utexas.edu>
  Bioinformatics Consulting Group (BCG)
  The University of Texas at Austin

==========================================================
How to run the code
==========================================================
1) Make sure this TagSeq pre-processing code is on your PATH

E.g:
   export PATH="/mnt/bioi/tools/tagseq_data_prep:$PATH"
   which tagseq_clipper.anna.pl  # should return a path

Also make sure the TagSeq pre-processing script files are executable.
Note: Skip if using code from /mnt/bioi/tools on BRCF PODs.
   chmod +x tagseq*.pl

----------
2) Make sure the fastx_clipper and fastq_quality_filter programs
   are on your PATH (part of the Hannon lab's FASTX-toolkit:
     http://hannonlab.cshl.edu/fastx_toolkit/download.html)

E.g:
   which fastx_clipper         # should return a path
   which fastq_quality_filter  # should return a path

----------
3) Prepare the TagSeq processing directory, creating symbolic
   links to the fastq files to be processed.

E.g: (adjust if your fastq files are named differently)
   mkdir -p mytagseq_prep/fq.trim
   mkdir -p mytagseq_prep/fq.orig
   cd       mytagseq_prep/fq.orig
   find <ngs_data_dir>/Project_JAnnnnn -name "*.fastq.gz" -type f | \
     xargs -r ln -sf -t .

Your mytagseq_prep/fq.orig directory should now have symbolic links
to all your fastq files.

----------
4) Combine multiple fastq lanes, if applicable.

First check if multiple lanes need to be combined, e.g:
  cd mytagseq_prep/fq.orig
  ls | grep 'fastq[.]gz' | wc -l
  ls | grep 'fastq[.]gz' | perl -pe 's|_L0.*||' | sort | uniq | wc -l
If those two numbers are not the same (the 2nd should be an even multiple
of the first), then you may (optionally) want to combine the multiple
fastq lanes before further processing.

E.g.
  mkdir mytagseq_prep/fq.cmb
  cd mytagseq_prep/fq.orig
  samps=$(ls | grep 'fastq[.]gz' | perl -pe 's|_L0.*||' | sort | uniq)
  for samp in $samps; do
    fqs=$(ls | grep 'fastq[.]gz' | grep "^${samp}_")
    echo "Combining fastq lanes for sample $samp"
    echo ".." $fqs
    zcat $fqs | gzip -c > ../fq.cmb/${samp}_cmb.fastq.gz
  done

----------
5) Create the file of commands to run, each command processing one
   Fastq file.

E.g:
   cd mytagseq_prep/fq.orig  # or /fq.cmb, if lanes were combined
   tagseq_trim_launch.anna.pl '\.fastq.gz$' '' 32 \
     ../fq.trim 10 20 > trim_tagseq_files.sh
Where:
   arg 1 (required) Regex pattern to find the Fastq files to be processed.
   arg 2 (optional) Position of name-deriving string in the file name
                    if separated by underscores, such as input file
                    Sample_RNA_2DVH_L002_R1.cat.fastq. Default 0.
   arg 3 (optional) Length of after-header substring to use for de-duplicating.
                    Default 32. Must be between 20 and 36.
   arg 4 (optional) Output directory. Default ./trimmed
   arg 5 (optional) Minimum quality score for quality filtering, default 10.
                    If -1, no quality filtering is performed.
   arg 5 (optional) Minimum sequence length retained after clipping.
                    Default 20. Shorter post-trimming sequences are discarded.
Here the resulting script file is:
   mytagseq_prep/fq.orig/trim_tagseq_files.sh

----------
6) Run the TagSeq processing script just created.

E.g:
   cd mytagseq_prep/fq.orig  # or /fq.cmb, if lanes were combined
   mkdir -p ../fq.trim
   bash ./trim_tagseq_files.sh 2> ../fq.trim/trim_stats.txt

The processed TagSeq fastq files will be:
   mytagseq_prep/fq.trim/*.trim.fastq.gz

---------------------------------------------
The final 2 steps, which produce QC reports
on the TagSeq processing, are optional.
---------------------------------------------
7) Generate the FastQC reports.

First make sure the fastq program is on your PATH.
  which fastqc

FastQC can be installed from
  https://www.bioinformatics.babraham.ac.uk/projects/download.html#fastqc

Then generate FastQC reports for each processed fastq file.
E.g:
   cd mytagseq_prep/fq.trim
   fastqc -java=/usr/lib/jvm/java-11-openjdk-amd64/bin/java *.trim.fastq.gz

Note: On BRCF PODs, an alternate Java version must be used, as shown above.

----------
8) Generate the MultiQC report.

First make sure the multiqc program is on your PATH.
Also check the version (1.6+ required)
  which multiqc
  multiqc --version

MultiQC can be obtained from: https://github.com/ewels/MultiQC

Then generate the MultiQC report from the individual FastQC reports
and the statistics produced during TagSeq processing.
E.g:
   # Create files all.tagseq_summary_stats.tsv, all.sample_results.tsv
   cd mytagseq_prep/fq.trim
   tagseq_stats_summary.anna.pl . trim_stats.txt '_S\d+.*'

   cd mytagseq_prep
   # Substitute your Job, Run and other parameter values (specified
   # in the tagseq_trim_launch.anna.pl call) into the MultiQC template.
   # Use the /mnt/bioi/tools/tagseq_data_prep directory on BRCF PODs, or
   # specify the directory where you have this TagSeq processing code.
   cat /mnt/bioi/tools/tagseq_data_prep/multiqc_tagseq_trim_template.yaml \
     | sed "s/__JAxxxxx/JA99999/" \
     | sed "s/__SAxxxxx/SA99999/" \
     | sed "s/__DEDUP_SUBSTR_LEN/32/" \
     | sed "s/__MIN_TRIMMED_LEN/20/" \
     | sed "s/__MIN_MAPQ/10/" \
     > mytagseq_multiqc.yaml
   multiqc --no-data-dir -c mytagseq_multiqc.yaml -f \
     -n mytagseq_multiqc_report.html ./fq.trim

The MultiQC report will be:
   mytagseq_prep/mytagseq_multiqc_report.html

==========================================================
About the MultiQC report
==========================================================
The MultiQC report has two types of sections:
   1) Sections generated from the FastQC data
      (General Stats and all the FastQC sections)
   2) Custom sections describing the TagSeq processing
      (TAGseq Fastq pre-processing sections)

General Statistics - Aggregates per-file FastQC statistics
    to shows summary stats for each trimmed fastq file.
  - The M Seq column is millions of sequences in the trimmed file.
  - The % Dups number is based on how many duplicates are seen in the
    leftmost 50 bases of the trimmed sequences. This number is expected
    to be high because the 3' enriched library is not very complex.
    Note this number is *NOT* related to the number of collapsed
    TagSeq duplicates.
TAGseq by-sample summary - Summarizes TagSeq processing stats
    by sample, combining statistics for multiple Fastq files for
    a given sample (e.g. Fastq files for different sequencer lanes,
    if lanes were not combined beforehand).
    - M_Orig   - Millions of original reads
    - M_Trim   - Millions of reads after TagSeq pre-processing
    - Pct_Trim - Percent of original reads retained after pre-processing
TAGseq by-file processing - Shows categories of reads in the
    original fastq file. The total width of each bar indicates
    the number of original reads. Categories:
  - Final       - Final number of trimmed, de-duplicated reads.
                  These reads all had a unique Unique Molecular Index (UMI)
                  combined with the start of their read sequences.
  - Duplicates  - Reads that were discarded because their UMI+read
                  sequence was a duplicate.
  - No_Header   - Reads that were discarded because no TagSeq
                  header (adapter+UMI) was found.
  - N_in_Header - Reads that were discarded due to the presence of Ns
                  in the TagSeq header.
  - Num_Clipped - Reads that were discarded because they were too short
                  after removing the TagSeq header.

FastQC sections - Aggregate other standard FastQC reports for
  the individual trimmed fastq files.
  - See https://www.bioinformatics.babraham.ac.uk/projects/fastqc/

