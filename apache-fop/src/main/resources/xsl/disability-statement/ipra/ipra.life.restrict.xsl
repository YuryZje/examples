<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="ipraLifeRestrict">
        <xsl:param name="friExtract"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <fo:block margin-left="5mm">
                    <xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/>
                </fo:block>
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <xsl:for-each select="$friExtract/fri:ВсеАтрибуты/fri:Атрибут">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="replace(./fri:Наименование, '- значение', '')"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:variable name="value" select="./fri:Значение"/>
                                    <xsl:choose>
                                        <xsl:when test="$value = '1'">1 степень</xsl:when>
                                        <xsl:when test="$value = '2'">2 степень</xsl:when>
                                        <xsl:when test="$value = '3'">3 степень</xsl:when>
                                        <xsl:otherwise>Значение не указано</xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                    <fo:table-row><fo:table-cell><fo:block></fo:block></fo:table-cell></fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
