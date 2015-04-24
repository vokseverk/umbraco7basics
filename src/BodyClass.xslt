<?xml version="1.0" encoding="utf-8" ?>
<!--
	## BodyClass.xslt
	
	Render the `class` attribute for the `<body>` tag.
	**Note:** Renders *text only* - no markup!
-->
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:umb="urn:umbraco.library"
	exclude-result-prefixes="umb"
>

	<xsl:output method="text" indent="no" omit-xml-declaration="yes" />

	<xsl:param name="currentPageId" />
	<xsl:param name="currentPage" select="//*[@id = $currentPageId]" />
	<xsl:variable name="siteRoot" select="$currentPage/ancestor-or-self::Website" />
	
	<xsl:template match="/">
		<xsl:apply-templates select="$currentPage" />
	</xsl:template>
	
	<xsl:template match="Website">
		<xsl:text> class="frontpage"</xsl:text>
	</xsl:template>
	
	<xsl:template match="*[@isDoc]" priority="-1">
		<!-- Fallback - don't render anything -->
		<!-- <xsl:text> class="textpage"</xsl:text> -->
	</xsl:template>
	
	<!-- Add more templates for specific pages -->
	
</xsl:stylesheet>