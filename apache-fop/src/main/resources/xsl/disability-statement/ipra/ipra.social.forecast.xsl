<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="rowIpraForecast">
        <xsl:param name="functionName"/>
        <xsl:param name="functionValue"/>

        <xsl:if test="$functionValue != ''">
            <fo:table-row>
                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                    <fo:block>
                        <xsl:value-of select="$functionName"/>
                    </fo:block>
                </fo:table-cell>
                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                    <fo:block>
                        <xsl:value-of select="$functionValue"/>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:if>
    </xsl:template>

    <xsl:template name="ipraSocialForecast">
        <xsl:param name="friExtract"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">Прогнозируемый результат по социальным мероприятиям реабилитации и абилитации</fo:block>
        </fo:block>

        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Cтепень достижения  или  формирования  способности к самообслуживанию'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'SelfServiceName')"/>
                    </xsl:call-template>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Степень восстановления навыков бытовой деятельности'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'CommonActivitiesRecoveryName')"/>
                    </xsl:call-template>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Степень восстановления социально-средового статуса'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'SocStatusName')"/>
                    </xsl:call-template>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
