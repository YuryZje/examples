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
                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                    <fo:block><xsl:value-of select="$caption"/></fo:block>
                </fo:table-cell>
                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
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

    <xsl:template name="show-attribute-in-table">
         <xsl:param name="name"/>
        <xsl:param name="value"/>

        <xsl:if test="$name != '' and $value != ''">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell padding="2px" text-align="left">
                            <fo:block><xsl:value-of select="$name"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" text-align="left">
                            <fo:block><xsl:value-of select="$value"/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </xsl:if>
    </xsl:template>

    <xsl:template name="show-boolean-in-table">
        <xsl:param name="name"/>
        <xsl:param name="value"/>

        <xsl:if test="$name != '' and $value != '' and ($value = 'true' or $value = 'false')">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell padding="2px" text-align="left">
                            <fo:block><xsl:value-of select="$name"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" text-align="left">
                            <fo:block>
                                <xsl:choose>
                                    <xsl:when test="$value = 'true'"><xsl:value-of select="'Да'"/></xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="'Нет'"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </xsl:if>
    </xsl:template>

    <xsl:template name="show-name-in-row">
        <xsl:param name="friExtract"/>
        <xsl:param name="name"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/>
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="100%"/>
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:find-local-attribute-value(., $name)"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

    <xsl:template name="show-name-value-in-row">
        <xsl:param name="friExtract"/>
        <xsl:param name="headerName"/>
        <xsl:param name="headerValue"/>
        <xsl:param name="name"/>
        <xsl:param name="value"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/>
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block><xsl:value-of select="$headerName"/></fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block><xsl:value-of select="$headerValue"/></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:find-local-attribute-value(., $name)"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:find-local-attribute-value(., $value)"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
