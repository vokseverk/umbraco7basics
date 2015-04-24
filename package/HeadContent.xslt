<?xml version="1.0"?>
<!--
	## HeadContent.xslt
	
	Render misc. content for the `<head>` tag

	TODO: Enable Google Analytics?
	TODO: Set WebApp Title
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:umb="urn:umbraco.library" version="1.0" exclude-result-prefixes="umb">

	<xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>
	
	<xsl:param name="currentPageId"/>
	<xsl:param name="currentPage" select="//*[@id = $currentPageId]"/>
	<xsl:variable name="siteRoot" select="$currentPage/ancestor-or-self::Website"/>
	
	<xsl:variable name="siteSettings" select="document('../config/SiteSettings.config')/SiteSettings"/>
	<xsl:variable name="assetsFolder" select="$siteSettings/Deployment/assetsFolder"/>
	
	<!-- Google Analytics enabled? -->
	<xsl:variable name="enableGoogleAnalytics" select="false()"/>
	
	<!-- Grab the SEO Metadata properties -->
	<xsl:variable name="metadata" select="umb:JsonToXml($currentPage/metadata)"/>
	
	<xsl:template match="/">
		<meta charset="utf-8"/>
		<title>
			<!-- Make sure to fallback to this page's name if no SEO value was retrieved -->
			<xsl:value-of select="($currentPage[not(normalize-space($metadata/title))]/@nodeName | $metadata/title)[1]"/>
		</title>

		<xsl:apply-templates select="$metadata/description[normalize-space()]"/>
		<xsl:apply-templates select="$metadata/noIndex[. = 'true']"/>
		
		<!-- Main StyleSheet -->
		<link rel="stylesheet" href="/assets/{$assetsFolder}/app.css"/>

		<!-- Mobile Webkit stuff -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
		<meta name="apple-mobile-web-app-title" content=""/>
		
		<!-- Robots -->
		<xsl:apply-templates select="$siteSettings/Deployment/robots[normalize-space()]"/>
		
		<!-- Webfonts script(s) -->
		<xsl:apply-templates select="$siteSettings/Deployment/webfontScripts"/>
		
		<!-- Google Analytics -->
		<xsl:apply-templates select="$siteRoot/analyticsCode[normalize-space() and $enableGoogleAnalytics]"/>
	</xsl:template>

	<xsl:template match="typekitCode | analyticsCode | webfontScripts">
		<xsl:value-of select="." disable-output-escaping="yes"/>
	</xsl:template>
	
	<xsl:template match="json/description">
		<meta name="description" content="{.}"/>
	</xsl:template>
	
	<xsl:template match="json/noIndex[. = 'true']">
		<meta name="robots" content="noindex"/>
	</xsl:template>
	
	<xsl:template match="Deployment/robots">
		<meta name="robots" content="{.}"/>
	</xsl:template>
	
</xsl:stylesheet>
