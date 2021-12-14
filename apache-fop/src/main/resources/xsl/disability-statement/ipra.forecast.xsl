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
                <fo:table-cell border="solid black 1px" text-align="left">
                    <fo:block>
                        <xsl:value-of select="$functionValue"/>
                    </fo:block>
                </fo:table-cell>
            </fo:table-row>
        </xsl:if>
    </xsl:template>


    <xsl:template name="ipraForecast">
        <xsl:param name="friExtract"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">Прогнозируемый результат</fo:block>
        </fo:block>

        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Восстановление нарушенных функций'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'FuncRecoveryName')"/>
                    </xsl:call-template>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Достижение компенсации утраченных либо отсутствующих функций'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'FuncCompensationName')"/>
                    </xsl:call-template>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Восстановление (формирование) способности осуществлять самообслуживание'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'SelfServiceName')"/>
                    </xsl:call-template>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Самостоятельно передвигаться'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'MoveIndependentlyValue')"/>
                    </xsl:call-template>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Самостоятельно передвигаться'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'MoveIndependentlyValue')"/>
                    </xsl:call-template>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Ориентироваться'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'OrientateValue')"/>
                    </xsl:call-template>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Общаться'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'CommunicateValue')"/>
                    </xsl:call-template>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Контролировать свое поведение'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'BehaviorControlValue')"/>
                    </xsl:call-template>
                    <xsl:call-template name="rowIpraForecast">
                        <xsl:with-param name="functionName" select="'Обучаться'"/>
                        <xsl:with-param name="functionValue" select="fri:find-local-attribute-value($friExtract, 'WorkValue')"/>
                    </xsl:call-template>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
