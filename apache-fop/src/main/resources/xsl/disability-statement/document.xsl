<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template match="fri:Документ">
        <xsl:param name="isChild"/>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.GENERAL') != ''">
            <xsl:call-template name="ipraMain">
                <xsl:with-param name="friExtract"
                                select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.GENERAL']/ancestor::fri:Запись[1]"/>
                <xsl:with-param name="isChild" select="$isChild"/>
            </xsl:call-template>
            <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.MED.EVENT') != ''">
                <xsl:call-template name="ipraEvent">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.MED.EVENT']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
            </xsl:if>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.PROF.EVENT') != ''">
            <fo:block padding-top="5mm">
                <xsl:call-template name="ipraEvent">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.PROF.EVENT']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
                <fo:block font-size="8pt">
                    <fo:table table-layout="fixed" width="100%">
                        <fo:table-column column-width="50%"/>
                        <fo:table-column column-width="50%"/>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>
                                        Информация о согласии инвалида на обращение к нему органов
                                        службы занятости в целях оказания ему содействия в
                                        трудоустройстве и подбора подходящего рабочего места:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <xsl:variable name="employmentServiceHelpAgree">
                                        <xsl:value-of select="fri:find-attribute-value(.//fri:Запись, 'MSE.IPRA.PROF.GENERAL', 'EmploymentServiceHelpAgree')"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="$employmentServiceHelpAgree = 'true'">
                                            <fo:block text-align="center">Согласен</fo:block>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <fo:block text-align="center">Не согласен</fo:block>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.NONRECOMMLABORKINDS') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraNonRecommLaborKinds">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.NONRECOMMLABORKINDS']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.RECOMMLABORCONDITIONS') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraRecommLaborConditions">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.RECOMMLABORCONDITIONS']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.PROF.GENERAL') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraProfGeneral">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.PROF.GENERAL']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="isChild" select="$isChild"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.SOCIAL.EVENT') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraEvent">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.SOCIAL.EVENT']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
            </fo:block>
            <fo:block font-size="8pt" padding-top="3mm">
                <fo:table table-layout="fixed" width="100%">
                    <fo:table-column column-width="50%"/>
                    <fo:table-column column-width="50%"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>Заключение о возможности (невозможности) осуществлять самообслуживание и вести самостоятельный образ жизни
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block text-align="left">
                                    <xsl:variable name="selfServicePossibleWithHelp">
                                        <xsl:value-of select="fri:find-attribute-value(.//fri:Запись, 'MSE.IPRA.SOCIAL', 'SelfServicePossibleWithHelp')"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="$selfServicePossibleWithHelp != ''">
                                            <xsl:text>Возможно с регулярной помощью других лиц</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:variable name="isSelfServicePossible">
                                                <xsl:value-of select="fri:find-attribute-value(.//fri:Запись, 'MSE.IPRA.SOCIAL', 'IsSelfServicePossible')"/>
                                            </xsl:variable>
                                            <xsl:choose>
                                                <xsl:when test="$isSelfServicePossible = 'true'">
                                                    <xsl:text>Возможно</xsl:text>
                                                </xsl:when>
                                                <xsl:when test="$isSelfServicePossible = 'false'">
                                                    <xsl:text>Невозможно</xsl:text>
                                                </xsl:when>
                                            </xsl:choose>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.SOCIAL') != ''">
            <xsl:call-template name="ipraSocial">
                <xsl:with-param name="friExtract"
                                select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.SOCIAL']/ancestor::fri:Запись[1]"/>
                <xsl:with-param name="isChild" select="$isChild"/>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.PHYSIOTHERAPY.EVENT') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraPhysiotherapyEvent">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.PHYSIOTHERAPY.EVENT']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.TSR.FEDERAL.ITEM') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraTsr">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.TSR.FEDERAL.ITEM']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="header"
                                    select="concat('Рекомендуемые технические средства реабилитации (ТСР) и услуги по реабилитации или абилитации, предоставляемые ',
                                                fri:invalid-type-name($isChild, 'Д'), ' за счет средств федерального бюджета')"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.TSR.FEDERAL') != ''">
            <xsl:variable name="needTransportHelpConcl">
                <xsl:value-of select="fri:find-attribute-value(.//fri:Запись, 'MSE.IPRA.TSR.FEDERAL', 'NeedTransportHelpConcl')"/>
            </xsl:variable>
            <xsl:if test="$needTransportHelpConcl != ''">
                <fo:block padding-top="3mm" font-size="8pt">
                    <fo:table table-layout="fixed" width="100%">
                        <fo:table-column column-width="50%"/>
                        <fo:table-column column-width="50%"/>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell>
                                    <fo:block>
                                        <xsl:value-of select="fri:find-attribute-name(.//fri:Запись, 'MSE.IPRA.TSR.FEDERAL', 'NeedTransportHelpConcl')"/>
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block text-align="left">
                                        <xsl:value-of select="$needTransportHelpConcl"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </xsl:if>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.TSR.OWNMONEY.ITEM') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraTsr">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.TSR.OWNMONEY.ITEM']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="header"
                                    select="concat('Технические средства реабилитации (ТСР) и услуги по реабилитации или абилитации, предоставляемые инвалиду за счет собственных средств ',
                                                fri:invalid-type-name($isChild, 'Род'), ' либо средств других лиц или организаций независимо от организационно-правовых форм и форм собственности')"/>
                </xsl:call-template>
            </fo:block>
            <fo:block font-size="8pt">
                <fo:table table-layout="fixed" width="100%">
                    <fo:table-column column-width="50%"/>
                    <fo:table-column column-width="50%"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                    Заключение о наличии медицинский показаний для
                                    приобретения
                                    <xsl:value-of select="fri:invalid-type-name($isChild, 'Тв')"/> транспортного средства за счет
                                    собственных средств
                                    <xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/> либо средств других лиц или
                                    организаций независимо от организационно-правовых форм и
                                    форм собственности:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block text-align="left">
                                    <xsl:variable name="needCarConclusion">
                                        <xsl:value-of select="fri:find-attribute-value(.//fri:Запись, 'MSE.IPRA.GENERAL', 'NeedCarConclusion')"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="$needCarConclusion = 'true'">Есть</xsl:when>
                                        <xsl:otherwise>Отсутствует</xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.TSR.MSK') != '' or fri:find-category(.//fri:Запись, 'MSE.IPRA.REHAB') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraTsrMskRehab">
                    <xsl:with-param name="friExtractTsr"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.TSR.MSK']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="friExtractRehab"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.REHAB']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.TSR.REGIONAL.ITEM') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraTsr">
                    <xsl:with-param name="friExtract" select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.TSR.REGIONAL.ITEM']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="header" select="''"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.HELPITEM') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraHelp">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.HELPITEM']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="isChild" select="$isChild"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'MSE.IPRA.FORECAST') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="commonKeyValue">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'MSE.IPRA.FORECAST']/ancestor::fri:Запись[1]"/>
                    <xsl:with-param name="header" select="'Прогнозируемый результат'"/>
                    <xsl:with-param name="isChild" select="$isChild"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-attribute-value(.//fri:Запись, 'MSE.IPRA.GENERAL', 'Number') != ''">
            <fo:block padding-top="3mm" text-align="center">
                <fo:block font-size="16pt">Исполнение ИПРА/ПРП</fo:block>
                <fo:block font-size="6pt" padding-top="3mm">
                    <fo:table table-layout="fixed" width="100%" text-align="center">
                        <fo:table-column column-width="50%"/>
                        <fo:table-column column-width="50%"/>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                                    <fo:block>Номер индивидуальной программы реабилитации или абилитации инвалида:</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="fri:find-attribute-value(.//fri:Запись, 'MSE.IPRA.GENERAL', 'Number')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                                    <fo:block>Номер и дата протокола проведения медико-социальной экспертизы:</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="fri:find-attribute-value(.//fri:Запись, 'MSE.IPRA.GENERAL', 'ProtocolNum')"/>
                                        <xsl:value-of select="fri:find-attribute-value(.//fri:Запись, 'MSE.IPRA.GENERAL', 'ProtocolDate')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell border="solid black 1px" padding="1mm" text-align="center">
                                    <fo:block>Сведения об исполнении мероприятий:</fo:block>
                                </fo:table-cell>
                                <fo:table-cell border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:variable name="fssRehabilitation">
                                            <xsl:value-of select="fri:find-category(.//fri:Запись, 'FSS.REHABILITATION')"/>
                                        </xsl:variable>
                                        <xsl:value-of select="$fssRehabilitation"/>
                                        <xsl:choose>
                                            <xsl:when test="$fssRehabilitation != ''">
                                                <xsl:text>Данные есть</xsl:text>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text>Нет данных</xsl:text>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </fo:block>
        </xsl:if>
        <xsl:if test="fri:find-category(.//fri:Запись, 'VHC.VEHICLE') != ''">
            <fo:block padding-top="3mm">
                <xsl:call-template name="ipraVHC">
                    <xsl:with-param name="friExtract"
                                    select="fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'VHC.VEHICLE']/ancestor::fri:Запись[1]"/>
                </xsl:call-template>
            </fo:block>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
