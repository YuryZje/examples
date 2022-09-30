<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="documentEdu">
        <xsl:param name="friDocument"/>
        <xsl:param name="isChild"/>

        <xsl:if test="fri:find-category($friDocument/fri:Запись, 'EDU.PROF') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="eduProf">
                    <xsl:with-param name="friExtract"
                                    select="$friDocument/fri:Запись/fri:Категория/fri:Код[text() = 'EDU.PROF']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="isChild" select="$isChild"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category($friDocument/fri:Запись, 'EDU.HIGH') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="eduHigh">
                    <xsl:with-param name="friExtract"
                                    select="$friDocument/fri:Запись/fri:Категория/fri:Код[text() = 'EDU.HIGH']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="isChild" select="$isChild"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
