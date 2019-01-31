set -e
#npm run build
rsync -avzP build/Iost/ ubuntu@iostdoc:/var/www/iost-doc/update/
ssh ubuntu@iostdoc 'cd /var/www/iost-doc/; bash release.sh'
