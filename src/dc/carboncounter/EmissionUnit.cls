Class dc.carboncounter.EmissionUnit Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property emissionUnitId As %Integer(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property name As %String;

Property description As %String(MAXLEN = "");

Storage Default
{
<Data name="EmissionUnitDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>description</Value>
</Value>
</Data>
<DataLocation>^dc.carboncounter.EmissionUnitD</DataLocation>
<DefaultData>EmissionUnitDefaultData</DefaultData>
<IdLocation>^dc.carboncounter.EmissionUnitD</IdLocation>
<IndexLocation>^dc.carboncounter.EmissionUnitI</IndexLocation>
<StreamLocation>^dc.carboncounter.EmissionUnitS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
