Class App.Installer
{

XData setup
{
<Manifest>
  <Default Name="APPDIR" Dir="#{$system.Process.CurrentDirectory()}" />
  <Default Name="SourceDir" Dir="${APPDIR}/src" />
  <Default Name="NAMESPACE" Value="CARBONCOUNTER" />
  <Default Name="APPURL" Value="/carboncounter" />
  <Default Name="RESTURL" Value="/rest/carbon-counter" />
  <Default Name="CSPPATH" Dir="${APPDIR}/csp" />
  <Default Name="DBRESOURCE" Value="%DB_USER" />

  <Resource
    Name="${DBRESOURCE}" 
    Description="CarbonCounter"
    Permission="RW"/>

  <Namespace Name="${NAMESPACE}" Code="${NAMESPACE}-CODE" Data="${NAMESPACE}-DATA" Create="yes" Ensemble="no">
    <Configuration>
      <Database 
        Name="${NAMESPACE}-CODE" 
        Dir="${APPDIR}/db/code"
        Resource="${DBRESOURCE}" 
        Create="yes" />
      <Database 
        Name="${NAMESPACE}-DATA" 
        Dir="${APPDIR}/db/data" 
        Resource="${DBRESOURCE}"
        Create="yes" />
        
      <Import File="${SourceDir}" Flags="ck" Recurse="1"/>
    </Configuration>

    <CSPApplication 
      Url="${APPURL}"
      Description=""
      Directory="${CSPPATH}"
      Resource=""
      Grant="${DBRESOURCE}"
      Recurse="1"
      LoginClass=""
      CookiePath="${APPURL}"
      AuthenticationMethods="32" />

  </Namespace>

  <Invoke Class="App.Installer" Method="SetupREST" CheckStatus="1">
    <Arg Value="${NAMESPACE}"/>
    <Arg Value="${RESTURL}"/>
    <Arg Value="${DBRESOURCE}"/>
    <Arg Value="dc.carboncounter.CarbonCounterRESTAPI"/>
  </Invoke>

  <Invoke Class="App.Installer" Method="SetupMigrate" CheckStatus="1">
    <Arg Value="/opt/carbon-counter/emissionfactors.csv"/>
  </Invoke>


</Manifest>
}

ClassMethod setup(ByRef pVars, pLogLevel As %Integer = 3, pInstaller As %Installer.Installer, pLogger As %Installer.AbstractLogger) As %Status [ CodeMode = objectgenerator, Internal ]
{
  #; Let XGL document generate code for this method. 
  Quit ##class(%Installer.Manifest).%Generate(%compiledclass, %code, "setup")
}

ClassMethod SetupREST(pNameSpace As %String, pUrl As %String, pResource As %String, pClass As %String) As %Status
{
  New $Namespace
  Set $Namespace = "%SYS"
  Set p("NameSpace") = pNameSpace
  Set p("MatchRoles") = ":"_pResource
  Set p("DispatchClass") = pClass
  Set p("AutheEnabled") = $$$AutheCache
  Quit ##class(Security.Applications).Create(pUrl, .p)
}

ClassMethod SetupMigrate(Path As %String) As %Status
{
  Set $Namespace = "carboncounter"
  Quit ##class(dc.carboncounter.Migration).Migrate(Path)
}

}
