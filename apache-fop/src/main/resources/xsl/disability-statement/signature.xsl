<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="signature">
        <fo:block text-align="right" padding-top="5mm" font-size="5pt" color="blue">
            <fo:table table-layout="fixed" width="100%"  text-align="center" keep-together.within-page="always">
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-column column-width="25%"/>
                <fo:table-body>
                    <fo:table-row>
                        <fo:table-cell number-columns-spanned="3">
                            <fo:block><xsl:text> </xsl:text></fo:block>
                        </fo:table-cell>
                        <fo:table-cell border="solid blue 1px">
                            <fo:block>Документ подписан усиленной квалифицированной электронной подписью
                                <fo:block>
                                    <fo:table table-layout="fixed" width="100%" text-align="left">
                                        <fo:table-column column-width="40%"/>
                                        <fo:table-column column-width="60%"/>
                                        <fo:table-body>
                                            <fo:table-row >
                                                <fo:table-cell>
                                                    <fo:block><xsl:text>Организация</xsl:text></fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                    <fo:block><xsl:value-of select="$SIGNATURE.ORG"/></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row >
                                                <fo:table-cell>
                                                    <fo:block><xsl:text>Сертификат</xsl:text></fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                    <fo:block><xsl:value-of select="$CERTIFICATE"/></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row>
                                                <fo:table-cell>
                                                    <fo:block><xsl:text>Издатель</xsl:text></fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                    <fo:block><xsl:value-of select="$PUBLISHER"/></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                            <fo:table-row>
                                                <fo:table-cell>
                                                    <fo:block><xsl:text>Действителен</xsl:text></fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                    <fo:block>
                                                        <xsl:text>с </xsl:text><xsl:value-of select="$CERTIFICATE.DATEFROM"/><xsl:text> по </xsl:text><xsl:value-of select="$CERTIFICATE.DATETO"/></fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-body>
                                    </fo:table>
                                </fo:block>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </fo:table-body>
            </fo:table>

        </fo:block>
    </xsl:template>

</xsl:stylesheet>
