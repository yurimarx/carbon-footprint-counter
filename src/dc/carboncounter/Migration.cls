Class dc.carboncounter.Migration
{

// Migrate

ClassMethod Migrate(Path As %String) As %Status
{
    Set sc = $$$OK
    Set sc = ..MigrateEmissionUnit()
    Set sc = ..MigrateEmissionSegment()
    Set sc = ..MigrateEmissionType()
    Set sc = ..MigrateEmissionFactor(Path)
    
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
    Set sc = ..CreateEmissionType("Transportation", "S3 - Transportation")
    Set sc = ..CreateEmissionType("Biomass Fuels - Liquid", "S1 - Stationary Combustion")
    Set sc = ..CreateEmissionType("Biomass Fuels - Kraft Pulping Liquor, by Wood Furnish", "S1 - Stationary Combustion")
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

ClassMethod GetEmissionUnitByName(name As %String) As dc.carboncounter.EmissionUnit
{
    Set qry = "SELECT ID FROM dc_carboncounter.EmissionUnit WHERE name = ?"
    Set tStatement = ##class(%SQL.Statement).%New()
    Set tSC = tStatement.%Prepare(qry)
    If tSC'=1 {WRITE "%Prepare failed:" DO $System.Status.DisplayError(tSC) QUIT}
    Set rset = tStatement.%Execute(name)
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.EmissionUnit).%OpenId(rset.ID)    
    } Else {
        Set obj = ""
    }
    Return obj
}

/// Migrate Emission Factor
ClassMethod MigrateEmissionFactor(Path As %String) As %Status
{
    Set sc = $$$OK
    Set stream=##class(%Stream.FileCharacter).%New()
    Set sc=stream.LinkToFile(Path)
    Do stream.ReadLine(,.sc)
    While 'stream.AtEnd {
        Set emissionFactor = ##class(EmissionFactor).%New()
        Set line = stream.ReadLine(,.sc)
        Set emissionFactor.emissionType = ##class(EmissionType).%OpenId($PIECE(line,";",1))
        Set emissionFactor.emissionName = $PIECE(line,";",2)
        Set emissionFactor.hhv = $NUMBER($PIECE(line,";",3),",")
        Set emissionFactor.co2Factor = $NUMBER($PIECE(line,";",4),",")
        Set emissionFactor.ch4Factor = $NUMBER($PIECE(line,";",5),",")
        Set emissionFactor.n2oFactor = $NUMBER($PIECE(line,";",6),",")
        Set emissionFactor.biogenicCo2Factor = $NUMBER($PIECE(line,";",7),",")
        Set emissionFactor.ar4 = $NUMBER($PIECE(line,";",8),",")
        Set emissionFactor.ar5 = $NUMBER($PIECE(line,";",9),",")
        Set emissionFactor.unit = ..GetEmissionUnitByName($PIECE(line,";",10))
        Set emissionFactor.source = $PIECE(line,";",11)
        Set emissionFactor.fuelEfficiency = $NUMBER($PIECE(line,";",12),",")
        //Set emissionFactor.secondUnit = ..GetEmissionUnitByName($PIECE(line,";",13))
        //Set emissionFactor.co4Kg = $NUMBER($PIECE(line,";",14),",")
        //Set emissionFactor.no2Kg = $NUMBER($PIECE(line,";",15),",")
        Set sc = emissionFactor.%Save()
    }
    Return sc
}

}
