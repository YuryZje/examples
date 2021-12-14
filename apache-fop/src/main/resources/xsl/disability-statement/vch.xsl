<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="fo xs exsl">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="ipraHeaderVHC">
        <xsl:param name="friExtract"/>
        <fo:table-column column-width="25%"/>
        <fo:table-column column-width="25%"/>
        <fo:table-column column-width="25%"/>
        <fo:table-column column-width="25%"/>
        <fo:table-header>
            <fo:table-row>
                <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                    <fo:block>
                        <xsl:value-of select="fri:find-local-attribute-name($friExtract[1], 'VehicleNumber')"/>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                    <fo:block>
                        <xsl:value-of select="fri:find-local-attribute-name($friExtract[1], 'VehicleModel')"/>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                    <fo:block>
                        <xsl:value-of select="fri:find-local-attribute-name($friExtract[1], 'StartTime')"/>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                    <fo:block>
                        <xsl:value-of select="fri:find-local-attribute-name($friExtract[1], 'EndTime')"/>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </fo:table-header>
    </xsl:template>

    <xsl:template name="ipraBodyVHC">
        <xsl:param name="friExtract"/>
        <fo:table-body>
            <xsl:for-each select="$friExtract">
                <fo:table-row>
                    <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                        <fo:block>
                            <xsl:value-of select="fri:find-local-attribute-value(., 'VehicleNumber')"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                        <fo:block>
                            <xsl:value-of select="fri:find-local-attribute-value(., 'VehicleModel')"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                        <fo:block>
                            <xsl:value-of select="fri:format-date-time(fri:find-local-attribute-value(., 'StartTime'))"/>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                        <fo:block>
                            <xsl:value-of select="fri:format-date-time(fri:find-local-attribute-value(., 'EndTime'))"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </xsl:for-each>
        </fo:table-body>
    </xsl:template>

</xsl:stylesheet>
