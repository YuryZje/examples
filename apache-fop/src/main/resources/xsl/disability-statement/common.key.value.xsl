<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="commonKeyValue">
        <xsl:param name="friExtract"/>
        <xsl:param name="header"/>
        <xsl:param name="isChild"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <fo:block margin-left="5mm">
                    <xsl:choose>
                        <xsl:when test="$header != ''"><xsl:value-of select="$header"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/></xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <xsl:for-each select="$friExtract/fri:ВсеАтрибуты/fri:Атрибут">
                        <xsl:choose>
                            <xsl:when test="./fri:ТипДанных != 'NUMBER'">
                                <fo:table-row>
                                    <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                        <fo:block>
                                           <xsl:value-of select="replace(./fri:Наименование, '- значение', '')"/>
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                        <fo:block>
                                            <xsl:value-of select="./fri:Значение"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:when>
                            <xsl:when test="./fri:ТипДанных = 'NUMBER'">
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
                                                <xsl:when test="$value = '1'">Да</xsl:when>
                                                <xsl:when test="$value = '0'">Нет</xsl:when>
                                                <xsl:otherwise><xsl:value-of select="$value"/></xsl:otherwise>
                                            </xsl:choose>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:when>
                            <xsl:otherwise>
                                <fo:table-row><fo:table-cell><fo:block>Нет данных</fo:block></fo:table-cell></fo:table-row>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
