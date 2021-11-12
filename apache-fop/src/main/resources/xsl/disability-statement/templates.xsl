<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:template name="show-attribute-row">
        <xsl:param name="attribute"/>
        <xsl:param name="attrType"/>
        <xsl:param name="caption"/>

        <xsl:if test="$attribute != ''">
            <fo:table-row>
                <fo:table-cell border="solid black 1px" text-align="left">
                    <fo:block><xsl:value-of select="$caption"/></fo:block>
                </fo:table-cell>
                <fo:table-cell border="solid black 1px" text-align="left">
                    <fo:block>
                        <xsl:choose>
                            <xsl:when test="$attrType = 'BOOLEAN'">
                                <xsl:choose>
                                    <xsl:when test="$attribute = 'true'"><xsl:text>Нуждается</xsl:text></xsl:when>
                                    <xsl:when test="$attribute = 'false'"><xsl:text>Не нуждается</xsl:text></xsl:when>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:when test="$attrType = 'STRING'">
                                <xsl:value-of select="$attribute"/>
                            </xsl:when>
                        </xsl:choose>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
