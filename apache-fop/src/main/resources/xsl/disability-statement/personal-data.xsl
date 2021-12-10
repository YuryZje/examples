<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template match="fri:ПерсональныеДанные">
        <xsl:variable name="actualDisabilityInformationExist">
            <xsl:choose>
                <xsl:when test="fri:АктуальныеСведенияОбИнвалидности">
                    <xsl:text>true</xsl:text>
                </xsl:when>
                <xsl:otherwise><xsl:text>false</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>

        <fo:block font-size="14pt" text-align="center" padding-top="5mm">
            Профиль
        </fo:block>
        <fo:block font-size="10pt">
            <fo:table table-layout="fixed" width="100%">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell>
                            <fo:block>
                                <xsl:variable name="surname" select="fri:Фамилия"/>
                                <xsl:variable name="name" select="fri:Имя"/>
                                <xsl:variable name="patronymic" select="fri:Отчество"/>
                                <xsl:value-of select="fri:string-capitalize($name)"/>&#160;<xsl:value-of select="fri:string-capitalize($patronymic)"/>&#160;<xsl:value-of select="fri:string-capitalize($surname)"/>
                            </fo:block>
                            <fo:block padding-bottom="5mm">
                                Дата рождения:<xsl:value-of select="fri:format-date(fri:ДатаРождения)"/>
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block></fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border-bottom="solid black 1px">
                        <fo:table-cell>
                            <fo:block padding-bottom="0.5mm" padding-top="0.5mm">СНИЛС:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                <xsl:value-of select="fri:СНИЛС"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <fo:table-row border-bottom="solid black 1px">
                        <fo:table-cell>
                            <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Место жительства:</fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                <xsl:value-of select="fri:find-attribute-value(//fri:Запись, 'GENERAL.ADDRESS', 'AddressString')"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                    <xsl:if test="$actualDisabilityInformationExist='true'">
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Инвалидность установлена:</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:choose>
                                        <xsl:when test="fri:АктуальныеСведенияОбИнвалидности/fri:ПервичнаяИнвалидность = 'false'">
                                            <xsl:text>Повторно</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>Первично</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>

                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Дата установления инвалидности:</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:value-of select="fri:format-date(fri:АктуальныеСведенияОбИнвалидности/fri:ДатаС)"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Группа инвалидности:</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:variable name="invalidGroup">
                                        <xsl:value-of select="fri:АктуальныеСведенияОбИнвалидности/fri:ГруппаИнвалидности"/>
                                    </xsl:variable>
                                    <xsl:choose>
                                        <xsl:when test="$invalidGroup = 1">Первая группа</xsl:when>
                                        <xsl:when test="$invalidGroup = 2">Вторая группа</xsl:when>
                                        <xsl:when test="$invalidGroup = 3">Третья группа</xsl:when>
                                        <xsl:when test="$invalidGroup = 4">Категория «ребенок-инвалид»</xsl:when>
                                        <xsl:when test="$invalidGroup = 7">Инвалидность не установлена</xsl:when>
                                        <xsl:otherwise/>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Причина инвалидности:</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:value-of select="fri:АктуальныеСведенияОбИнвалидности/fri:НаименованиеПричиныИнвалидности"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Инвалидность установлена на срок до:</fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:value-of select="fri:format-date(fri:АктуальныеСведенияОбИнвалидности/fri:ДатаПо)"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Дата проведения очередного переосвидетельствования:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <xsl:value-of select="fri:format-date(fri:АктуальныеСведенияОбИнвалидности/fri:ОчередноеОсвидетельствование)"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Номер и дата акта освидетельствования гражданина ФГУ МСЭ:
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    Номер:<xsl:value-of select="fri:АктуальныеСведенияОбИнвалидности/fri:НомерАктаМСЭ"/>
                                </fo:block>
                                <fo:block>
                                    Дата:
                                    <xsl:value-of select="fri:format-date(fri:АктуальныеСведенияОбИнвалидности/fri:ДатаАктаМСЭ)"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>

                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Серия и номер справки, подтверждающей факт установления
                                    инвалидности (выписки из акта освидетельствования
                                    гражданина, признанного инвалидом):
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                    <fo:block>
                                        Серия:<xsl:value-of select="fri:АктуальныеСведенияОбИнвалидности/fri:СерияСправкиМСЭ"/>
                                    </fo:block>
                                    <fo:block>
                                        Номер:
                                        <xsl:value-of select="fri:АктуальныеСведенияОбИнвалидности/fri:НомерСправкиМСЭ"/>
                                    </fo:block>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                        <fo:table-row border-bottom="solid black 1px">
                            <fo:table-cell>
                                <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Дата выдачи справки, подтверждающей факт установления
                                    инвалидности (выписки из акта освидетельствования
                                    гражданина, признанного инвалидом):
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell>
                                <fo:block>
                                    <xsl:value-of select="fri:format-date(fri:АктуальныеСведенияОбИнвалидности/fri:ДатаСправкиМСЭ)"/>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <fo:table-row border-bottom="solid black 1px">
                        <fo:table-cell>
                            <fo:block padding-bottom="0.5mm" padding-top="0.5mm">Дата выдачи дубликата выписки из акта освидетельствования
                                гражданина, признанного инвалидом:
                            </fo:block>
                        </fo:table-cell>
                        <fo:table-cell>
                            <fo:block padding-bottom="0.5mm" padding-top="0.5mm">
                                <xsl:variable name="mseDublicatinfo">
                                    <xsl:value-of select="fri:find-attribute-value(//fri:Запись, 'MSE.DUBLICATINFO', 'OriginalIssueDate')"/>
                                </xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="$mseDublicatinfo != ''">
                                        <xsl:value-of select="$mseDublicatinfo"/>
                                    </xsl:when>
                                    <xsl:otherwise>Нет данных</xsl:otherwise>
                                </xsl:choose>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
