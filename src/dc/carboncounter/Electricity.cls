Class dc.carboncounter.Electricity Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property electricityId As %Integer(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property facilityId As %String;

Property year As %Integer;

Property energy As dc.carboncounter.EmissionFactor;

Property energyName As %String(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = {set {*}=##class(dc.carboncounter.EmissionFactor).%OpenId({energy}).emissionName}, SqlComputed ];

Property amount As %Double;

Property co2 As %Double(SCALE = 8);

Property ch4 As %Double(SCALE = 8);

Property n2o As %Double(SCALE = 8);

Storage Default
{
<Data name="ElectricityDefaultData">
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
<Value>energy</Value>
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
<DataLocation>^dc.carboncounter.ElectricityD</DataLocation>
<DefaultData>ElectricityDefaultData</DefaultData>
<IdLocation>^dc.carboncounter.ElectricityD</IdLocation>
<IndexLocation>^dc.carboncounter.ElectricityI</IndexLocation>
<StreamLocation>^dc.carboncounter.ElectricityS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
