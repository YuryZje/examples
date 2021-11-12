<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>


    <xsl:template name="ipraHelp">
        <xsl:param name="friExtract"/>
        <xsl:param name="isChild"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                Виды помощи, в которых нуждается
                <xsl:value-of select="fri:invalid-type-name($isChild, 'Им')"/> для преодоления барьеров, препятствующих ему в получении услуг на объектах
                социальной, инженерной и транспортной инфраструктур наравне с другими лицами
            </fo:block>
        </fo:block>
        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="50%"/>
                <fo:table-column column-width="50%"/>
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <fo:table-row>
                            <fo:table-cell border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:value-of select="fri:find-local-attribute-value(., 'HelpValue')"/>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell border="solid black 1px" text-align="left">
                                <fo:block>
                                    <xsl:choose>
                                        <xsl:when test="fri:find-local-attribute-value(., 'IsNeeded') = 'true'">Нуждается</xsl:when>
                                        <xsl:otherwise>Не нуждается</xsl:otherwise>
                                    </xsl:choose>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                    <fo:table-row>
                        <fo:table-cell border="solid black 1px" text-align="left">
                            <fo:block>Дата окончания действия индивидуальной программы реабилитации или абилитации</fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid black 1px" text-align="left">
                            <fo:block>
                                <xsl:value-of select="fri:format-date(fri:find-attribute-value(//fri:Запись, 'MSE.IPRA.GENERAL', 'EndDate'))"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
