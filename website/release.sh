set -e
npm run build
rm -rf ../release0
mv ../release ../release0
mv build/Iost/ ../release
