#!/bin/bash

echo "commit message:"

read message

git add -A

git commit -m "$message"

proxychains git push -u origin main


