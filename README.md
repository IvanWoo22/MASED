# ***MASED***

## Name Origin

**MASED** - **M**ethylation **A**nalysis of **SE**gmental **D**uplications.

## Purpose

Analyse the history and methylation of segmental duplications of *Arabidopsis thaliana*.

## Directory organization

* [`mcscanx`](mcscanx.sh): Scan multiple genomes or subgenomes to identify putative homologous chromosomal regions, then align these regions using genes as anchors.

* [`colline2yml`](colline2yml.sh): Get the collinearity regions of the genomes to YAML files.

* [`sort_sd`](sort_sd.sh): Sort the segmental duplications by different time of occurrence.

* [`find_promoter`](find_promoter.sh): Determine the promoter region of genomes.

* [`analy_meth`](analy_meth.sh): Analyse the methylation of segments.

## Requirements

### Software

Here we firstly install MCScanX and Bismark.

#### MCScanX

```bash
cd MASED
unzip MCScanX.zip
cd MCScanX
make
cd ~
```

#### Bismark

```bash
cd MASED
unzip bismark.zip
cd ~
```

#### Put into `PATH`

```bash
echo '# Bismark' >> .bashrc
echo 'export PATH="$HOME/MASED/bismark:$PATH"' >> .bashrc
echo >> .bashrc
echo '# MCScanX' >> .bashrc
echo 'export PATH="$HOME/MASED/MCScanX:$PATH"' >> .bashrc
echo >> .bashrc
source .bashrc
```

### Data

#### Collinear

We choose 5 species to build up a time line.

![tree](doc/tree.png)

To download them, you should go to JGI website with login. We also provide some data in our folder [`data/`](data/). Others like *Theobroma cacao* and *Brassica rapa* can be downloaded from other database. Take *Theobroma cacao* as an example:  
**(ATTENTION: If you want to try this for yourself, make sure you have removed the corresponding files in the folder!)**

```bash
wget https://cocoa-genome-hub.southgreen.fr/sites/cocoa-genome-hub.southgreen.fr/files/download/Theobroma_cacaoV2_annot_annoted_clean.gff3.tar.gz
tar -zvxf Theobroma_cacaoV2_annot_annoted_clean.gff3.tar.gz
mv Theobroma_cacaoV2_annot_annoted_clean.gff3 ~/MASED/data/Tcac.gff3
rm Theobroma_cacaoV2_annot_annoted_clean.gff3.tar.gz

wget https://cocoa-genome-hub.southgreen.fr/sites/cocoa-genome-hub.southgreen.fr/files/download/Theobroma_cacaoV2_annot_protein.faa.tar.gz
tar -zvxf Theobroma_cacaoV2_annot_protein.faa.tar.gz
mv Theobroma_cacaoV2_annot_protein.faa ~/MASED/data/Tcac.pep
rm Theobroma_cacaoV2_annot_protein.faa.tar.gz
```

### IntSpans

An IntSpan represents sets of integers as a number of inclusive ranges, for example '1-10,19,45-48'.

The following picture is the schema of an IntSpan object. Jump lines are above the baseline; loop
lines are below it.

![intspans](doc/intspans.png)

[AlignDB::IntSpan](https://github.com/wang-q/AlignDB-IntSpan) and
[jintspan](https://github.com/egateam/jintspan) are implements of IntSpan objects in Perl and Java,
respectively.

### Positions

Examples in [`S288c.txt`](https://github.com/wang-q/App-RL/blob/master/t/S288c.txt)

```text
I:1-100
I(+):90-150
S288c.I(-):190-200
II:21294-22075
II:23537-24097
```

![positions](doc/positions.png)

Simple rules:

* `chromosome` and `start` are required
* `species`, `strand` and `end` are optional
* `.` to separate `species` and `chromosome`
* `strand` is one of `+` and `-` and surround by round brackets
* `:` to separate names and digits
* `-` to separate `start` and `end`
* names should be alphanumeric and without spaces

```text
species.chromosome(strand):start-end
--------^^^^^^^^^^--------^^^^^^----
```

### Runlists in YAML

[App::RL](https://github.com/wang-q/App-RL)

[jrunlist](https://github.com/egateam/jrunlist)

### Blocked fasta files

Examples in [`example.fas`](https://github.com/wang-q/App-Fasops/blob/master/t/example.fas)

```text
>S288c.I(+):13267-13287|species=S288c
TCGTCAGTTGGTTGACCATTA
>YJM789.gi_151941327(-):5668-5688|species=YJM789
TCGTCAGTTGGTTGACCATTA
>RM11.gi_61385832(-):5590-5610|species=RM11
TCGTCAGTTGGTTGACCATTA
>Spar.gi_29362400(+):2477-2497|species=Spar
TCATCAGTTGGCAAACCGTTA

```

![blocked-fasta-files](doc/blocked-fasta-files.png)

[App::Fasops](https://github.com/wang-q/App-Fasops)

### Ranges and links of ranges

[App::Rangeops](https://github.com/wang-q/App-Rangeops)

[jrange](https://github.com/egateam/jrange)

## Author

Ivan Woo &lt;wuyifanwd@hotmail.com&gt;

## Copyright and license

This is free software; you can redistribute it and/or modify it under the same terms.
