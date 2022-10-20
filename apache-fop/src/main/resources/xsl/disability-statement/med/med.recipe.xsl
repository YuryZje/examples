<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fri="http://fri.pfr.ru"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                exclude-result-prefixes="fo xs">

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:template name="medRecipe">
        <xsl:param name="friExtract"/>

        <fo:block font-size="12pt" padding-top="5mm" padding-bottom="5mm" text-align="left" background-color="#d7eafc">
            <fo:block margin-left="5mm">
                <xsl:value-of select="$friExtract[1]/fri:Категория/fri:Наименование"/>
            </fo:block>
        </fo:block>

        <fo:block font-size="6pt" padding-top="3mm">
            <fo:table table-layout="fixed" width="100%" text-align="center">
                <fo:table-column column-width="100%"/>
                <fo:table-body>
                    <xsl:for-each select="$friExtract">
                        <fo:table-row>
                            <fo:table-cell padding="2px" border="solid black 1px" text-align="left">
                                <fo:block></fo:block>
                                <xsl:call-template name="show-attribute-in-table">
                                    <xsl:with-param name="name" select="'Код заболевания:'"/>
                                    <xsl:with-param name="value" select="fri:find-local-attribute-value(., 'IllnessCode')"/>
                                </xsl:call-template>
                                <xsl:call-template name="show-attribute-in-table">
                                    <xsl:with-param name="name" select="'Название заболевания:'"/>
                                    <xsl:with-param name="value" select="fri:find-local-attribute-value(., 'IllnessName')"/>
                                </xsl:call-template>
                                <xsl:call-template name="show-attribute-in-table">
                                    <xsl:with-param name="name" select="'Код по МКБ-10:'"/>
                                    <xsl:with-param name="value" select="fri:find-local-attribute-value(., 'CodeMKB')"/>
                                </xsl:call-template>
                                <xsl:call-template name="show-attribute-in-table">
                                    <xsl:with-param name="name" select="'Группа лекарственного средства:'"/>
                                    <xsl:with-param name="value" select="fri:find-local-attribute-value(., 'DrugGroup')"/>
                                </xsl:call-template>
                                <xsl:call-template name="show-attribute-in-table">
                                    <xsl:with-param name="name" select="'Наименование лекарственного средства:'"/>
                                    <xsl:with-param name="value" select="fri:find-local-attribute-value(., 'DrugName')"/>
                                </xsl:call-template>
                                <xsl:call-template name="show-boolean-in-table">
                                    <xsl:with-param name="name" select="'Лекарственное средство выдано:'"/>
                                    <xsl:with-param name="value" select="fri:find-local-attribute-value(., 'IsDrugIssued')"/>
                                </xsl:call-template>
                                <xsl:call-template name="show-attribute-in-table">
                                    <xsl:with-param name="name" select="'Дата выдачи лекарства:'"/>
                                    <xsl:with-param name="value" select="fri:format-date(fri:find-local-attribute-value(., 'DrugIssueDate'))"/>
                                </xsl:call-template>
                            </fo:table-cell>
                        </fo:table-row>
                    </xsl:for-each>
                </fo:table-body>
            </fo:table>
        </fo:block>
    </xsl:template>

</xsl:stylesheet>
