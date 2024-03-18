<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="ipra2022ProfGeneral">
        <xsl:param name="friExtract"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <fo:block margin-left="5mm">
                    <xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/>
                </fo:block>
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">

            <xsl:variable name="employmentServiceHelpAgree" select="fri:find-local-attribute-name($friExtract, 'EmploymentServiceHelpAgree')"/>
            <xsl:variable name="employmentServiceInfoDate" select="fri:find-local-attribute-name($friExtract, 'EmploymentServiceInfoDate')"/>

            <xsl:if test="$employmentServiceHelpAgree != '' or $employmentServiceInfoDate != ''">
                <fo:table table-layout="fixed" width="100%" text-align="center" border="solid black 1px">
                    <fo:table-column column-width="80%"/>
                    <fo:table-column column-width="20%"/>
                    <fo:table-body>
                        <xsl:if test="$employmentServiceHelpAgree != ''">
                            <fo:table-row>
                                <fo:table-cell padding="2px" text-align="left"  border="solid black 1px">
                                    <fo:block><xsl:value-of select="fri:find-local-attribute-name($friExtract, 'EmploymentServiceHelpAgree')"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" text-align="center"  border="solid black 1px">
                                    <fo:block>
                                        <xsl:choose>
                                            <xsl:when test="fri:find-local-attribute-value($friExtract, 'EmploymentServiceHelpAgree') = 'true'"><xsl:value-of select="'Да'"/></xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of select="'Нет'"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                        <xsl:if test="$employmentServiceInfoDate != ''">
                            <fo:table-row>
                                <fo:table-cell padding="2px" text-align="left"  border="solid black 1px">
                                    <fo:block><xsl:value-of select="fri:find-local-attribute-name($friExtract, 'EmploymentServiceInfoDate')"/></fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" text-align="center"  border="solid black 1px">
                                    <fo:block>
                                        <xsl:value-of select="fri:format-date(fri:find-local-attribute-value($friExtract, 'EmploymentServiceInfoDate'))"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                        </xsl:if>
                    </fo:table-body>
                </fo:table>
            </xsl:if>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
