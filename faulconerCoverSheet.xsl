<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
								xmlns:mods="http://www.loc.gov/mods/v3"
								xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
								exclude-result-prefixes="mods">
	<xsl:output method="html" indent="yes"/>

	<!-- Define some frequently used variables -->

	<xsl:variable name="creators">
		<xsl:for-each select="/mods:mods/mods:name[@type='personal']/mods:role/mods:roleTerm[text()='artist' or text()='creator']/../../mods:namePart[not(@type)]">
			<xsl:choose>
				<xsl:when test="position() = last()">
					<xsl:value-of select="."/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="."/>
					<xsl:text>; </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:for-each>
	</xsl:variable>

	<xsl:variable name="created">
		<xsl:apply-templates select="/mods:mods/mods:originInfo/mods:dateCreated"/>
	</xsl:variable>

	<xsl:variable name="medium">
		<xsl:apply-templates select="/mods:mods/mods:physicalDescription/mods:form"/>
	</xsl:variable>

	<xsl:variable name="nationality">
		<xsl:apply-templates select="/mods:mods/mods:subject/mods:topic[@displayLabel='nationality']"/>
	</xsl:variable>

	<xsl:variable name="extent">
    <xsl:for-each select="/mods:mods/mods:physicalDescription/mods:extent">
      <xsl:choose>
        <xsl:when test="position() = last()">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/><br/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
	</xsl:variable>

  <xsl:variable name="creditLine">
    <xsl:for-each select="/mods:mods/mods:note[@type='credits']">
      <xsl:choose>
        <xsl:when test="position() = last()">
          <xsl:value-of select="."/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="."/><br/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="local">
    <xsl:apply-templates select="/mods:mods/mods:identifier[@type='local']"/>
  </xsl:variable>

  <xsl:variable name="abstract">
    <xsl:apply-templates select="/mods:mods/mods:abstract"/>
  </xsl:variable>

  <!-- Now the template -->

	<xsl:template match="/">
		<html>
			<head>
				<style type="text/css">
					body { margin-left : 10px; font-size : 14px; }
					p.indented { display: block; margin-left: 20px; }
					table { border-collapse : collapse;  width : 90%; }
					td { vertical-align : top; padding: 4px; text-align : top; font-weight: bold; }
          td.heading { font-size : 14px; font-weight: normal; }
					h1 { font-size: 18px; font-weight: bold; }
					img { display:block; height: 65px; }
				</style>
			</head>

			<body>

				<img src="/sites/default/modules/dg7/dgCoverSheetLogo.png"/>

				<p>
					This work is part of the Digital Grinnell collection at Grinnell College, Grinnell, Iowa.<br/>
					Find this and additional works at: <a href='https://digital.grinnell.edu/'
																								target='_blank'>https://digital.grinnell.edu/</a>
				</p>

				<h1><xsl:apply-templates
						select="/mods:mods/mods:titleInfo[not(@type)]/mods:title"/></h1>

				<table>
          <xsl:choose>
            <xsl:when test="$creators and $creators != ''">
              <tr><td class="heading">Artist:</td><td><xsl:copy-of select="$creators"/></td></tr>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="$abstract and $abstract != ''">
              <tr><td class="heading">Abstract:</td><td><xsl:copy-of select="$abstract"/></td></tr>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="$nationality and $nationality != ''">
              <tr><td class="heading">Nationality:</td><td><xsl:copy-of select="$nationality"/></td></tr>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="$created and $created != ''">
              <tr><td class="heading">Date:</td><td><xsl:copy-of select="$created"/></td></tr>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="$medium and $medium != ''">
              <tr><td class="heading">Medium:</td><td><xsl:copy-of select="$medium"/></td></tr>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="$extent and $extent != ''">
              <tr><td class="heading">Dimensions:</td><td><xsl:copy-of select="$extent"/></td></tr>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="$creditLine and $creditLine != ''">
              <tr><td class="heading">Credit Line:</td><td><xsl:copy-of select="$creditLine"/></td></tr>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
          <xsl:choose>
            <xsl:when test="$local and $local != ''">
              <tr><td class="heading">Accession Number:</td><td><xsl:copy-of select="$local"/></td></tr>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>
				</table>

				<p style="clear:both; font:italic normal 8px Georgia, serif; color:gray;
            text-align:right; margin-right:20px">
					Cover sheet style by Grinnell College Libraries </p>

			</body>

		</html>

	</xsl:template>

</xsl:stylesheet>

