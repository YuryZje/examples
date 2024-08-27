<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="ipra2022LifeRestrict">
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
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <xsl:variable name="categoryLifeActivityName" select="fri:find-local-attribute-name(., 'CategoryLifeActivityName')"/>
                        <xsl:variable name="degreeRestrictionCode" select="fri:find-local-attribute-name(., 'DegreeRestrictionCode')"/>
                        <xsl:variable name="categoryLifeActivityCode" select="fri:find-local-attribute-name(., 'CategoryLifeActivityCode')"/>
                        <xsl:variable name="selfCare" select="fri:find-local-attribute-name(., 'SelfCare')"/>
                        <xsl:if test="$categoryLifeActivityName != ''">
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px"  border-top="solid black 2px"  text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="$categoryLifeActivityName"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px"  border-top="solid black 2px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="fri:find-local-attribute-value(., 'CategoryLifeActivityName')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="$degreeRestrictionCode != ''">
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="$degreeRestrictionCode"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:variable name="value" select="fri:find-local-attribute-value(., 'DegreeRestrictionCode')"/>
                                        <xsl:choose>
                                            <xsl:when test="$value = '1'">1 степень</xsl:when>
                                            <xsl:when test="$value = '2'">2 степень</xsl:when>
                                            <xsl:when test="$value = '3'">3 степень</xsl:when>
                                            <xsl:otherwise>Значение не указано</xsl:otherwise>
                                        </xsl:choose>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="$categoryLifeActivityCode != ''">
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left" >
                                    <fo:block>
                                        <xsl:value-of select="$categoryLifeActivityCode"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:variable name="value" select="fri:find-local-attribute-value(., 'CategoryLifeActivityCode')"/>
                                        <xsl:choose>
                                            <xsl:when test="$value = '1'">1 степень</xsl:when>
                                            <xsl:when test="$value = '2'">2 степень</xsl:when>
                                            <xsl:when test="$value = '3'">3 степень</xsl:when>
                                            <xsl:otherwise>Значение не указано</xsl:otherwise>
                                        </xsl:choose>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="$selfCare != ''">
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" border-top="solid black 2px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="$selfCare"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" border-top="solid black 2px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="fri:find-local-attribute-value(., 'SelfCareCLS')"/>
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
