<?xml version="1.0" encoding="utf-8"?>
  <xsl:stylesheet version="1.0" xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="mods">
    <xsl:output method="html" indent="yes"/>
    
    <!-- Define some frequently used variables -->
    
    <xsl:variable name="creators">
      <xsl:for-each select="/mods:mods/mods:name[@type='personal']/mods:role/mods:roleTerm[text()='author' or text()='creator']/../../mods:namePart[not(@type)]">
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
    
    <xsl:variable name="genre">
      <xsl:apply-templates select="/mods:mods/mods:genre"/>
    </xsl:variable>
    
    <xsl:variable name="publisher">
      <xsl:apply-templates select="/mods:mods/mods:originInfo/mods:publisher"/>
    </xsl:variable>
    
    <xsl:variable name="abstract">
      <xsl:apply-templates select="/mods:mods/mods:abstract"/>
    </xsl:variable>
    
    <xsl:variable name="handle">
      <xsl:apply-templates select="/mods:mods/mods:identifier[@type='hdl']"/>
    </xsl:variable>
    
    <xsl:variable name="local">
      <xsl:apply-templates select="/mods:mods/mods:identifier[@type='local']"/>
    </xsl:variable>
    
    <xsl:variable name="isPartOfList">
      <xsl:for-each
        select="/mods:mods/mods:relatedItem[@type='isPartOf']/mods:titleInfo/mods:title[text()!='Digital Grinnell']">
        <xsl:value-of select="."/><br/>
      </xsl:for-each>
    </xsl:variable>

    <xsl:variable name="access">
      <xsl:apply-templates select="/mods:mods/mods:accessCondition[@type='useAndReproduction']"/>
    </xsl:variable>

    <xsl:variable name="dquote">"</xsl:variable>
    <xsl:variable name="open">&lt;</xsl:variable>
    <xsl:variable name="close">&gt;</xsl:variable>
    
    <!-- Now the template -->
    
    <xsl:template match="/">
      <html>
        <head>
          <style type="text/css">
            body { margin-left : 10px; font-size : 12px; }
            p.indented { display: block; margin-left: 20px; }
            table { border-collapse : collapse;  width : 90%;  border-bottom : 1px solid #999; }
            td { vertical-align : top; padding-right : 4px; text-align : top; border-right : 1px solid #999; border-left : 1px solid #999; }
            h1 { font-size: 18px; font-weight: bold; }
            h2 { font-size: 14px; font-style:italic; }
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

          <xsl:copy-of select="$created"/>

          <h1><xsl:apply-templates
            select="/mods:mods/mods:titleInfo[not(@type)]/mods:title"/></h1>
          
          <xsl:copy-of select="$creators"/>
          
          <h2>Citation: </h2>
          <p class="indented">
            <xsl:choose>
              <xsl:when test="$creators and $creators !=''">
                <xsl:copy-of select="$creators"/>
                <xsl:choose>
                  <xsl:when test="substring($creators,string-length($creators)) != '.'">
                    <xsl:text>.</xsl:text>
                  </xsl:when>
                  <xsl:otherwise/>
                </xsl:choose>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
            <xsl:choose>
              <xsl:when test="$created and $created !=''">
                <xsl:text> </xsl:text>
                <xsl:copy-of select="$created"/>
                <xsl:text>.</xsl:text>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
            "<xsl:apply-templates select="/mods:mods/mods:titleInfo[not(@type)]/mods:title"/>".
            <xsl:choose>
              <xsl:when test="$publisher and $publisher != ''">
                <xsl:copy-of select="$publisher"/>
                <xsl:text>.</xsl:text>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
            <xsl:choose>
              <xsl:when test="$handle and $handle !=''">
                hdl: <xsl:copy-of select="$handle"/>
                <xsl:text>.</xsl:text>
              </xsl:when>
              <xsl:otherwise/>
            </xsl:choose>
          </p>

          <xsl:choose>
            <xsl:when test="$abstract and $abstract != ''">
              <h2>Abstract: </h2><p class="indented">
              <xsl:copy-of select="$abstract"/></p>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>

          <xsl:choose>
            <xsl:when test="$genre and $genre !=''">
              <h2>Genre: </h2>
              <p class="indented">
                <xsl:copy-of select="$genre"/>
              </p>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>

          <h2>Is Part Of: </h2><p class="indented">
          Digital Grinnell<br/>
          <xsl:copy-of select="$isPartOfList"/></p>
          
          <xsl:choose>
            <xsl:when test="$handle and $handle != ''">
              <h2>HDL: </h2>
              <p class="indented">
                <xsl:element name="a">
                  <xsl:attribute name="href">
                    <xsl:copy-of select="$handle"/>
                  </xsl:attribute>
                  <xsl:attribute name="target">
                    <xsl:text>_blank</xsl:text>
                  </xsl:attribute>
                  <span><xsl:copy-of select="$handle"/></span>
                </xsl:element>
              </p>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>

          <xsl:choose>
            <xsl:when test="$local and $local != ''">
              <h2>URL: </h2>
              <p class="indented">
                <xsl:element name="a">
                  <xsl:attribute name="href">
                    <xsl:choose>
                      <xsl:when test="substring($local,1,4) = 'http'">
                        <xsl:copy-of select="$local"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>https://digital.grinnell.edu/islandora/object/</xsl:text>
                        <xsl:copy-of select="$local"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                  <xsl:attribute name="target">
                    <xsl:text>_blank</xsl:text>
                  </xsl:attribute>
                  <span>
                    <xsl:choose>
                      <xsl:when test="substring($local,1,4) = 'http'">
                        <xsl:copy-of select="$local"/>
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:text>https://digital.grinnell.edu/islandora/object/</xsl:text>
                        <xsl:copy-of select="$local"/>
                      </xsl:otherwise>
                    </xsl:choose>
                  </span>
                </xsl:element>
              </p>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>

          <xsl:choose>
            <xsl:when test="$access and $access !=''">
              <h2>Access Conditions: </h2>
              <p class="indented">
                <xsl:copy-of select="$access"/>
              </p>
            </xsl:when>
            <xsl:otherwise/>
          </xsl:choose>

          <p style="clear:both; font:italic normal 8px Georgia, serif; color:gray;
            text-align:right; margin-right:20px">
            Cover sheet style by Grinnell College Libraries </p>
          
        </body>
        
      </html>
      
    </xsl:template>
    
</xsl:stylesheet>
  
