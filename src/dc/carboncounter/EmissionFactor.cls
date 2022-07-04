Class dc.carboncounter.EmissionFactor Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONREFERENCE = "ID";

Property emissionFactorId As %Integer(%JSONINCLUDE = "outputonly") [ Calculated, SqlComputeCode = { set {*}={%%ID}}, SqlComputed ];

Property name As %String(MAXLEN = 300);

Property emissionType As dc.carboncounter.EmissionType;

Property emissionName As %String(MAXLEN = 200);

Property hhv As %Double;

Property co2Factor As %Double;

Property ch4Factor As %Double;

Property n2oFactor As %Double;

Property biogenicCo2Factor As %Double;

Property ar4 As %Double;

Property ar5 As %Double;

Property unit As dc.carboncounter.EmissionUnit;

Property source As %String(MAXLEN = 500);

Property fuelEfficiency As %Double;

Property secondUnit As dc.carboncounter.EmissionUnit;

Property co4Kg As %Double;

Property no2Kg As %Double;

Property bioFuel As %Boolean;

Storage Default
{
<Data name="EmissionFactorDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>emissionType</Value>
</Value>
<Value name="4">
<Value>emissionName</Value>
</Value>
<Value name="5">
<Value>hhv</Value>
</Value>
<Value name="6">
<Value>co2Factor</Value>
</Value>
<Value name="7">
<Value>ch4Factor</Value>
</Value>
<Value name="8">
<Value>n2oFactor</Value>
</Value>
<Value name="9">
<Value>biogenicCo2Factor</Value>
</Value>
<Value name="10">
<Value>ar4</Value>
</Value>
<Value name="11">
<Value>ar5</Value>
</Value>
<Value name="12">
<Value>unit</Value>
</Value>
<Value name="13">
<Value>source</Value>
</Value>
<Value name="14">
<Value>fuelEfficiency</Value>
</Value>
<Value name="15">
<Value>secondUnit</Value>
</Value>
<Value name="16">
<Value>co4Kg</Value>
</Value>
<Value name="17">
<Value>no2Kg</Value>
</Value>
<Value name="18">
<Value>bioFuel</Value>
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
