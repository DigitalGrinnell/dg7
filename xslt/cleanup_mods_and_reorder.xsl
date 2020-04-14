<?xml version="1.0" encoding="UTF-8"?>

<!-- MAM.
This XSLT cleans up a MODS record AND reorders the output elements to match the
Digital Grinnell standard MODS form as of April 2015.

Modified in November 2015 to produce a new order with some differnt logic than was applied earlier.

Important!!!  All possible elements MUST be accounted for here.  Any that are NOT present will be
discarded when this transform is applied!
-->

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:mods="http://www.loc.gov/mods/v3">
  <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" media-type="text/xml"/>
  <!--
    <xsl:strip-space elements="*"/> -->
  <xsl:template
      match="*[not(node())] | *[not(node()[2]) and node()/self::text() and not(normalize-space())]"/>
  <xsl:template
      match="mods:name[not(mods:namePart)]"/>

  <!-- The order of the following statements is SIGNIFICANT!  Don't change this unless you know what you are doing! -->

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:copy-of select="mods:titleInfo[not(@*)]" />
      <xsl:copy-of select="mods:titleInfo[@type='alternative']" />
      <xsl:copy-of select="mods:name[mods:role/mods:roleTerm[text()='creator' or text()='author' or text()='artist']]"/>
      <xsl:copy-of select="mods:name[mods:role/mods:roleTerm[text()!='creator' and text()!='author' and text()!='artist']]"/>
      <xsl:copy-of select="mods:abstract"/>
      <xsl:copy-of select="mods:originInfo"/>
      <xsl:copy-of select="mods:note[@type]"/>         <!-- public notes with no type attribute -->
      <xsl:copy-of select="mods:note[not(@type)]"/>    <!-- public notes with any type attribute -->
      <xsl:copy-of select="mods:tableOfContents"/>
      <xsl:copy-of select="mods:subject[@authority][mods:topic]"/>
      <xsl:copy-of select="mods:subject[@authority][mods:geographic]"/>
      <xsl:copy-of select="mods:subject[@authority][mods:temporal]"/>
      <xsl:copy-of select="mods:subject[not(@authority)]"/>
      <xsl:copy-of select="mods:relatedItem[not(@type='admin') and not(@displayLabel='Transcribe This Item')]"/>  <!-- Regular relations...excludes Private notes -->
      <xsl:copy-of select="mods:typeOfResource"/>
      <xsl:copy-of select="mods:genre"/>
      <xsl:copy-of select="mods:physicalDescription[@displayLabel='Physical']"/>    <!-- Physical/original objects only -->
      <xsl:copy-of select="mods:physicalDescription[not(@displayLabel)]"/>          <!-- Digital objects only -->
      <xsl:copy-of select="mods:physicalDescription[@displayLabel!='Physical']"/>   <!-- We should have NONE of these -->
      <xsl:copy-of select="mods:classification"/>
      <xsl:copy-of select="mods:language"/>
      <xsl:copy-of select="mods:identifier[@type='local']"/>
      <xsl:copy-of select="mods:identifier[not(@type='local')]"/>
      <xsl:copy-of select="mods:relatedItem[@displayLabel='Transcribe This Item']"/>  <!-- Old transcription scheme -->
      <xsl:copy-of select="mods:relatedItem[@type='admin']"/>                         <!-- Catch-all for PRIVATE notes -->
      <xsl:copy-of select="mods:extension"/>
      <xsl:copy-of select="mods:accessCondition"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
