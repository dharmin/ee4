#!/bin/bash

sites_path=~/ee4-sites

if [ -f ~/.ee4/config.yml ]; then
    sed -e 's/:[^:\/\/]/=/g;s/$//g;s/ ^C/=/g' ~/.ee4/config.yml | tail -n +2  > config
    source config
    rm config
fi

sudo ee stack start --mysql > /dev/null
sudo ee stack stop --nginx > /dev/null

for site in $(sudo sqlite3 /var/lib/ee/ee.db "select sitename,cache_type from sites");do
    site_name=$(echo $site | cut -d'|' -f1)
    cache_type=$(echo $site | cut -d'|' -f2)
    echo -e "\nMigrating site: $site_name\n"
    cd "/var/www/$site_name/htdocs"
    echo "Exporting db..."
    sudo wp db export "$site_name.db" --allow-root
    echo "Creating $site_name in EasyEngine v4. This may take some time please wait..."
    if [ "$cache_type" = "wpredis" ]; then 
        ee4 site create "$site_name" --wpredis
    else
        ee4 site create "$site_name"
    fi
    echo "$site_name created in ee4"
    echo "Copying files to the new site."
    sudo cp -R . $sites_path/$site_name/app/src
    echo "Importing db..."
    ee4 wp "$site_name" db import "$site_name.db"
    sudo rm "$site_name.db"
done

sudo ee stack stop --all > /dev/null