set -e
npm run build

# 推送到文档网站 ec2
rsync -avzP build/Iost/ ubuntu@iostdoc:/var/www/iost-doc/update/
#rsync -avzP build/Iost/ ubuntu@iostdoc:/var/www/iost-doc/update/
#ssh ubuntu@18.188.7.39 'cd /var/www/iost-doc/; bash release.sh'
ssh ubuntu@iostdoc 'cd /var/www/iost-doc/; bash release.sh'

# 推送到 s3
#aws --profile s3ops s3 sync build/Iost s3://developers.iost.io
