<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="ipraMain">
        <xsl:param name="friExtract"/>
        <xsl:param name="isChild"/>
        <xsl:variable name="ipraNumber">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'Number')"/>
        </xsl:variable>
        <xsl:variable name="ipraDate">
            <xsl:value-of select="fri:format-date(fri:find-local-attribute-value($friExtract, 'IssueDate'))"/>
        </xsl:variable>
        <fo:block font-size="14pt" padding-top="5mm" padding-bottom="10mm" text-align="center">
            Мероприятия, назначенные в ИПРА/ПРП
            <fo:block>
                <xsl:value-of select="concat('№', $ipraNumber, ' от ', $ipraDate)"/>
            </fo:block>
            <fo:block font-size="10pt" padding-top="5mm">
                <fo:table table-layout="fixed" width="100%" text-align="left">
                    <fo:table-column column-width="50%"/>
                    <fo:table-column column-width="50%"/>
                    <fo:table-body>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    Номер индивидуальной программы реабилитации или
                                    абилитации <xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/>:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:value-of select="$ipraNumber"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    Номер и дата протокола проведения медико-социальной
                                    экспертизы:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <fo:block>
                                        <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'ProtocolNum')"/>
                                    </fo:block>
                                    <fo:block>
                                        <xsl:value-of select="fri:format-date(fri:find-local-attribute-value($friExtract, 'ProtocolDate'))"/>
                                    </fo:block>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <xsl:variable name="rehabPotentialValue">
                            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'RehabPotentialValue')"/>
                        </xsl:variable>
                        <xsl:if test="$rehabPotentialValue != ''">
                            <fo:table-row border-bottom="solid black 1px">
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        Реабилитационный или абилитационный потенциал:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'RehabPotentialValue')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:variable name="rehabPrognozValue">
                            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'RehabPrognozValue')"/>
                        </xsl:variable>
                        <xsl:if test="$rehabPrognozValue != ''">
                            <fo:table-row border-bottom="solid black 1px">
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        Реабилитационный или абилитационный прогноз:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'RehabPrognozValue')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    ИПРА <xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/> разработана:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:variable name="isFirst">
                                        <xsl:choose>
                                            <xsl:when test="fri:find-local-attribute-value($friExtract, 'IsFirst') = 'true'">Впервые</xsl:when>
                                            <xsl:when test="fri:find-local-attribute-value($friExtract, 'IsFirst') = 'false'">Повторно</xsl:when>
                                            <xsl:otherwise></xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:variable>
                                    <xsl:variable name="ipraEndDate">
                                        <xsl:value-of select="fri:find-local-attribute-value(. , 'EndDate')"/>
                                    </xsl:variable>
                                    <xsl:value-of select="$isFirst"/>
                                    <xsl:if test="$ipraEndDate != ''">
                                        <xsl:value-of select="concat(', на срок до ', fri:format-date($ipraEndDate))"/>
                                    </xsl:if>
                                    <xsl:variable name="endDateDescr">
                                        <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'EndDateDescr')"/>
                                    </xsl:variable>
                                    <xsl:if test="$endDateDescr != ''">
                                        <xsl:value-of select="$endDateDescr"/>
                                    </xsl:if>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <xsl:variable name="isIntramural">
                            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'IsIntramural')"/>
                        </xsl:variable>
                        <xsl:if test="$isIntramural != ''">
                            <fo:table-row border-bottom="solid black 1px">
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        ИПРА
                                        <xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/> разрабатывалась при очном, заочном
                                        проведении медико-социальной экспертизы:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        <xsl:choose>
                                            <xsl:when test="$isIntramural = 'true'">Очно</xsl:when>
                                            <xsl:when test="$isIntramural = 'false'">Заочно</xsl:when>
                                            <xsl:otherwise></xsl:otherwise>
                                        </xsl:choose>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:variable name="sentOrgName">
                            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'SentOrgName')"/>
                        </xsl:variable>
                        <xsl:if test="$sentOrgName != ''">
                            <fo:table-row border-bottom="solid black 1px">
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        Наименование и адрес медицинской организации, направившей
                                        <xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/> на медико-социальную экспертизу:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        <fo:block>
                                            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'SentOrgName')"/>
                                        </fo:block>
                                        <fo:block>
                                            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'SentOrgAddress')"/>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row border-bottom="solid black 1px">
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        ОГРН медицинской организации, направившей
                                        <xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/> на
                                        медико-социальную экспертизу
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        <fo:block>
                                            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'SentOrgOgrn')"/>
                                        </fo:block>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:variable name="decisionDate">
                            <xsl:value-of select="fri:format-date(fri:find-local-attribute-value($friExtract, 'DecisionDate'))"/>
                        </xsl:variable>
                        <xsl:if test="$decisionDate != ''">
                            <fo:table-row border-bottom="solid black 1px">
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        Дата вынесения решения по ИПРА <xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/>:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell>
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        <xsl:value-of select="fri:format-date(fri:find-local-attribute-value($friExtract, 'DecisionDate'))"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    Дата выдачи ИПРА <xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/>:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:value-of select="fri:format-date(fri:find-local-attribute-value($friExtract, 'IssueDate'))"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:block>
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
