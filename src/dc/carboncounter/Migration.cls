Class dc.carboncounter.Migration
{

// Migrate

ClassMethod Migrate() As %Status
{
    Set sc = $$$OK
    Set sc = ..MigrateEmissionUnit()
    Set sc = ..MigrateEmissionSegment()
    Set sc = ..MigrateEmissionType()
    
    Return sc
}

/// Migrate Emission Segment
ClassMethod MigrateEmissionSegment() As %Status
{
    Set sc = $$$OK
    Set sc = ..CreateEmissionSegment("S1 - Stationary Combustion","Stationary Combustion")
    Set sc = ..CreateEmissionSegment("S1 - Mobile Combustion","Mobile Combustion")
    Set sc = ..CreateEmissionSegment("S1 - Refrigerants and Fugitives","Refrigerants and Fugitives")
    Set sc = ..CreateEmissionSegment("S2 - Purchased Electricity", "Purchased Electricity")
    Set sc = ..CreateEmissionSegment("S3 - Transportation","Transportation")
    
    Return sc
}

ClassMethod CreateEmissionSegment(name As %String, description As %String) As %Status
{
    Set obj = ##class(dc.carboncounter.EmissionSegment).%New()
    Set obj.name = name
    Set obj.description = description
    Return obj.%Save()
}

/// Migrate Emission Type
ClassMethod MigrateEmissionType() As %Status
{
    Set sc = $$$OK
    Set sc = ..CreateEmissionType("Coal and Coke","S1 - Stationary Combustion")
    Set sc = ..CreateEmissionType("Other Fuels - Solid","S1 - Stationary Combustion")
    Set sc = ..CreateEmissionType("Biomass Fuels - Solid", "S1 - Stationary Combustion")
    Set sc = ..CreateEmissionType("Natural Gas", "S1 - Stationary Combustion")
    Set sc = ..CreateEmissionType("Other Fuels - Gaseous", "S1 - Stationary Combustion")
    Set sc = ..CreateEmissionType("Biomass Fuels - Gaseous", "S1 - Stationary Combustion")
    Set sc = ..CreateEmissionType("Petroleum Products", "S1 - Stationary Combustion")
    Set sc = ..CreateEmissionType("Mobile Fuel", "S1 - Mobile Combustion")
    Set sc = ..CreateEmissionType("Refrigerants", "S1 - Refrigerants and Fugitives")
    Set sc = ..CreateEmissionType("Grid Region - Location Based", "S2 - Purchased Electricity")
    Set sc = ..CreateEmissionType("eGrid Subregion - Residual Mix - Market Based", "S2 - Purchased Electricity")
    Set sc = ..CreateEmissionType("Transport", "S3 - Transportation")
    
    Return sc
}

ClassMethod CreateEmissionType(name As %String, emissionSegment As %String) As %Status
{
    Set obj = ##class(dc.carboncounter.EmissionType).%New()
    Set obj.name = name
    Set obj.emissionSegment = ..GetEmissionSegmentByName(emissionSegment)
    Return obj.%Save()
}

/// Migrate Emission Unit
ClassMethod MigrateEmissionUnit() As %Status
{
    Set sc = $$$OK
    Set sc = ..CreateEmissionUnit("mmBtu","Million British thermal units")
    Set sc = ..CreateEmissionUnit("kWh","Kilowatts-hour")
    Set sc = ..CreateEmissionUnit("gal (US)","US Gallon")
    Set sc = ..CreateEmissionUnit("scf", "Standard Cubic Foot")
    Set sc = ..CreateEmissionUnit("vehicle-mile", "Vehicle-mile")
    Set sc = ..CreateEmissionUnit("passenger-mile", "Passenger-mile")
    Set sc = ..CreateEmissionUnit("mile", "Mile")
    Set sc = ..CreateEmissionUnit("passenger-km", "Passenger-km")
    Set sc = ..CreateEmissionUnit("km", "Kilometer")
    Set sc = ..CreateEmissionUnit("ton-mile", "Ton Mile")
    Set sc = ..CreateEmissionUnit("tonne-km", "tonne-km")
    Set sc = ..CreateEmissionUnit("km", "Kilometer")
    
    Return sc
}

ClassMethod CreateEmissionUnit(name As %String, description As %String) As %Status
{
    Set obj = ##class(dc.carboncounter.EmissionUnit).%New()
    Set obj.name = name
    Set obj.description = description
    Return obj.%Save()
}

ClassMethod GetEmissionSegmentByName(name As %String) As dc.carboncounter.EmissionSegment
{
    Set qry = "SELECT ID FROM dc_carboncounter.EmissionSegment WHERE name = ?"
    Set tStatement = ##class(%SQL.Statement).%New()
    Set tSC = tStatement.%Prepare(qry)
    If tSC'=1 {WRITE "%Prepare failed:" DO $System.Status.DisplayError(tSC) QUIT}
    Set rset = tStatement.%Execute(name)
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.EmissionSegment).%OpenId(rset.ID)    
    } Else {
        Set obj = ""
    }
    Return obj
}

}
