# Create the dist directory if needed
if [[ ! -d dist ]]
	then mkdir dist
fi
# Likewise, create the package dir
if [[ ! -d package ]]
	then mkdir package
fi

# Get the current version
VERSION=`grep -o ' packageVersion \"\(.*\)\"' src/version.ent | awk '{print $2}' | sed 's/"//g'`



# Transform the XSLTs and the settings file into the package folder
xsltproc --novalid --output package/HeadContent.xslt lib/freezeEntities.xslt src/HeadContent.xslt 
xsltproc --novalid --output package/ScriptContent.xslt lib/freezeEntities.xslt src/ScriptContent.xslt 
xsltproc --novalid --output package/BodyClass.xslt lib/freezeEntities.xslt src/BodyClass.xslt 
xsltproc --novalid --output package/SiteSettings.config lib/freezeEntities.xslt src/SiteSettings.config 

# Transform the package.xml file, pulling in the README
xsltproc --novalid --xinclude --output package/package.xml lib/freezeEntities.xslt src/package.xml 

# Build the ZIP file 
zip -j "dist/Vokseverk.Umbraco7Basics-$VERSION.zip" package/* -x \*.DS_Store

# Copy the release XSLTs into the dist dir for upgraders
cp package/*.xslt dist/

# ... as well as the release config
cp package/SiteSettings.config dist/

