<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:mods="http://www.loc.gov/mods/v3"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	exclude-result-prefixes="mods">
	<xsl:output method="html" indent="yes"/>
	
	<!-- Define some frequently used variables -->
	
	<xsl:variable name="authors">
		<xsl:for-each select="/mods:mods/mods:name[@type='personal']/mods:role/mods:roleTerm[text()='author']/../../mods:namePart[not(@type)]">
			<xsl:if test="position() = 1"><xsl:value-of select="."/></xsl:if>
			<xsl:if test="position() &gt; 1">
				<xsl:text>, and </xsl:text>
				<xsl:value-of select="../mods:namePart[@type='given']"/>
				<xsl:text> </xsl:text>
				<xsl:value-of select="../mods:namePart[@type='family']"/>
			</xsl:if>
			<!-- 
			<xsl:if test="count(/mods:mods/mods:name[@type='personal']/mods:role/mods:roleTerm[text()='author']/../../mods:namePart[not(@type)]) &gt; 1">
				<xsl:if test="position() != last()">
					<xsl:text>,</xsl:text>
				</xsl:if>
				<xsl:if test="position() = last() - 1">
					<xsl:text> and </xsl:text>
				</xsl:if>
			</xsl:if>
			-->
		</xsl:for-each>
      </xsl:variable>

	<xsl:variable name="created">
		<xsl:apply-templates select="/mods:mods/mods:originInfo/mods:dateCreated"/>
	</xsl:variable>

	<xsl:variable name="publisher">
		<xsl:apply-templates select="/mods:mods/mods:originInfo/mods:publisher"/>
	</xsl:variable>
	
	<xsl:variable name="abstract">
		<xsl:apply-templates select="/mods:mods/mods:abstract"/>
	</xsl:variable>

	<xsl:variable name="isPartOfList">
		<xsl:for-each
			select="/mods:mods/mods:relatedItem[@type='isPartOf']/mods:titleInfo/mods:title[text()!='Digital Grinnell']">
			<xsl:value-of select="."/><br/>
		</xsl:for-each>
	</xsl:variable>
	
	<xsl:variable name="dquote">"</xsl:variable>
	<xsl:variable name="open">&lt;</xsl:variable>
	<xsl:variable name="close">&gt;</xsl:variable>
	
	<!-- Now the template -->

	<xsl:template match="/">
            <html>
                <head>
                    <style type="text/css">
			body {
			    margin-left : 10px;
			    font-size : 12px;
			}
			table {
			    border-collapse : collapse;
			    width : 90%;
			    border-bottom : 1px solid #999;
			}
			td {
			    vertical-align : top;
			    padding-right : 4px;
			    text-align : top;
			    border-right : 1px solid #999;
			    border-left : 1px solid #999;
			}
			h1  {
                            font-size: 18px;
                            font-weight: bold;
			}
			h2  {
                            font-size: 14px;
                            font-style:italic;
			}
                        img {
                            display:block;
                            height: 65px;
                        }
                            
                    </style>
		</head>

		<body>
			
                    <img src="/sites/default/modules/dg7/dgCoverSheetLogo.png"/>

			<p>
			This work is part of the Digital Grinnell collection at Grinnell College, Grinnell, Iowa.<br/> 
				Find this and additional works at: <a href='https://digital.grinnell.edu/'
					target='_blank'>https://digital.grinnell.edu/</a>
			</p>
				
			<xsl:copy-of select="$created"/>
				
			<h1><xsl:apply-templates
				select="/mods:mods/mods:titleInfo[not(@type)]/mods:title"/></h1>
				
			<xsl:copy-of select="$authors"/>
				
			<h2>Citation: </h2>
			<xsl:copy-of select="$authors"/>
            <xsl:text> </xsl:text>
            <xsl:copy-of select="substring($created,1,4)"/>.
			"<xsl:apply-templates select="/mods:mods/mods:titleInfo[not(@type)]/mods:title"/>". 
			<xsl:copy-of select="$publisher"/>. 
			hdl:<xsl:apply-templates select="/mods:mods/mods:identifier[@type='hdl']"/>.
			
			<h2>Abstract: </h2>
			<xsl:copy-of select="$abstract"/>

                        <h2>Genre: </h2>
			<xsl:apply-templates select="/mods:mods/mods:genre"/> 
				
			<h2>Is Part Of: </h2>
			Digital Grinnell<br/>
			<xsl:copy-of select="$isPartOfList"/>

			<h2>URL: </h2>
			<xsl:element name="a">
                            <xsl:attribute name="href">
                                <xsl:value-of select="/mods:mods/mods:identifier[@type='hdl']"/>
                            </xsl:attribute>
                            <xsl:attribute name="target">
				<xsl:text>_blank</xsl:text>
                            </xsl:attribute>
                            <span><xsl:value-of select="/mods:mods/mods:identifier[@type='hdl']"/></span>
			</xsl:element>
						
			<h2>Access Conditions: </h2>
			<xsl:apply-templates
				select="/mods:mods/mods:accessCondition[@type='useAndReproduction']"/> 

			<p style="clear:both; font:italic normal 8px Georgia, serif; color:gray;
				text-align:right;">
				Cover sheet style created by Mark A. McFate,
				Grinnell College Libraries </p>

		</body>

            </html>

	</xsl:template>

</xsl:stylesheet>
