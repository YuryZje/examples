<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>


    <xsl:template name="showTsrRow">
        <xsl:param name="node"/>
        <xsl:for-each select="$node">
            <fo:table-row>
                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                    <fo:block>
                        <xsl:value-of select="fri:find-local-attribute-value(., 'Name')"/>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                    <fo:block>
                        <xsl:value-of select="fri:find-local-attribute-value(., 'Quantity')"/>&#160;<xsl:value-of select="fri:find-local-attribute-value(., 'UnitName')"/>
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
                        <xsl:variable name="toClass">
                            <xsl:value-of select="fri:find-local-attribute-value(., 'ToClass')"/>
                        </xsl:variable>
                        <xsl:choose>
                            <xsl:when test="$to != ''">
                                <xsl:value-of select="concat(fri:format-date($from), ' - ', fri:format-date($to))"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="concat(fri:format-date($from), ' - ', $toClass)"/>
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
    </xsl:template>

    <xsl:template name="ipraTsrMskRehab">
        <xsl:param name="friExtractTsr"/>
        <xsl:param name="friExtractRehab"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <xsl:value-of select="$friExtractTsr[1]/fri:Категория/fri:Наименование"/>
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
                            <fo:block>Перечень товаров и услуг, предназначенных для социальной адаптации и интеграции в общество детей-инвалидов, на приобретение которых направляются средства (часть средств) материнского (семейного) капитала</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Количество</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Срок, в течение которого рекомендовано проведение реабилитационных или абилитационных мероприятий с применением товаров и услуг, предназначенных для социальной адаптации и интеграции в общество детей-инвалидов, на приобретение которых направляются средства (часть средств) материнского (семейного) капитала</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="2px" border="solid black 1px" text-align="center">
                            <fo:block>Исполнитель, осуществляющий компенсацию затрат на приобретение товаров и услуг, предназначенных для социальной адаптации и интеграции в общество детей-инвалидов, на приобретение которых направляются средства (часть средств) материнского (семейного) капитала</fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-header>
                <fo:table-body>
                    <xsl:if test="$friExtractTsr !=''">
                        <xsl:call-template name="showTsrRow">
                            <xsl:with-param name="node" select="$friExtractTsr"/>
                        </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="$friExtractRehab !=''">
                        <xsl:call-template name="showTsrRow">
                            <xsl:with-param name="node" select="$friExtractRehab"/>
                        </xsl:call-template>
                    </xsl:if>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
