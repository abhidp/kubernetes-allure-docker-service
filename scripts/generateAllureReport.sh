#!/bin/bash
echo $(TZ=$TIMEZONE date) " Generating new report"
cp -R allure-report/history/* allure-results/history/
allure generate --clean
