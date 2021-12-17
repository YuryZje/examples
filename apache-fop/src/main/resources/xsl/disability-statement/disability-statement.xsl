<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                xmlns:exsl="http://exslt.org/common"
                exclude-result-prefixes="fo xs exsl">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:param name="CERTIFICATE" select="''"/>
    <xsl:param name="PUBLISHER" select="''"/>
    <xsl:param name="CERTIFICATE.DATEFROM" select="''"/>
    <xsl:param name="CERTIFICATE.DATETO" select="''"/>

    <xsl:import href="function.xsl"/>
    <xsl:import href="templates.xsl"/>
    <xsl:import href="personal-data.xsl"/>
    <xsl:import href="document.xsl"/>
    <xsl:import href="ipra.xsl"/>
    <xsl:import href="ipra.event.xsl"/>
    <xsl:import href="ipra.non.recomm.labor.kinds.xsl"/>
    <xsl:import href="ipra.recomm.labor.conditions.xsl"/>
    <xsl:import href="ipra.prof.general.xsl"/>
    <xsl:import href="ipra.social.xsl"/>
    <xsl:import href="ipra.tsr.xsl"/>
    <xsl:import href="ipra.help.xsl"/>
    <xsl:import href="vch.xsl"/>
    <xsl:import href="ipra.tsr.msk.rehab.xsl"/>
    <xsl:import href="common.key.value.xsl"/>
    <xsl:import href="ipra.forecast.xsl"/>
    <xsl:import href="signature.xsl"/>

    <xsl:template match="fri:ВыпискаФРИ">

        <xsl:variable name="isChild">
            <xsl:value-of select="fri:ПерсональныеДанные/fri:АктуальныеСведенияОбИнвалидности/fri:Ребенок"/>
        </xsl:variable>

        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" font-family="DroidSansMono">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="pageA4"
                                       page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="2cm"
                                       margin-left="1.0cm" margin-right="1.0cm">
                    <fo:region-body margin-top="0.5cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="pageA4">
                <fo:flow flow-name="xsl-region-body">
                    <fo:block border-bottom="1.5pt black solid" display-align="center" text-align="center">
                        <fo:block font-size="12pt">ФЕДЕРАЛЬНАЯ ГОСУДАРСТВЕННАЯ ИНФОРМАЦИОННАЯ СИСТЕМА</fo:block>
                        <fo:block font-size="16pt">ФЕДЕРАЛЬНЫЙ РЕЕСТР ИНВАЛИДОВ</fo:block>
                    </fo:block>
                    <xsl:apply-templates select="//fri:ПерсональныеДанные"/>
                    <xsl:apply-templates select="//fri:Документ[fri:find-category(.//fri:Запись, 'MSE.IPRA.GENERAL') != '']">
                        <xsl:with-param name="isChild">
                            <xsl:value-of select="$isChild"/>
                        </xsl:with-param>
                    </xsl:apply-templates>
                    <xsl:apply-templates select="//fri:Документ[fri:find-category(.//fri:Запись, 'MSE.IPRA.GENERAL') = '']">
                        <xsl:with-param name="isChild">
                            <xsl:value-of select="$isChild"/>
                        </xsl:with-param>
                    </xsl:apply-templates>

                    <xsl:variable name="vhcExtract">
                        <xsl:copy-of select="fri:ВсеДокументы/fri:Документ/fri:ВсеСведения/fri:Запись/fri:Категория/fri:Код[text() = 'VHC.VEHICLE']/ancestor::fri:Запись[1]"/>
                    </xsl:variable>
                    <xsl:if test="$vhcExtract != ''">
                        <fo:block padding-top="3mm">
                            <fo:block font-size="6pt" padding-top="3mm">
                                <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
                                    <fo:block margin-left="5mm">
                                        <xsl:for-each-group select="exsl:node-set($vhcExtract)/*/fri:Категория" group-by="fri:Наименование">
                                            <xsl:value-of select="./fri:Наименование"/>
                                        </xsl:for-each-group>
                                    </fo:block>
                                </fo:block>
                                <fo:block padding-top="3mm">
                                    <fo:table table-layout="fixed" width="100%" text-align="center">
                                        <xsl:call-template name="ipraHeaderVHC">
                                            <xsl:with-param name="friExtract" select="exsl:node-set($vhcExtract)/*"/>
                                        </xsl:call-template>
                                        <xsl:call-template name="ipraBodyVHC">
                                            <xsl:with-param name="friExtract" select="exsl:node-set($vhcExtract)/*"/>
                                        </xsl:call-template>
                                    </fo:table>
                                </fo:block>
                            </fo:block>
                        </fo:block>
                    </xsl:if>
                    <xsl:call-template name="signature"/>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

</xsl:stylesheet>
