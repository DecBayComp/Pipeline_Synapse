#!/bin/bash

date

hostname

export MCR_CACHE_VERBOSE=1

if [ -d /scratch/$USER ]; then
  export MCR_CACHE_ROOT=/scratch/$USER/mcr_cache_root.$JOB_ID
else
  export MCR_CACHE_ROOT=~/mcr_cache_root.$JOB_ID
fi

if [ -d MCR_CACHE_ROOT ] ; then
  echo Deleting pre-existing MCR_CACHE_ROOT
  rm -rf $MCR_CACHE_ROOT
fi

mkdir $MCR_CACHE_ROOT

./pipeline_synapse $1 $2

rm -rf $MCR_CACHE_ROOT

date
