#!/bin/bash
#Script to create a specific-directory on all subfolders in a parent-directory

mkdir -p $RESULTS_DIRECTORY
mkdir -p $REPORT_DIRECTORY
mkdir -p $REPORT_DIRECTORY/history
mktemp -p $REPORT_DIRECTORY/history/foobar.XXXXXX