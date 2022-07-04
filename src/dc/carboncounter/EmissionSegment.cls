Class dc.carboncounter.EmissionSegment Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property emissionSegmentId As %Integer(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property name As %String(MAXLEN = 100);

Property description As %String(MAXLEN = "");

Storage Default
{
<Data name="EmissionSegmentDefaultData">
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
<DataLocation>^dc.carbonc8293.EmissionSegm257D</DataLocation>
<DefaultData>EmissionSegmentDefaultData</DefaultData>
<IdLocation>^dc.carbonc8293.EmissionSegm257D</IdLocation>
<IndexLocation>^dc.carbonc8293.EmissionSegm257I</IndexLocation>
<StreamLocation>^dc.carbonc8293.EmissionSegm257S</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
