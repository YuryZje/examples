<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="pfrPayment">
        <xsl:param name="friExtract"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">Сведения о пенсионном обеспечении и социальных выплатах гражданина, признанного инвалидом</fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="5mm">
            <fo:table table-layout="fixed" width="100%" text-align="center" border="solid black 1px">
                <fo:table-column column-width="33%"/>
                <fo:table-column column-width="46%"/>
                <fo:table-column column-width="21%"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Вы являетесь получателем выплаты</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Основание назначения выплаты</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Суммарный размер выплаты составляет</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:value-of select="fri:find-local-attribute-value(., 'PaymentTypeCLS')"/> c  <xsl:value-of select="fri:format-date(fri:find-local-attribute-value(., 'From'))"/>
                                </fo:block>
                            </fo:table-cell>
                            <xsl:variable name="basisNameCLS" select="fri:find-local-attribute-value(., 'BasisNameCLS')"/>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:choose>
                                        <xsl:when test="$basisNameCLS != ''">
                                            <xsl:value-of select="$basisNameCLS"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>Код выплаты: </xsl:text><xsl:value-of select="fri:find-local-attribute-value(., 'Basis')"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px">
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:variable name="amount" select="fri:find-local-attribute-value(., 'Amount')"/>
                                    <xsl:choose>
                                        <xsl:when test="contains($amount, '.')">
                                            <xsl:value-of select="substring-before($amount, '.')"/> руб. <xsl:value-of select="substring-after($amount, '.')"/> коп.
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="$amount"/> руб.
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
