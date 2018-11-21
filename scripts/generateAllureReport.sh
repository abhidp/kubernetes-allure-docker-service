#!/bin/bash
echo "Generating report"
cp -R allure-report/history/ allure-results/history/
allure generate --clean
