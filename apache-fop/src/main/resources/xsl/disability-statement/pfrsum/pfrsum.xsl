<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="documentPfrsum">

        <xsl:param name="friDocument"/>

        <xsl:if test="fri:find-category($friDocument/fri:Запись, 'PFR.PAYMENT') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="pfrPayment">
                    <xsl:with-param name="friExtract"
                                    select="$friDocument/fri:Запись/fri:Категория/fri:Код[text() = 'PFR.PAYMENT']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category($friDocument/fri:Запись, 'PFR.GSHELP_THIS_YEAR') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="pfrHelp">
                    <xsl:with-param name="friExtract"
                                    select="$friDocument/fri:Запись/fri:Категория/fri:Код[text() = 'PFR.GSHELP_THIS_YEAR']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="future" select="'false'"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category($friDocument/fri:Запись, 'PFR.GSHELP_NEXT_YEAR') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="pfrHelp">
                    <xsl:with-param name="friExtract"
                                    select="$friDocument/fri:Запись/fri:Категория/fri:Код[text() = 'PFR.GSHELP_NEXT_YEAR']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="future" select="'true'"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
