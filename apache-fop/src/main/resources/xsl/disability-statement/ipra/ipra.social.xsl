<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>


    <xsl:template name="ipraSocial">
        <xsl:param name="friExtract"/>
        <xsl:param name="isChild"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                Рекомендации по оборудованию жилого помещения, занимаемого <xsl:value-of select="fri:invalid-type-name($isChild, 'Тв')"/>, специальными средствами и приспособлениями с учетом
                нарушенных функций и ограничений жизнедеятельности
            </fo:block>
        </fo:block>
        <xsl:variable name="needHouseToolsForWheelChair">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'NeedHouseToolsForWheelChair')"/>
        </xsl:variable>
        <xsl:variable name="needHouseToolsForBadHearing">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'NeedHouseToolsForBadHearing')"/>
        </xsl:variable>
        <xsl:variable name="needHouseToolsForBadVision">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'NeedHouseToolsForBadVision')"/>
        </xsl:variable>
        <xsl:variable name="needHouseToolsForOtherDeseases">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'NeedHouseToolsForOtherDeseases')"/>
        </xsl:variable>
        <xsl:variable name="houseFacilitiesRecommendations">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'HouseFacilitiesRecommendations')"/>
        </xsl:variable>

        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <xsl:call-template name="show-attribute-row">
                        <xsl:with-param name="attribute" select="$needHouseToolsForWheelChair"/>
                        <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'NeedHouseToolsForWheelChair')"/>
                        <xsl:with-param name="caption" select="'Для инвалидов, имеющих нарушения здоровья со стойким расстройством функции опорно-двигательного аппарата, в том числе передвигающегося с использованием кресла-коляски'"/>
                    </xsl:call-template>
                    <xsl:call-template name="show-attribute-row">
                        <xsl:with-param name="attribute" select="$needHouseToolsForBadHearing"/>
                        <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'NeedHouseToolsForBadHearing')"/>
                        <xsl:with-param name="caption"
                                        select="'Для инвалидов, имеющих нарушения здоровья со стойким расстройством функции слуха, при необходимости использования вспомогательных средств'"/>
                    </xsl:call-template>
                    <xsl:call-template name="show-attribute-row">
                        <xsl:with-param name="attribute" select="$needHouseToolsForBadVision"/>
                        <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'NeedHouseToolsForBadVision')"/>
                        <xsl:with-param name="caption"
                                        select="'Для инвалидов, имеющих нарушения здоровья со стойким расстройством функции зрения, при необходимости использованию собаки-проводника, иных вспомогательных средств'"/>
                    </xsl:call-template>
                    <xsl:call-template name="show-attribute-row">
                        <xsl:with-param name="attribute" select="$needHouseToolsForOtherDeseases"/>
                        <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'NeedHouseToolsForOtherDeseases')"/>
                        <xsl:with-param name="caption" select="'Для инвалидов, имеющих нарушения здоровья со стойким расстройством иных функций'"/>
                    </xsl:call-template>
                    <xsl:call-template name="show-attribute-row">
                        <xsl:with-param name="attribute" select="$houseFacilitiesRecommendations"/>
                        <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'HouseFacilitiesRecommendations')"/>
                        <xsl:with-param name="caption" select="'Рекомендации по оборудованию специальными средствами и приспособлениями жилого помещения, занимаемого инвалидом'"/>
                    </xsl:call-template>
                    <fo:table-row><fo:table-cell><fo:block/></fo:table-cell></fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
