<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="ipraEvent">
        <xsl:param name="friExtract"/>
        <xsl:param name="documentCode"/>
        <xsl:param name="isIpra20221024"/>
        <xsl:param name="header"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <fo:block margin-left="5mm">
                    <xsl:choose>
                        <xsl:when test="$header != ''"><xsl:value-of select="$header"/></xsl:when>
                        <xsl:otherwise><xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/></xsl:otherwise>
                    </xsl:choose>
                </fo:block>
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="33%"/>
                <fo:table-column column-width="33%"/>
                <fo:table-column column-width="33%"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell padding="2px" border="solid black 1px">
                            <fo:block>
                                <xsl:choose>
                                    <xsl:when test="$documentCode = 'IPR'">Наименование отметки о выполнении</xsl:when>
                                    <xsl:otherwise>Заключение о нуждаемости (ненуждаемости) в проведении мероприятий по реабилитации или абилитации</xsl:otherwise>
                                </xsl:choose>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px">
                            <fo:block>
                                Срок, в течение которого рекомендовано проведение реабилитационных или абилитационных мероприятий
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px">
                            <fo:block>
                                Исполнитель заключения о нуждаемости в проведении реабилитационных или абилитационных мероприятий
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:for-each select="$friExtract">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" number-columns-spanned="3">
                                <fo:block>
                                    <xsl:choose>
                                        <xsl:when test="$isIpra20221024">
                                            <xsl:value-of select="fri:find-local-attribute-value(., 'EventTypeName')"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="fri:find-local-attribute-value(., 'GroupTypeName')"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:choose>
                                        <xsl:when test="$documentCode = 'IPRA'">
                                            <xsl:choose>
                                                <xsl:when test="$isIpra20221024">
                                                    Нуждается
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:choose>
                                                        <xsl:when test="fri:find-local-attribute-value(., 'IsNeeded') = 'true'">Нуждается</xsl:when>
                                                        <xsl:otherwise>Не нуждается</xsl:otherwise>
                                                    </xsl:choose>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="fri:if-null(fri:find-local-attribute-value(., 'ExecutorMarkName'), 'Нет данных')"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:variable name="to">
                                        <xsl:value-of select="fri:find-local-attribute-value(., 'To')"/>
                                    </xsl:variable>
                                    <xsl:variable name="from">
                                        <xsl:value-of select="fri:find-local-attribute-value(., 'From')"/>
                                    </xsl:variable>
                                    <xsl:variable name="toDescr">
                                        <xsl:value-of select="fri:find-local-attribute-value(., 'ToDescr')"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="$to != ''">
                                            <xsl:value-of select="concat(fri:format-date($from), ' - ', fri:format-date($to))"/>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:value-of select="concat(fri:format-date($from), ' - ', $toDescr)"/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:find-local-attribute-value(., 'Executor')"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
