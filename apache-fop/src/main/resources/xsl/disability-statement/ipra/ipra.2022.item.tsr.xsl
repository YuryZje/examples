<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>


    <xsl:template name="ipra2022ItemTsr">
        <xsl:param name="friExtract"/>
        <xsl:param name="header"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <xsl:choose>
                    <xsl:when test="$header != ''"><xsl:value-of select="$header"/></xsl:when>
                    <xsl:otherwise><xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/></xsl:otherwise>
                </xsl:choose>
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="15%"/>
                <fo:table-column column-width="10%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Перечень ТСР и услуг по реабилитации или абилитации</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Бюджет, за счёт средств которого предоставлены ТСР или оказаны услуги</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Количество</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Срок, в течение которого рекомендовано проведение реабилитационных или абилитационных мероприятий</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Исполнитель рекомендованных реабилитационных или абилитационных мероприятий</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <xsl:variable name="tsrName">
                            <xsl:value-of select="fri:find-twin-value(., 'Name', 'ServiceName')"/>
                        </xsl:variable>
                        <xsl:variable name="tsrQuantity">
                            <xsl:value-of select="fri:find-local-attribute-value(., 'Quantity')"/>
                        </xsl:variable>
                        <xsl:variable name="tsrDuration">
                            <xsl:value-of select="fri:find-local-attribute-value(., 'Duration')"/>
                        </xsl:variable>
                        <xsl:if test="$tsrName != ''">
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="$tsrName"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="fri:find-local-attribute-value(., 'BudgetName')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:choose>
                                            <xsl:when test="$tsrDuration != ''">
                                                <xsl:value-of select="$tsrDuration"/>&#160;<xsl:text>час</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="$tsrQuantity"/>&#160;<xsl:value-of select="fri:find-local-attribute-value(., 'UnitName')"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:variable name="from">
                                            <xsl:value-of select="fri:find-local-attribute-value(., 'From')"/>
                                        </xsl:variable>
                                        <xsl:variable name="to">
                                            <xsl:value-of select="fri:find-local-attribute-value(., 'To')"/>
                                        </xsl:variable>
                                        <xsl:variable name="indefinitely">
                                            <xsl:value-of select="fri:find-local-attribute-value(., 'Indefinitely')"/>
                                        </xsl:variable>
                                        <xsl:choose>
                                            <xsl:when test="$indefinitely = 'true'">
                                                <xsl:text>Бессрочно</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="concat(fri:format-date($from), ' - ', fri:format-date($to))"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="fri:find-local-attribute-value(., 'ExecutorName')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                    </xsl:for-each>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="5"><fo:block/></fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
