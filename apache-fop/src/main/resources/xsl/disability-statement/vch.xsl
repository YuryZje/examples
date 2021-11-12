<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>


    <xsl:template name="ipraVHC">
        <xsl:param name="friExtract"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/>
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                            <fo:block><xsl:value-of select="fri:find-local-attribute-name($friExtract, 'VehicleNumber')"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                            <fo:block><xsl:value-of select="fri:find-local-attribute-name($friExtract, 'VehicleModel')"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                            <fo:block><xsl:value-of select="fri:find-local-attribute-name($friExtract, 'StartTime')"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                            <fo:block><xsl:value-of select="fri:find-local-attribute-name($friExtract, 'EndTime')"/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <fo:table-row>
                            <fo:table-cell border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:find-local-attribute-value(., 'VehicleNumber')"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:find-local-attribute-value(., 'VehicleModel')"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:format-date-time(fri:find-local-attribute-value(., 'StartTime'))"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:format-date-time(fri:find-local-attribute-value(., 'EndTime'))"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
