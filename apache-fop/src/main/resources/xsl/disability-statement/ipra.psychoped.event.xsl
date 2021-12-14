<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>


    <xsl:template name="showRow">
        <xsl:param name="node"/>
        <xsl:for-each select="$node">
            <fo:table-row>
                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                    <fo:block>
                        <xsl:value-of select="fri:find-local-attribute-value(., 'GroupTypeName')"/>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell border="solid black 1px" text-align="left">
                    <fo:block>
                        <xsl:choose>
                            <xsl:when test="fri:find-local-attribute-value(., 'IsNeeded') = 'true'">Нуждается</xsl:when>
                            <xsl:otherwise>Не нуждается</xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell border="solid black 1px" text-align="left">
                    <fo:block>
                        <xsl:variable name="from">
                            <xsl:value-of select="fri:find-local-attribute-value(., 'From')"/>
                        </xsl:variable>
                        <xsl:variable name="to">
                            <xsl:value-of select="fri:find-local-attribute-value(., 'To')"/>
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
                <fo:table-cell border="solid black 1px" text-align="left">
                    <fo:block>
                        <xsl:value-of select="fri:find-local-attribute-value(., 'Executor')"/>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="ipraPsychopedEvent">
        <xsl:param name="friExtract"/>
        <xsl:param name="isChild"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <xsl:choose>
                <xsl:when test="$isChild = 'true'">
                    <fo:block margin-left="5mm">Мероприятия по общему и профессиональному образованию</fo:block>
                </xsl:when>
                <xsl:otherwise>
                    <fo:block margin-left="5mm">Мероприятия по психолого-педагогической реабилитации или абилитации</fo:block>
                </xsl:otherwise>
            </xsl:choose>

        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                            <fo:block>Наименование группы мероприятий</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                            <fo:block>Заключение о нуждаемости (ненуждаемости) в проведении мероприятий по общему и профессиональному образоованию</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                            <fo:block>Срок, в течение которого рекомендовано проведение реабилитационных или абилитационных мероприятий</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                            <fo:block>Исполнитель заключения о нуждаемости в проведении реабилитационных или абилитационных мероприятий</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:call-template name="showRow">
                        <xsl:with-param name="node" select="$friExtract"/>
                    </xsl:call-template>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
