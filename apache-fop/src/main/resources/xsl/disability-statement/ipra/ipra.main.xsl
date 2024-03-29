<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="ipraMain">
        <xsl:param name="friExtract"/>
        <xsl:param name="documentName"/>
        <xsl:param name="isChild"/>

        <xsl:variable name="ipraNumberIpra">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'Number')"/>
        </xsl:variable>
        <xsl:variable name="ipraNumber">
            <xsl:choose>
                <xsl:when test="$ipraNumberIpra = ''">
                    <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'CardNumber')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$ipraNumberIpra"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="ipraDate">
            <xsl:value-of select="fri:format-date(fri:find-local-attribute-value($friExtract, 'IssueDate'))"/>
        </xsl:variable>
        <fo:block font-size="14pt" padding-top="5mm" padding-bottom="10mm" text-align="center">
            Мероприятия, назначенные в<xsl:text> </xsl:text><xsl:value-of select="$documentName"/>
            <fo:block>
                <xsl:value-of select="concat('№', $ipraNumber, ' от ', $ipraDate)"/>
            </fo:block>
            <fo:block font-size="10pt" padding-top="5mm">
                <fo:table table-layout="fixed" width="100%" text-align="left">
                    <fo:table-column column-width="50%"/>
                    <fo:table-column column-width="50%"/>
                    <fo:table-body>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell padding="2px">
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    Номер<xsl:text> </xsl:text><xsl:value-of select="$documentName"/><xsl:text> </xsl:text><xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/>:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px">
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:value-of select="$ipraNumber"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell padding="2px">
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    Номер и дата протокола проведения медико-социальной
                                    экспертизы:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px">
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
                                <fo:table-cell padding="2px">
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        Реабилитационный или абилитационный потенциал:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px">
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
                                <fo:table-cell padding="2px">
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        Реабилитационный или абилитационный прогноз:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px">
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'RehabPrognozValue')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell padding="2px">
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:value-of select="$documentName"/><xsl:text> </xsl:text><xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/> разработана:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px">
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:variable name="isFirst">
                                        <xsl:choose>
                                            <xsl:when test="fri:find-local-attribute-value($friExtract, 'IsFirst') = 'true'">Впервые</xsl:when>
                                            <xsl:when test="fri:find-local-attribute-value($friExtract, 'IsFirst') = 'false'">Повторно</xsl:when>
                                            <xsl:otherwise></xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:variable>
                                    <xsl:variable name="ipraEndDate">
                                        <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'EndDate')"/>
                                    </xsl:variable>
                                    <xsl:value-of select="$isFirst"/>
                                    <xsl:if test="$ipraEndDate != ''">
                                        <xsl:value-of select="concat(', на срок до ', fri:format-date($ipraEndDate))"/>
                                    </xsl:if>
                                    <xsl:variable name="endDateDescr">
                                        <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'EndDateDescr')"/>
                                    </xsl:variable>
                                    <xsl:if test="$endDateDescr != ''">
                                        <xsl:text> </xsl:text><xsl:value-of select="$endDateDescr"/>
                                    </xsl:if>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <xsl:variable name="isIntramural">
                            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'IsIntramural')"/>
                        </xsl:variable>
                        <xsl:if test="$isIntramural != ''">
                            <fo:table-row border-bottom="solid black 1px">
                                <fo:table-cell padding="2px">
                                    <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                        <xsl:value-of select="$documentName"/><xsl:text> </xsl:text><xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/> разрабатывалась при очном, заочном
                                        проведении медико-социальной экспертизы:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px">
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
                        <xsl:variable name="orgName">
                            <xsl:value-of select="fri:find-twin-value($friExtract, 'SentOrgName', 'MedOrgName')"/>
                        </xsl:variable>
                        <xsl:variable name="orgAddress">
                            <xsl:value-of select="fri:find-twin-value($friExtract, 'SentOrgAddress', 'MedOrgAddress')"/>
                        </xsl:variable>
                        <xsl:if test="$orgName != '' or $orgAddress = '' ">
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
                                            <xsl:value-of select="$orgName"/>
                                        </fo:block>
                                        <fo:block>
                                            <xsl:value-of select="$orgAddress"/>
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
                                        Дата вынесения решения по <xsl:value-of select="$documentName"/><xsl:text> </xsl:text><xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/>:
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
                                    Дата выдачи <xsl:value-of select="$documentName"/><xsl:text> </xsl:text><xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/>:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:value-of select="fri:format-date(fri:find-local-attribute-value($friExtract, 'IssueDate'))"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <xsl:variable name="needCarConclusion">
                            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'NeedCarConclusion')"/>
                        </xsl:variable>
                        <xsl:if test="$needCarConclusion != ''">
                            <fo:table-row>
                                <fo:table-cell padding="2px">
                                    <fo:block>
                                        Заключение о наличии медицинских показаний для
                                        приобретения
                                        <xsl:value-of select="fri:invalid-type-name($isChild, 'Тв')"/> транспортного средства за счет
                                        собственных средств
                                        <xsl:value-of select="fri:invalid-type-name($isChild, 'Род')"/> либо средств других лиц или
                                        организаций независимо от организационно-правовых форм и
                                        форм собственности:
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px">
                                    <fo:block text-align="left">
                                        <xsl:choose>
                                            <xsl:when test="$needCarConclusion = 'true'">Есть</xsl:when>
                                            <xsl:otherwise>Отсутствует</xsl:otherwise>
                                        </xsl:choose>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                    </fo:table-body>
                </fo:table>
            </fo:block>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
