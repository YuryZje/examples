<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="documentIpra">
        <xsl:param name="friDocument"/>
        <xsl:param name="documentCode"/>
        <xsl:param name="documentName"/>
        <xsl:param name="isChild"/>

        <xsl:if test="$documentCode != ''">
            <xsl:for-each select="$friDocument">
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.GENERAL')) != ''">
                    <xsl:call-template name="ipraMain">
                        <xsl:with-param name="friExtract"
                                        select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.GENERAL')]/ancestor::fri:Запись[1]"/>
                        <xsl:with-param name="documentName" select="$documentName"/>
                        <xsl:with-param name="isChild" select="$isChild"/>
                    </xsl:call-template>
                    <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.',  $documentCode, '.MED.EVENT')) != ''">
                        <xsl:call-template name="ipraEvent">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.',  $documentCode, '.MED.EVENT')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="documentCode" select="$documentCode"/>
                            <xsl:with-param name="header" select="''"/>
                        </xsl:call-template>
                    </xsl:if>
                    <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.MED.FORECAST')) != ''">
                        <fo:block padding-top="3mm">
                            <xsl:call-template name="ipraMedForecast">
                                <xsl:with-param name="friExtract"
                                                select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.MED.FORECAST')]/ancestor::fri:Запись[1]"/>
                            </xsl:call-template>
                        </fo:block>
                    </xsl:if>
                    <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.',  $documentCode, '.PSYCHOPED.EVENT')) != ''">
                        <xsl:variable name="header">
                            <xsl:choose>
                                <xsl:when test="$isChild = 'true'">
                                    <fo:block margin-left="5mm">Мероприятия общему и профессиональному образованию</fo:block>
                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:block margin-left="5mm">Мероприятия психолого-педагогической реабилитации или абилитации</fo:block>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:variable>
                        <fo:block padding-top="5mm">
                            <xsl:call-template name="ipraEvent">
                                <xsl:with-param name="friExtract"
                                                select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.',  $documentCode, '.PSYCHOPED.EVENT')]/ancestor::fri:Запись[1]"/>
                                <xsl:with-param name="documentCode" select="$documentCode"/>
                                <xsl:with-param name="header" select="$header"/>
                            </xsl:call-template>
                        </fo:block>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.PSYCHOPED.FORECAST')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="show-name-in-row">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PSYCHOPED.FORECAST')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="name" select="'Name'"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.PSYCHOPED.GROUP')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="show-name-in-row">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PSYCHOPED.GROUP')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="name" select="'GroupTypeName'"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.PROF.EVENT')) != ''">
                    <fo:block padding-top="5mm">
                        <xsl:call-template name="ipraEvent">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PROF.EVENT')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="documentCode" select="$documentCode"/>
                            <xsl:with-param name="header" select="''"/>
                        </xsl:call-template>
                        <xsl:variable name="employmentServiceHelpAgree">
                            <xsl:value-of select="fri:find-attribute-value(./fri:Запись, concat('MSE.', $documentCode, '.PROF.GENERAL'), 'EmploymentServiceHelpAgree')"/>
                        </xsl:variable>
                        <xsl:if test="$employmentServiceHelpAgree != '' and ($employmentServiceHelpAgree = 'true' or $employmentServiceHelpAgree = 'false')">
                            <fo:block font-size="8pt">
                                <fo:table table-layout="fixed" width="100%">
                                    <fo:table-column column-width="50%"/>
                                    <fo:table-column column-width="50%"/>
                                    <fo:table-body>
                                        <fo:table-row>
                                            <fo:table-cell padding="2px">
                                                <fo:block>
                                                    Информация о согласии инвалида на обращение к нему органов
                                                    службы занятости в целях оказания ему содействия в
                                                    трудоустройстве и подбора подходящего рабочего места:
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell padding="2px">
                                                <xsl:choose>
                                                    <xsl:when test="$employmentServiceHelpAgree = 'true'">
                                                        <fo:block text-align="center">Согласен</fo:block>
                                                    </xsl:when>
                                                    <xsl:when test="$employmentServiceHelpAgree = 'false'">
                                                        <fo:block text-align="center">Не согласен</fo:block>
                                                    </xsl:when>
                                                </xsl:choose>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </fo:table-body>
                                </fo:table>
                            </fo:block>
                        </xsl:if>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.PROF.FORECAST')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="show-name-in-row">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PROF.FORECAST')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="name" select="'Name'"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="$documentCode = 'IPR'">
                    <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.PROF.GROUP')) != ''">
                        <fo:block padding-top="3mm">
                            <xsl:call-template name="show-name-in-row">
                                <xsl:with-param name="friExtract"
                                                select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PROF.GROUP')]/ancestor::fri:Запись[1]"/>
                                <xsl:with-param name="name" select="'GroupTypeName'"/>
                            </xsl:call-template>
                        </fo:block>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.NONRECOMMLABORKINDS')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraNonRecommLaborKinds">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.NONRECOMMLABORKINDS')]/ancestor::fri:Запись[1]"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.RECOMMLABORCONDITIONS')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraRecommLaborConditions">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.RECOMMLABORCONDITIONS')]/ancestor::fri:Запись[1]"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.PROF.GENERAL')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraProfGeneral">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PROF.GENERAL')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="isChild" select="$isChild"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.PROF.RESTRICTION')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="show-name-value-in-row">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PROF.RESTRICTION')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="headerName" select="'Наименование класса условий труда'"/>
                            <xsl:with-param name="headerValue" select="'Код класса условий труда'"/>
                            <xsl:with-param name="name" select="'Name'"/>
                            <xsl:with-param name="value" select="'Class'"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.PROF.AVAILABLE')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:choose>
                            <xsl:when test="fri:find-attribute-value(./fri:Запись, concat('MSE.', $documentCode, '.PROF.AVAILABLE'), 'RecommendedWorkConditions') = ''">
                                <xsl:call-template name="show-name-value-in-row">
                                    <xsl:with-param name="friExtract"
                                                    select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PROF.AVAILABLE')]/ancestor::fri:Запись[1]"/>
                                    <xsl:with-param name="headerName" select="'Наименование класса условий труда'"/>
                                    <xsl:with-param name="headerValue" select="'Код класса условий труда'"/>
                                    <xsl:with-param name="name" select="'Name'"/>
                                    <xsl:with-param name="value" select="'Class'"/>
                                </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:call-template name="commonKeyValue">
                                    <xsl:with-param name="friExtract"
                                                    select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PROF.AVAILABLE')]/ancestor::fri:Запись[1]"/>
                                </xsl:call-template>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.PROF.RECOMMEND')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="show-name-in-row">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PROF.RECOMMEND')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="name" select="'Name'"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.SOCIAL.EVENT')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraEvent">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.SOCIAL.EVENT')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="documentCode" select="$documentCode"/>
                            <xsl:with-param name="header" select="''"/>
                        </xsl:call-template>
                    </fo:block>
                    <xsl:variable name="selfServicePossibleWithHelp">
                        <xsl:value-of select="fri:find-attribute-value(./fri:Запись, concat('MSE.', $documentCode, '.SOCIAL'), 'SelfServicePossibleWithHelp')"/>
                    </xsl:variable>
                    <xsl:if test="$selfServicePossibleWithHelp != ''">
                        <fo:block font-size="8pt" padding-top="1mm" padding-bottom="2mm">
                            <fo:table table-layout="fixed" width="100%">
                                <fo:table-column column-width="50%"/>
                                <fo:table-column column-width="50%"/>
                                <fo:table-body>
                                    <fo:table-row>
                                        <fo:table-cell padding="2px">
                                            <fo:block>Заключение о возможности (невозможности) осуществлять самообслуживание и вести самостоятельный образ жизни
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="2px">
                                            <fo:block text-align="left">
                                                <xsl:choose>
                                                    <xsl:when test="$selfServicePossibleWithHelp != ''">
                                                        <xsl:text>Возможно с регулярной помощью других лиц</xsl:text>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:variable name="isSelfServicePossible">
                                                            <xsl:value-of select="fri:find-attribute-value(./fri:Запись, concat('MSE.', $documentCode, '.SOCIAL'), 'IsSelfServicePossible')"/>
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
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.SOCIAL')) != ''">
                    <xsl:call-template name="ipraSocial">
                        <xsl:with-param name="friExtract"
                                        select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.SOCIAL')]/ancestor::fri:Запись[1]"/>
                        <xsl:with-param name="isChild" select="$isChild"/>
                    </xsl:call-template>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.SOCIAL.FORECAST')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraSocialForecast">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.SOCIAL.FORECAST')]/ancestor::fri:Запись[1]"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.SOCIAL.GROUP')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="show-name-in-row">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.SOCIAL.GROUP')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="name" select="'GroupTypeName'"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.PHYSIOTHERAPY.EVENT')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraEvent">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.PHYSIOTHERAPY.EVENT')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="documentCode" select="$documentCode"/>
                            <xsl:with-param name="header" select="'Физкультурно-оздоровительные мероприятия, мероприятия по занятию спортом'"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.TSR.FEDERAL.ITEM')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraItemTsr">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.TSR.FEDERAL.ITEM')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="header"
                                            select="concat('Рекомендуемые технические средства реабилитации (ТСР) и услуги по реабилитации или абилитации, предоставляемые ',
                                                    fri:invalid-type-name($isChild, 'Д'), ' за счет средств федерального бюджета')"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.TSR.FEDERAL')) != ''">
                    <xsl:variable name="needTransportHelpConcl">
                        <xsl:value-of select="fri:find-attribute-value(./fri:Запись, concat('MSE.', $documentCode, '.TSR.FEDERAL'), 'NeedTransportHelpConcl')"/>
                    </xsl:variable>
                    <xsl:if test="$needTransportHelpConcl != ''">
                        <fo:block padding-top="3mm" font-size="8pt">
                            <fo:table table-layout="fixed" width="100%">
                                <fo:table-column column-width="50%"/>
                                <fo:table-column column-width="50%"/>
                                <fo:table-body>
                                    <fo:table-row>
                                        <fo:table-cell padding="2px">
                                            <fo:block>
                                                Сопровождение инвалида к месту нахождения организации, в
                                                которую выдано направление для получения ТСР за счет
                                                средств федерального бюджета, и обратно:
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="2px">
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
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.TSR.OWNMONEY.ITEM')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraItemTsr">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.TSR.OWNMONEY.ITEM')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="header"
                                            select="concat('Технические средства реабилитации (ТСР) и услуги по реабилитации или абилитации, предоставляемые инвалиду за счет собственных средств ',
                                                    fri:invalid-type-name($isChild, 'Род'), ' либо средств других лиц или организаций независимо от организационно-правовых форм и форм собственности')"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.TSR.MSK')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraTsrMsk">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.TSR.MSK')]/ancestor::fri:Запись[1]"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.TSR.REGIONAL.ITEM')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraItemTsr">
                            <xsl:with-param name="friExtract" select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.TSR.REGIONAL.ITEM')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="header" select="concat('Рекомендуемые технические средства реабилитации (ТСР) и услуги по реабилитации или абилитации, предоставляемые
                            ', fri:invalid-type-name($isChild, 'Д'), ' за счет средств бюджета субъекта Российской Федерации')"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.TSR.LOCAL')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraTsrMsk">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.TSR.LOCAL')]/ancestor::fri:Запись[1]"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="$documentCode = 'IPR'">
                    <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.TSR')) != ''">
                        <fo:block padding-top="3mm">
                            <xsl:call-template name="ipraTsr">
                                <xsl:with-param name="friExtract"
                                                select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.TSR')]/ancestor::fri:Запись[1]"/>
                            </xsl:call-template>
                        </fo:block>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.IPRA.REHAB')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraEvent">
                            <xsl:with-param name="friExtract" select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.REHAB')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="documentCode" select="$documentCode"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.HELPITEM')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraHelp">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.HELPITEM')]/ancestor::fri:Запись[1]"/>
                            <xsl:with-param name="isChild" select="$isChild"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.FORECAST')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraForecast">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.FORECAST')]/ancestor::fri:Запись[1]"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>
                <xsl:if test="$documentCode = 'IPR'">
                    <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.MED.GROUP')) != ''">
                        <fo:block padding-top="3mm">
                            <xsl:call-template name="show-name-in-row">
                                <xsl:with-param name="friExtract"
                                                select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.MED.GROUP')]/ancestor::fri:Запись[1]"/>
                                <xsl:with-param name="name" select="'GroupTypeName'"/>
                            </xsl:call-template>
                        </fo:block>
                    </xsl:if>
                </xsl:if>
                <xsl:if test="fri:find-category(./fri:Запись, concat('MSE.', $documentCode, '.LIFE_RESTRICT')) != ''">
                    <fo:block padding-top="3mm">
                        <xsl:call-template name="ipraLifeRestrict">
                            <xsl:with-param name="friExtract"
                                            select="./fri:Запись/fri:Категория/fri:Код[text() = concat('MSE.', $documentCode, '.LIFE_RESTRICT')]/ancestor::fri:Запись[1]"/>
                        </xsl:call-template>
                    </fo:block>
                </xsl:if>

                <xsl:variable name="ipraNumberIpra">
                    <xsl:value-of select="fri:find-attribute-value(./fri:Запись, concat('MSE.', $documentCode, '.GENERAL'), 'Number')"/>
                </xsl:variable>
                <xsl:variable name="ipraNumber">
                    <xsl:choose>
                        <xsl:when test="$ipraNumberIpra = ''">
                            <xsl:value-of select="fri:find-attribute-value(./fri:Запись, concat('MSE.', $documentCode, '.GENERAL'), 'CardNumber')"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$ipraNumberIpra"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

                <xsl:if test = "$ipraNumber != ''">
                    <fo:block font-size="8pt" padding-top="1mm">
                        <fo:table table-layout="fixed" width="100%" text-align="center">
                            <fo:table-column column-width="50%"/>
                            <fo:table-column column-width="50%"/>
                            <fo:table-body>
                                <fo:table-row>
                                    <fo:table-cell border="none" text-align="left">
                                        <fo:block>Дата окончания действия <xsl:text> </xsl:text><xsl:value-of select="$documentName"/></fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell border="none" text-align="left">
                                        <fo:block>
                                            <xsl:value-of select="fri:format-date(fri:find-attribute-value(./fri:Запись, concat('MSE.', $documentCode, '.GENERAL'), 'EndDate'))"/>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-body>
                        </fo:table>
                    </fo:block>
                    <fo:block padding-top="3mm" text-align="center">
                        <fo:block font-size="16pt">Исполнение<xsl:text> </xsl:text><xsl:value-of select="$documentName"/></fo:block>
                        <fo:block font-size="6pt" padding-top="3mm">
                            <fo:table table-layout="fixed" width="100%" text-align="center">
                                <fo:table-column column-width="50%"/>
                                <fo:table-column column-width="50%"/>
                                <fo:table-body>
                                    <fo:table-row>
                                        <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                            <fo:block>Номер<xsl:text> </xsl:text><xsl:value-of select="$documentName"/>:</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                            <fo:block>
                                                <xsl:value-of select="$ipraNumber"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row>
                                        <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                            <fo:block>Номер и дата протокола проведения медико-социальной экспертизы:</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                            <fo:block>
                                                <xsl:value-of
                                                        select="concat(fri:find-attribute-value(./fri:Запись, concat('MSE.', $documentCode, '.GENERAL'), 'ProtocolNum'), ', ', fri:format-date(fri:find-attribute-value(./fri:Запись, concat('MSE.', $documentCode, '.GENERAL'), 'ProtocolDate')))"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                    <fo:table-row>
                                        <fo:table-cell padding="2px"  border="solid black 1px"  text-align="left">
                                            <fo:block>Сведения об исполнении мероприятий:</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                            <fo:block>
                                                <xsl:variable name="fssRehabilitation">
                                                    <xsl:value-of select="fri:find-category(./fri:Запись, 'FSS.REHABILITATION')"/>
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
            </xsl:for-each>
        </xsl:if>
    </xsl:template>

</xsl:stylesheet>
