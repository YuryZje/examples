<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:function name="fri:string-capitalize">
        <xsl:param name="value"/>
        <xsl:value-of select="concat(substring($value,1,1), lower-case(substring($value, 2)), ' '[not(last())] )"/>
    </xsl:function>

    <xsl:function name="fri:find-attribute-value">
        <xsl:param name="node"/>
        <xsl:param name="category"/>
        <xsl:param name="attribute"/>

        <xsl:variable name="value">
            <xsl:for-each select="$node">
                <xsl:if test="child::fri:Категория/fri:Код/text() = $category">
                    <xsl:for-each select="child::fri:ВсеАтрибуты/fri:Атрибут/fri:Код[text() = $attribute]">
                        <xsl:value-of select="../fri:Значение"/>
                    </xsl:for-each>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$value"/>
    </xsl:function>

    <xsl:function name="fri:find-attribute-name">
        <xsl:param name="node"/>
        <xsl:param name="category"/>
        <xsl:param name="attribute"/>

        <xsl:variable name="value">
            <xsl:for-each select="$node">
                <xsl:if test="child::fri:Категория/fri:Код/text() = $category">
                    <xsl:for-each select="child::fri:ВсеАтрибуты/fri:Атрибут/fri:Код[text() = $attribute]">
                        <xsl:value-of select="../fri:Наименование"/>
                    </xsl:for-each>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$value"/>
    </xsl:function>

    <xsl:function name="fri:find-category">
        <xsl:param name="node"/>
        <xsl:param name="category"/>

        <xsl:variable name="value">
            <xsl:for-each select="$node">
                <xsl:if test="child::fri:Категория/fri:Код/text() = $category">
                    <xsl:value-of select="."/>
                </xsl:if>
            </xsl:for-each>
        </xsl:variable>
        <xsl:value-of select="$value"/>
    </xsl:function>

    <xsl:function name="fri:find-local-attribute-value">
        <xsl:param name="node"/>
        <xsl:param name="attribute"/>

        <xsl:value-of select="$node/fri:ВсеАтрибуты/fri:Атрибут/fri:Код[text() = $attribute]/parent::fri:Атрибут/fri:Значение"/>
    </xsl:function>

    <xsl:function name="fri:find-local-attribute-name">
        <xsl:param name="node"/>
        <xsl:param name="attribute"/>

        <xsl:value-of select="$node/fri:ВсеАтрибуты/fri:Атрибут/fri:Код[text() = $attribute]/parent::fri:Атрибут/fri:Наименование"/>
    </xsl:function>

    <xsl:function name="fri:find-local-attribute-type">
        <xsl:param name="node"/>
        <xsl:param name="attribute"/>

        <xsl:value-of select="$node/fri:ВсеАтрибуты/fri:Атрибут/fri:Код[text() = $attribute]/parent::fri:Атрибут/fri:ТипДанных"/>
    </xsl:function>

    <xsl:function name="fri:format-date">
        <xsl:param name="value"/>
        <xsl:if test="$value != ''">
            <xsl:value-of select="format-date(xs:date($value), '[D01].[M01].[Y0001]')"/>
        </xsl:if>
    </xsl:function>

    <xsl:function name="fri:format-date-time">
        <xsl:param name="value"/>
        <xsl:if test="$value != ''">
            <xsl:value-of select="format-dateTime(xs:dateTime($value), '[D01].[M01].[Y0001] [H01]:[m01]')"/>
        </xsl:if>
    </xsl:function>

    <xsl:function name="fri:invalid-type-name">
        <xsl:param name="isChild"/>
        <xsl:param name="case"/>
        <xsl:choose>
            <xsl:when test="$isChild = 'true'">
                <xsl:choose>
                    <xsl:when test="$case = 'Им'"><xsl:text>ребёнка-инвалид</xsl:text></xsl:when>
                    <xsl:when test="$case = 'Род'"><xsl:text>ребёнка-инвалида</xsl:text></xsl:when>
                    <xsl:when test="$case = 'Тв'"><xsl:text>ребёнка-инвалидом</xsl:text></xsl:when>
                    <xsl:when test="$case = 'Д'"><xsl:text>ребёнка-инвалиду</xsl:text></xsl:when>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$case = 'Им'"><xsl:text>инвалид</xsl:text></xsl:when>
                    <xsl:when test="$case = 'Род'"><xsl:text>инвалида</xsl:text></xsl:when>
                    <xsl:when test="$case = 'Тв'"><xsl:text>инвалидом</xsl:text></xsl:when>
                    <xsl:when test="$case = 'Д'"><xsl:text>инвалиду</xsl:text></xsl:when>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>

</xsl:stylesheet>
