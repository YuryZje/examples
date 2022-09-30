<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>


    <xsl:template name="ipraNonRecommLaborKinds">
        <xsl:param name="friExtract"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">Рекомендации о показанных и противопоказанных видах трудовой деятельности с учетом нарушенных функций организма человека,
                обусловленных заболеваниями, последствиями травм и дефектами
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Вид стойких нарушений функций организма человека</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Рекомендации о противопоказанных видах трудовой деятельности</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:for-each select="$friExtract/fri:ВсеАтрибуты/fri:Атрибут">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="./fri:Наименование"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:variable name="attrType">
                                        <xsl:value-of select="./fri:ТипДанных"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="$attrType != 'NUMBER'">
                                            <xsl:value-of select="./fri:Значение"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:variable name="attrValue">
                                                <xsl:value-of select="./fri:Значение"/>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$attrValue = '1'">
                                                    <xsl:text>Присутствует нарушение функции организма</xsl:text>
                                                </xsl:when>
                                                <xsl:when test="$attrValue = '0'">
                                                    <xsl:text>Отсутствует нарушение функции организма</xsl:text>
                                                </xsl:when>
                                            </xsl:choose>
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
