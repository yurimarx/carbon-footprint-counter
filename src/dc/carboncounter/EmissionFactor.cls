Class dc.carboncounter.EmissionFactor Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property emissionFactorId As %Integer(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property emissionType As dc.carboncounter.EmissionType;

Property emissionTypeName As %String(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = {set {*}=##class(dc.carboncounter.EmissionType).%OpenId({emissionType}).name}, SqlComputed ];

Property emissionName As %String(MAXLEN = 200);

Property hhv As %Double(SCALE = 8);

Property co2Factor As %Double(SCALE = 8);

Property ch4Factor As %Double(SCALE = 8);

Property n2oFactor As %Double(SCALE = 8);

Property biogenicCo2Factor As %Double(SCALE = 8);

Property ar4 As %Double(SCALE = 8);

Property ar5 As %Double(SCALE = 8);

Property unit As dc.carboncounter.EmissionUnit;

Property source As %String(MAXLEN = 500);

Property fuelEfficiency As %Double(SCALE = 8);

Property secondUnit As dc.carboncounter.EmissionUnit;

Property co4Kg As %Double(SCALE = 8);

Property no2Kg As %Double(SCALE = 8);

Storage Default
{
<Data name="EmissionFactorDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>emissionType</Value>
</Value>
<Value name="3">
<Value>emissionName</Value>
</Value>
<Value name="4">
<Value>hhv</Value>
</Value>
<Value name="5">
<Value>co2Factor</Value>
</Value>
<Value name="6">
<Value>ch4Factor</Value>
</Value>
<Value name="7">
<Value>n2oFactor</Value>
</Value>
<Value name="8">
<Value>biogenicCo2Factor</Value>
</Value>
<Value name="9">
<Value>ar4</Value>
</Value>
<Value name="10">
<Value>ar5</Value>
</Value>
<Value name="11">
<Value>unit</Value>
</Value>
<Value name="12">
<Value>source</Value>
</Value>
<Value name="13">
<Value>fuelEfficiency</Value>
</Value>
<Value name="14">
<Value>secondUnit</Value>
</Value>
<Value name="15">
<Value>co4Kg</Value>
</Value>
<Value name="16">
<Value>no2Kg</Value>
</Value>
</Data>
<DataLocation>^dc.carbonco8293.EmissionFactorD</DataLocation>
<DefaultData>EmissionFactorDefaultData</DefaultData>
<IdLocation>^dc.carbonco8293.EmissionFactorD</IdLocation>
<IndexLocation>^dc.carbonco8293.EmissionFactorI</IndexLocation>
<StreamLocation>^dc.carbonco8293.EmissionFactorS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
