Class dc.carboncounter.Transportation Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property transportationId As %Integer(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property description As %String(MAXLEN = "");

Property year As %Integer;

Property fuel As dc.carboncounter.EmissionFactor;

Property fuelName As %String(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = {set {*}=##class(dc.carboncounter.EmissionFactor).%OpenId({fuel}).emissionName}, SqlComputed ];

Property amount As %Double;

Property co2 As %Double(SCALE = 8);

Property ch4 As %Double(SCALE = 8);

Property n2o As %Double(SCALE = 8);

Storage Default
{
<Data name="TransportationDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>description</Value>
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
<DataLocation>^dc.carbonco8293.TransportationD</DataLocation>
<DefaultData>TransportationDefaultData</DefaultData>
<IdLocation>^dc.carbonco8293.TransportationD</IdLocation>
<IndexLocation>^dc.carbonco8293.TransportationI</IndexLocation>
<StreamLocation>^dc.carbonco8293.TransportationS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
