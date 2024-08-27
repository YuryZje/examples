<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="ipra2022Forecast">
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
                <fo:table-column column-width="60%"/>
                <fo:table-column column-width="40%"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Наименование прогнозируемого результата</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Степень достижения результата</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <xsl:variable name="resultName" select="fri:find-local-attribute-value(., 'ResultName')"/>
                        <xsl:variable name="degreeAchievementResult" select="fri:find-local-attribute-value(., 'DegreeAchievementResult')"/>
                        <xsl:if test="$resultName != ''">
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px"  border-top="solid black 1px"  text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="$resultName"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:choose>
                                            <xsl:when test="$degreeAchievementResult = '1'">1 степень</xsl:when>
                                            <xsl:when test="$degreeAchievementResult= '2'">2 степень</xsl:when>
                                            <xsl:when test="$degreeAchievementResult = '3'">3 степень</xsl:when>
                                            <xsl:when test="$degreeAchievementResult = '4'">4 степень</xsl:when>
                                            <xsl:otherwise>Значение не указано</xsl:otherwise>
                                        </xsl:choose>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
