<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- COMPONENT: form-field-checkbox -->
	<xsl:template name="form-field-checkbox" match="item" mode="form-field-checkbox">
		<xsl:param name="label" select="label" />
		<xsl:param name="name" select="name" />
		<xsl:param name="value" select="$label/@handle" />
		<xsl:param name="content-required" select="'*'" />
		<xsl:param name="id">
			<xsl:call-template name="util-form-id" />
		</xsl:param>
		<xsl:param name="rules">
			<xsl:call-template name="util-form-rules" />
		</xsl:param>
		<xsl:param name="is-required" select="contains($rules, 'required')" />
		<xsl:param name="is-checked" select="false()" />
		<xsl:param name="ext-attr" />

		<xsl:variable name="has-required" select="string-length($content-required) != 0" />


		<!-- ATTRIBUTES -->
		<xsl:variable name="attr">
			<!-- OPTION: is required -->
			<xsl:if test="$is-required">
				<add class="is-required" />
			</xsl:if>
			<!-- Rules -->
			<set data-rules="{$rules}" />
			<add class="js-form-field js-form-field-checkbox" />
			<xsl:copy-of select="$ext-attr"/>
			<add dev-component="form-field-checkbox" />
		</xsl:variable>

		<xsl:variable name="attr-label">
			<set for="{$id}" />
			<add dev-element="label" />
		</xsl:variable>

		<xsl:variable name="attr-required">
			<add dev-element="required" />
		</xsl:variable>

		<xsl:variable name="attr-input">
			<set name="{$name}" />
			<set value="{$value}" />
			<set type="checkbox" />
			<set id="{$id}" />
			<!-- OPTION: checked -->
			<xsl:if test="$is-checked">
				<set checked="checked" />
			</xsl:if>
			<add class="js-form-field-input" />
			<add dev-element="input" />
		</xsl:variable>

		<xsl:variable name="attr-hint">
			<add class="js-form-field-hint" />
			<add dev-element="hint" />
		</xsl:variable>


		<!-- STRUCTURE -->
		<xsl:call-template name="element">
			<xsl:with-param name="attr" select="$attr" />
			<xsl:with-param name="content">
				<!-- Input -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-input" />
					<xsl:with-param name="element" select="'input'" />
				</xsl:call-template>
				<!-- Label -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-label" />
					<xsl:with-param name="element" select="'label'" />
					<xsl:with-param name="content" select="$label" />
				</xsl:call-template>
				<!-- Required -->
				<xsl:if test="$has-required and $is-required">
					<xsl:call-template name="element">
						<xsl:with-param name="attr" select="$attr-required" />
						<xsl:with-param name="content" select="$content-required" />
					</xsl:call-template>
				</xsl:if>
				<!-- Hint -->
				<xsl:call-template name="element">
					<xsl:with-param name="attr" select="$attr-hint" />
				</xsl:call-template>
			</xsl:with-param> 
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
