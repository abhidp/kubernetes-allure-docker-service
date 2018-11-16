#!/bin/bash
echo "Generating report"
cp -R allure-results/newhistory/ allure-results/history/
allure generate --clean
