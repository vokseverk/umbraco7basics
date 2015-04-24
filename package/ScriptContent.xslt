<?xml version="1.0"?>
<!--
	## ScriptContent.xslt
	
	Render script tags in the bottom of the page
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umb="urn:umbraco.library" version="1.0" exclude-result-prefixes="umb">

	<xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>

	<xsl:param name="currentPageId"/>
	<xsl:param name="currentPage" select="//*[@id = $currentPageId]"/>
	<xsl:variable name="siteRoot" select="$currentPage/ancestor-or-self::Website"/>
	
	<xsl:variable name="siteSettings" select="document('../Config/SiteSettings.config')/SiteSettings"/>
	<xsl:variable name="assetsFolder" select="$siteSettings/Deployment/assetsFolder"/>
	
	<xsl:template match="/">
		<script src="/assets/{$assetsFolder}/libs.min.js"/>
		<script src="/assets/{$assetsFolder}/app.js"/>
	</xsl:template>
	
</xsl:stylesheet>
