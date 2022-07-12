Class dc.carboncounter.MobileCombustion Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property mobileCombustionId As %Integer(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property facilityId As %String;

Property year As %Integer;

Property fuel As dc.carboncounter.EmissionFactor;

Property fuelName As %String(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = {set {*}=##class(dc.carboncounter.EmissionFactor).%OpenId({fuel}).emissionName}, SqlComputed ];

Property amount As %Double;

Property co2 As %Double(SCALE = 8);

Property ch4 As %Double(SCALE = 8);

Property n2o As %Double(SCALE = 8);

Storage Default
{
<Data name="MobileCombustionDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>facilityId</Value>
</Value>
<Value name="3">
<Value>year</Value>
</Value>
<Value name="4">
<Value>fuel</Value>
</Value>
<Value name="5">
<Value>amount</Value>
</Value>
<Value name="6">
<Value>co2</Value>
</Value>
<Value name="7">
<Value>ch4</Value>
</Value>
<Value name="8">
<Value>n2o</Value>
</Value>
</Data>
<DataLocation>^dc.carbonc8293.MobileCombuDFACD</DataLocation>
<DefaultData>MobileCombustionDefaultData</DefaultData>
<IdLocation>^dc.carbonc8293.MobileCombuDFACD</IdLocation>
<IndexLocation>^dc.carbonc8293.MobileCombuDFACI</IndexLocation>
<StreamLocation>^dc.carbonc8293.MobileCombuDFACS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
