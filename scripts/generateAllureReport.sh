#!/bin/bash
echo "Generating report"
cp -R $REPORT_DIRECTORY/history/ $RESULTS_DIRECTORY/history/
allure generate --clean
