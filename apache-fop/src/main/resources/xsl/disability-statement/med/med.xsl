<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="documentMed">
        <xsl:param name="friDocument"/>

        <xsl:if test="fri:find-category($friDocument/fri:Запись, 'ZDRV.MED.DATA.HIGH_TECH') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="medDataHighTech">
                    <xsl:with-param name="friExtract"
                                    select="$friDocument/fri:Запись/fri:Категория/fri:Код[text() = 'ZDRV.MED.DATA.HIGH_TECH']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category($friDocument/fri:Запись, 'ZDRV.MED.RECIPE') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="medRecipe">
                    <xsl:with-param name="friExtract"
                                    select="$friDocument/fri:Запись/fri:Категория/fri:Код[text() = 'ZDRV.MED.RECIPE']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
