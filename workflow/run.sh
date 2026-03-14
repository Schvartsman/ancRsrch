#!/bin/bash
set -e

# Arguments
FASTQ=$1
REF=$2
OUT=$3

if [ -z "$FASTQ" ] || [ -z "$REF" ] || [ -z "$OUT" ]; then
    echo "Usage: <fastq> <reference.fasta> <output.sam>"
    exit 1
fi

echo "Indexing reference (if not indexed)..."
if [ ! -f "${REF}.bwt" ]; then
    bwa index $REF
fi

echo "Aligning reads..."
bwa mem $REF $FASTQ > aligned.sam

echo "Filtering by MAPQ >= 10..."
samtools view -h -q 10 aligned.sam > filtered.sam

echo "Sorting..."
samtools sort -O SAM filtered.sam -o $OUT

echo "Done.":
