#!/bin/bash
sites_path=~/ee4-sites

if [ -f ~/.ee4/config.yml ]; then
    sed -e 's/:[^:\/\/]/=/g;s/$//g;s/ ^C/=/g' ~/.ee4/config.yml | tail -n +2  > config
    source config
    rm config
fi