<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="eduHigh">
        <xsl:param name="friExtract"/>
        <xsl:param name="isChild"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/>
            </fo:block>
        </fo:block>

        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <xsl:variable name="programKind" select="fri:find-local-attribute-value(., 'ProgramKind')"/>
                        <xsl:if test="$programKind != ''">
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>Тип документа об образовании</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <xsl:variable name="eduDocTypeNameCLS" select="fri:find-local-attribute-value(., 'EduDocTypeNameCLS')"/>
                                    <xsl:variable name="eduDocSerial" select="fri:find-local-attribute-value(., 'EduDocSerial')"/>
                                    <xsl:variable name="eduDocNumber" select="fri:find-local-attribute-value(., 'EduDocNumber')"/>
                                    <xsl:variable name="eduDocIssueDate" select="fri:find-local-attribute-value(., 'EduDocIssueDate')"/>
                                    <fo:block>
                                        <xsl:value-of select="concat($eduDocTypeNameCLS,',', 'серия ', $eduDocSerial, ',', ' номер ',  $eduDocNumber, ',' , ' Дата выдачи ', fri:format-date($eduDocIssueDate))"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>Наименование организации, осуществляющей образовательную деятельность</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="fri:find-local-attribute-value(., 'OrganizationName')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>Направление подготовки или специальность</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="fri:find-local-attribute-value(., 'Qualification')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>Форма обучения</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>
                                        <xsl:value-of select="fri:find-local-attribute-value(., 'EducationFormNameCLS')"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
