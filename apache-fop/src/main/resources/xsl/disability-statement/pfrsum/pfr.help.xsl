<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:function name="fri:nsu-text-value">
        <xsl:param name="nsu"/>
        <xsl:param name="future"/>

        <xsl:variable name="value">
           <xsl:choose>
               <xsl:when test="$nsu!='true'">
                   <xsl:choose>
                       <xsl:when test="$future='true'">
                           <xsl:text>Будет получать</xsl:text>
                       </xsl:when>
                           <xsl:otherwise>
                               <xsl:text>Получает</xsl:text>
                           </xsl:otherwise>
                   </xsl:choose>
               </xsl:when>
               <xsl:otherwise>
                   <xsl:choose>
                       <xsl:when test="$future='true'">
                           <xsl:text>Не будет получать</xsl:text>
                       </xsl:when>
                       <xsl:otherwise>
                           <xsl:text>Не получает</xsl:text>
                       </xsl:otherwise>
                   </xsl:choose>
               </xsl:otherwise>
           </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$value"/>
    </xsl:function>

    <xsl:template name="pfrHelp">
        <xsl:param name="friExtract"/>
        <xsl:param name="future"/>

        <xsl:for-each select="$friExtract">
            <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
                <fo:block margin-left="5mm">Получение (отказ) набора социальных услуг в <xsl:value-of select="fri:find-local-attribute-value(., 'NSUYear')"/> году</fo:block>
            </fo:block>
            <fo:block font-size="6pt" padding-top="5mm">
                <fo:table table-layout="fixed" width="100%" text-align="center">
                    <fo:table-column column-width="50%"/>
                    <fo:table-column column-width="50%"/>
                    <fo:table-body>

                            <fo:table-row  border-bottom="solid black 1px">
                                <fo:table-cell padding="2px" text-align="left">
                                    <fo:block>
                                        Обеспечение в соответствии со стандартами медицинской помощи необходимыми лекарственными препаратами для медицинского применения по рецептам на лекарственные препараты, медицинскими изделиями по рецептам на медицинские изделия, а также специализированными продуктами лечебного питания для детей-инвалидов
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" text-align="center">
                                    <fo:block>
                                        <xsl:value-of select="fri:nsu-text-value(fri:find-local-attribute-value(., 'NSU1'), $future)"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row  border-bottom="solid black 1px">
                                <fo:table-cell padding="2px" text-align="left">
                                    <fo:block>
                                        Предоставление при наличии медицинских показаний путевки на санаторно-курортное лечение, осуществляемое в целях профилактики основных заболеваний, в санаторно-курортные организации, определенные в соответствии с законодательством Российской Федерации о контрактной системе в сфере закупок товаров, работ, услуг для обеспечения государственных и муниципальных нужд
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" text-align="center">
                                    <fo:block>
                                        <xsl:value-of select="fri:nsu-text-value(fri:find-local-attribute-value(., 'NSU2'), $future)"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <fo:table-row  border-bottom="solid black 1px">
                                <fo:table-cell padding="2px" text-align="left">
                                    <fo:block>
                                        Бесплатный проезд на пригородном железнодорожном транспорте, а также на междугородном транспорте к месту лечения и обратно
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell padding="2px" text-align="center">
                                    <fo:block>
                                        <xsl:value-of select="fri:nsu-text-value(fri:find-local-attribute-value(., 'NSU3'), $future)"/>
                                    </fo:block>
                                </fo:table-cell>
                            </fo:table-row>

                    </fo:table-body>
                </fo:table>
            </fo:block>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
