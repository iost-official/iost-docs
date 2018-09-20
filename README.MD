# IOST-Docs

The documentation of iost

## Install
Install dependencies:
```
cd website/
npm install
```

## Run
Run the local server for development:
```
cd website/
npm start
```

## Build
To create a static build of your website, run the following script:
```
cd website/
npm run build
```
This will generate a `build` directory inside the `website` directory containing the `.html` files from all of your docs and other pages included in `pages`.

## Deploy
Complete the deployment by publishing the website/build directory with nginx or github page.

## Directory struct
* docs: All documents are here
* docs/assets: All document assets are here
* website/blog: All blogs are here
* website/blog/assets: All blog assets are here

The use of assets can refer to: docs/2-intro-of-iost/Database.md
