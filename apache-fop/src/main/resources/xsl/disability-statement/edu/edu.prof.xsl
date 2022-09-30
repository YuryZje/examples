<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="eduProf">
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
                        <xsl:variable name="organizationName" select="fri:find-local-attribute-value(., 'OrganizationName')"/>
                        <xsl:variable name="programKindNameCLS" select="fri:find-local-attribute-value(., 'ProgramKindNameCLS')"/>
                        <xsl:variable name="professionName" select="fri:find-local-attribute-value(., 'ProfessionName')"/>
                        <xsl:if test="$organizationName != '' or programKindNameCLS != '' or professionName !='' ">
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>Наименование организации, осуществляющей образовательную деятельность</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block><xsl:value-of select="$organizationName"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>Вид образовательной программы</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block><xsl:value-of select="$programKindNameCLS"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block>Профессия рабочего, должность служащего</fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                    <fo:block><xsl:value-of select="$professionName"/></fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
