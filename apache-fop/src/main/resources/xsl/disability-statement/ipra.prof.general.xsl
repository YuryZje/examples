<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="ipraProfGeneral">
        <xsl:param name="friExtract"/>
        <xsl:param name="isChild"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                Рекомендации по оснащению (оборудованию) специального рабочего места для трудоустройства <xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/>
            </fo:block>
        </fo:block>
        <xsl:variable name="needSpecialWorkPlaceRecom">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'NeedSpecialWorkPlaceRecom')"/>
        </xsl:variable>
        <xsl:variable name="specWorkPlaceForBadVision">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'SpecWorkPlaceForBadVision')"/>
        </xsl:variable>
        <xsl:variable name="specWorkPlaceForBadHearing">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'SpecWorkPlaceForBadHearing')"/>
        </xsl:variable>
        <xsl:variable name="specWorkPlaceForBadVisionHearing">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'SpecWorkPlaceForBadVisionHearing')"/>
        </xsl:variable>
        <xsl:variable name="specWorkPlaceForWheelChair">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'SpecWorkPlaceForWheelChair')"/>
        </xsl:variable>
        <xsl:variable name="specWorkPlaceForOtherDeseases">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'SpecWorkPlaceForOtherDeseases')"/>
        </xsl:variable>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <xsl:choose>
                        <xsl:when test="$needSpecialWorkPlaceRecom = 'true' or $specWorkPlaceForBadVision = 'true' or $specWorkPlaceForBadHearing = 'true'
                                          or $specWorkPlaceForBadVisionHearing = 'true' or $specWorkPlaceForWheelChair='true'
                                          or $specWorkPlaceForOtherDeseases = 'true'">
                            <xsl:call-template name="show-attribute-row">
                                <xsl:with-param name="attribute" select="$needSpecialWorkPlaceRecom"/>
                                <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'NeedSpecialWorkPlaceRecom')"/>
                                <xsl:with-param name="caption" select="'Нуждается ли в рекомендациях по оснащению специального рабочего места'"/>
                            </xsl:call-template>
                            <xsl:call-template name="show-attribute-row">
                                <xsl:with-param name="attribute" select="$specWorkPlaceForBadVision"/>
                                <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'SpecWorkPlaceForBadVision')"/>
                                <xsl:with-param name="caption" select="'Рекомендации по оснащению специального рабочего места для инвалида с нарушением зрения'"/>
                            </xsl:call-template>
                            <xsl:call-template name="show-attribute-row">
                                <xsl:with-param name="attribute" select="$specWorkPlaceForBadHearing"/>
                                <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'SpecWorkPlaceForBadHearing')"/>
                                <xsl:with-param name="caption" select="'Рекомендации по оснащению специального рабочего места для инвалида с нарушением слуха'"/>
                            </xsl:call-template>
                            <xsl:call-template name="show-attribute-row">
                                <xsl:with-param name="attribute" select="$specWorkPlaceForBadVisionHearing"/>
                                <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'SpecWorkPlaceForBadVisionHearing')"/>
                                <xsl:with-param name="caption" select="'Рекомендации по оснащению специального рабочего места для инвалида с нарушением слуха и зрения'"/>
                            </xsl:call-template>
                            <xsl:call-template name="show-attribute-row">
                                <xsl:with-param name="attribute" select="$specWorkPlaceForWheelChair"/>
                                <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'SpecWorkPlaceForWheelChair')"/>
                                <xsl:with-param name="caption"
                                                select="'Рекомендации по оснащению специального рабочего места для инвалида с нарушением функций опорно-двигательного аппарата, в том числе передвигающегося с использованием кресла-коляски'"/>
                            </xsl:call-template>
                            <xsl:call-template name="show-attribute-row">
                                <xsl:with-param name="attribute" select="$specWorkPlaceForOtherDeseases"/>
                                <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'SpecWorkPlaceForOtherDeseases')"/>
                                <xsl:with-param name="caption" select="'Рекомендации по оснащению специального рабочего места для инвалида с прочими нарушениями'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:text>Рекомендации по оснащению (оборудованию) специального рабочего места для трудоустройства инвалида</xsl:text>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:text>Отсутствуют</xsl:text>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:table-body>
            </fo:table>
        </fo:block>
        <fo:block padding-top="3mm"></fo:block>
        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                Рекомендации по производственной адаптации
            </fo:block>
        </fo:block>
        <xsl:variable name="needSocPsychAdaptation">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'NeedSocPsychAdaptation')"/>
        </xsl:variable>
        <xsl:variable name="needSocProdAdaptation">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'NeedSocProdAdaptation')"/>
        </xsl:variable>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <xsl:choose>
                        <xsl:when test="$needSocPsychAdaptation = 'true' or $needSocProdAdaptation = 'true'">
                            <xsl:call-template name="show-attribute-row">
                                <xsl:with-param name="attribute" select="$needSocPsychAdaptation"/>
                                <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'NeedSocPsychAdaptation')"/>
                                <xsl:with-param name="caption" select="'Cоциально-психологическая адаптация'"/>
                            </xsl:call-template>
                            <xsl:call-template name="show-attribute-row">
                                <xsl:with-param name="attribute" select="$needSocProdAdaptation"/>
                                <xsl:with-param name="attrType" select="fri:find-local-attribute-type($friExtract, 'NeedSocProdAdaptation')"/>
                                <xsl:with-param name="caption" select="'Cоциально-производственная адаптация'"/>
                            </xsl:call-template>
                        </xsl:when>
                        <xsl:otherwise>
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:text>Рекомендации по производственной адаптации</xsl:text>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:text>Отсутствуют</xsl:text>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
