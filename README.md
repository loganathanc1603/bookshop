# Getting Started

Welcome to your new project.

It contains these folders and files, following our recommended project layout:

File or Folder | Purpose
---------|----------
`app/` | content for UI frontends goes here
`db/` | your domain models and data go here
`srv/` | your service models and code go here
`package.json` | project metadata and configuration
`readme.md` | this getting started guide


## Next Steps

- Open a new terminal and run `cds watch` 
- (in VS Code simply choose _**Terminal** > Run Task > cds watch_)
- Start adding content, for example, a [db/schema.cds](db/schema.cds).


## Learn More

Learn more at https://cap.cloud.sap/docs/get-started/.

## Important GIT Commands
- git config --global user.name "YOUR_USER_NAME"
- git config --global user.email "YOUR_EMAIL"
- git clone https://github.com/SAP-samples/cloud-cap-samples.git

## CF CLI commands
- cf login -u abc@gmail.com -p xxxxxxxx -a https://api.cf.us10-001.hana.ondemand.com -o xxxxxx999trial -s xxxdev
- cf create-service xsuaa application MyHANAApp-auth -c xs-security.json
- cf services
- cf apps
- cf create-service-key MyHANAApp-auth default
- cf plugins
- cf install-plugin multiapps
- cf logs --recent <appname>
- cf logs <appname>
- cf deploy MyHANAApp.0.0.mtar
- cf undeploy MyHANAApp --delete-service-keys --delete-services
- cf undeploy MyHANAApp

## CDS CLI commands
- cds init bookshop
- cds watch
- cds watch --profile hybrid
- cds compile srv/ --to xsuaa > xs-security.json
- cds bind -2  MyHANAApp-db:MyHANAApp-db-key
- cds deploy --to sqlite:db/myhanaapp.db
- cds deploy --to hana --profile hybrid
- cds deploy --to hana
- cds add hana --for production
- cds add xsuaa --for production
- cds add pipeline
- cds add mta
- cds build --production
- cds build
- cds build --for hana

## MBT CLI commands
- mbt --version
- mbt build -t ./

## NPM CLI commands
- npm install
- npm ci
- npm install --global mbt
- npm install --global @sap/cds-dk --@sap:registry=https://npmjs.org/
- npm install --global @sap/ux-ui5-tooling
- npm install --global @ui5/cli
- npm install --global @sap/generator-fiori
- npm install --global mta
- npm add @cap-js-community/odata-v2-adapter
- npm add sqlite3 -D
- npm config delete "@sap:registry"

## FIORI CLI commands
- fiori add deploy-config cf
- fiori add flp-config

## UI5 CLI commands
- ui5 init
- ui5 use SAPUI5@1.117.0
- ui5 add sap.ui.core sap.m themelib_sap_fiori_3
- ui5 serve
- ui5 build
