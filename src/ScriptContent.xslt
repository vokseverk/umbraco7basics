<?xml version="1.0" encoding="utf-8" ?>
<!--
	## ScriptContent.xslt
	
	Render script tags in the bottom of the page
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umb="urn:umbraco.library"
	exclude-result-prefixes="umb"
>

	<xsl:output method="html" indent="yes" omit-xml-declaration="yes" />

	<xsl:param name="currentPageId" />
	<xsl:param name="currentPage" select="//*[@id = $currentPageId]" />
	<xsl:variable name="siteRoot" select="$currentPage/ancestor-or-self::Website" />
	
	<xsl:variable name="siteSettings" select="document('../Config/SiteSettings.config')/SiteSettings" />
	<xsl:variable name="assetsFolder" select="$siteSettings/Deployment/assetsFolder" />
	
	<xsl:template match="/">
		<script src="/assets/{$assetsFolder}/libs.min.js"></script>
		<script src="/assets/{$assetsFolder}/app.js"></script>
	</xsl:template>
	
</xsl:stylesheet>