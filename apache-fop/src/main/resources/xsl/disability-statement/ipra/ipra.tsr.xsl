<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>


    <xsl:template name="ipraTsr">
        <xsl:param name="friExtract"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/>
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-header>
                    <fo:table-row>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Наименование технического средства реабилитации</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Срок, в течение которого рекомендовано проведение реабилитационных мероприятий</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Исполнитель рекомендованных реабилитационных мероприятий</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Отметка о выполнении</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:if-null(fri:find-local-attribute-value(., 'Name'), fri:find-local-attribute-value(., 'ItemName'))"/>
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
                                    <xsl:value-of select="concat(fri:format-date($from), ' - ', fri:format-date($to))"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:find-local-attribute-value(., 'Executor')"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:if-null(fri:find-local-attribute-value(., 'ExecutorMarkName'), 'Нет данных')"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
