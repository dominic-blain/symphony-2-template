<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:template name="schema-search">
		<xsl:param name="url" select="''" />
		<xsl:if test="string-length($url) != 0">
			<script type="application/ld+json">
			{
			  "@context": "https://schema.org",
			  "@type": "WebSite",
			  "url": "<xsl:value-of select="$root" />",
			  "potentialAction": {
			    "@type": "SearchAction",
			    "target": "<xsl:value-of select="$url" /><xsl:text>?q={search_term_string}</xsl:text>",
			    "query-input": "required name=search_term_string"
			  }
			}
			</script>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
