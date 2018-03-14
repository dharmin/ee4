#!/bin/bash
chown -R ee:ee /app/
gosu ee /usr/local/bin/ee4 --debug $@