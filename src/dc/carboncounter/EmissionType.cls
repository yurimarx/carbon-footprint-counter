Class dc.carboncounter.EmissionType Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property emissionTypeId As %Integer(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property name As %String(MAXLEN = 300);

Property emissionSegment As dc.carboncounter.EmissionSegment;

Storage Default
{
<Data name="EmissionTypeDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>emissionSegment</Value>
</Value>
</Data>
<DataLocation>^dc.carboncounter.EmissionTypeD</DataLocation>
<DefaultData>EmissionTypeDefaultData</DefaultData>
<IdLocation>^dc.carboncounter.EmissionTypeD</IdLocation>
<IndexLocation>^dc.carboncounter.EmissionTypeI</IndexLocation>
<StreamLocation>^dc.carboncounter.EmissionTypeS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
