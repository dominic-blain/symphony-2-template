<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- VIDEOS (youtube, vimeo) -->
<xsl:template match="url[driver = 'YouTube' or driver = 'Vimeo']" mode="module-embed-item">
	<xsl:param name="thumbnail" select="thumbnail" />
	<xsl:param name="is-autoplay" select="true()" />
	<xsl:param name="autoload" select="'none'" />
	<xsl:param name="title" select="''" />
	<xsl:param name="ext-attr" />
	<xsl:param name="ext-attr-video" />
	<xsl:param name="ext-attr-placeholder" />
	<xsl:param name="ext-attr-image" />
	<xsl:param name="ext-attr-button-ctn" />

	<xsl:call-template name="com-embed-video">
		<xsl:with-param name="thumbnail" select="thumbnail" />
		<xsl:with-param name="is-autoplay" select="true()" />
		<xsl:with-param name="autoload" select="'none'" />
		<xsl:with-param name="title" select="''" />
		<xsl:with-param name="ext-attr" />
		<xsl:with-param name="ext-attr-video" />
		<xsl:with-param name="ext-attr-placeholder" />
		<xsl:with-param name="ext-attr-image" />
		<xsl:with-param name="ext-attr-button-ctn" />
	</xsl:call-template>
</xsl:template>

<!-- DEFAULT -->
<xsl:template match="*" mode="module-embed-item" priority="0">
	<xsl:param name="html" select="embed/html" />
	<xsl:param name="ext-attr" />

	<xsl:variable name="attr">
		<add class="js-auto-oembed-player" />
		<xsl:call-template name="util-oembed-attr" />
		<xsl:copy-of select="$ext-attr" />
		<add dev-element="module-embed-item" />
	</xsl:variable>

	<xsl:variable name="attr-script">
		<add type="text/template" />
		<add dev-element="script" />
	</xsl:variable>

	<!-- STRUCTURE -->
	<xsl:call-template name="element">
		<xsl:with-param name="attr" select="$attr" />
		<xsl:with-param name="content">
			<!-- Script -->
			<xsl:call-template name="element">
				<xsl:with-param name="attr" select="$attr-script" />
				<xsl:with-param name="element" select="'script'" />
				<xsl:with-param name="content" select="$html" />
			</xsl:call-template>
		</xsl:with-param>
	</xsl:call-template>
</xsl:template>
</xsl:stylesheet>
