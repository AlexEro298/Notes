<?xml version="1.0" standalone="yes"?>
<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:junos="http://xml.juniper.net/junos/*/junos"
 xmlns:xnm="http://xml.juniper.net/xnm/1.1/xnm"
 xmlns:jcs="http://xml.juniper.net/junos/commit-scripts/1.0">
 <xsl:import href="../import/junos.xsl"/>

 <xsl:template match="configuration">
 <xsl:for-each select="system/host-name |
 interfaces/interface/unit/family/inet/address |
 interfaces/interface[name = 'fxp0']">
 <xsl:if test="not(@junos:group) or not(starts-with(@junos:group, 're'))">
 <xnm:warning>
 <xsl:call-template name="jcs:edit-path">
 <xsl:wit h-param name="dot" select=".."/>
 </xsl:call-template>
 <xsl:call-template name="jcs:statement"/>
 <message>
 <xsl:text>statement should not be in target</xsl:text>
 <xsl:text> configuration on dual RE system</xsl:text>
 </message>
 </xnm:warning>
 </xsl:if>
 </xsl:for-each>
 </xsl:template>
</xsl:stylesheet>