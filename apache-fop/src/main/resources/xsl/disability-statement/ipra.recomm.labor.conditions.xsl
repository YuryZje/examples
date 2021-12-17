<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>


    <xsl:template name="ipraRecommLaborConditions">
        <xsl:param name="friExtract"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                Рекомендации о показанных и противопоказанных видах трудовой деятельности с учетом нарушенных функций организма
                человека, обусловленных заболеваниями, последствиями травм и дефектами
            </fo:block>
        </fo:block>
        <xsl:variable name="needsExtraBreaks">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'NeedsExtraBreaks')"/>
        </xsl:variable>
        <xsl:variable name="optimalWorkingConditions">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'OptimalWorkingConditions')"/>
        </xsl:variable>
        <xsl:variable name="anyEnvirButWithDifficulties">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'AnyEnvirButWithDifficulties')"/>
        </xsl:variable>
        <xsl:variable name="withAssistanceFromOthers">
            <xsl:value-of select="fri:find-local-attribute-value($friExtract, 'WithAssistanceFromOthers')"/>
        </xsl:variable>

        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <xsl:if test="$needsExtraBreaks = 'true'">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:text>Нуждается в дополнительных перерывах</xsl:text>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:text>Нуждается</xsl:text>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="$optimalWorkingConditions = 'true'">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:text>Доступны виды трудовой деятельности в оптимальных, допустимых условиях труда</xsl:text>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:text>Доступны</xsl:text>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="$anyEnvirButWithDifficulties = 'true'">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:text>Доступны виды трудовой деятельности в любых условиях труда, но выполнение трудовой деятельности может быть затруднено</xsl:text>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:text>Доступны</xsl:text>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                    <xsl:if test="$withAssistanceFromOthers = 'true'">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:text>Трудовая деятельность возможна при значительной помощи других лиц</xsl:text>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:text>Возможна</xsl:text>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:if>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
