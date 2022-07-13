Class dc.carboncounter.CarbonCounterRESTAPI Extends dc.carboncounter.REST.Base
{

Parameter Version = "1.0.0";

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
<!-- Server Info -->
<Route Url="/" Method="GET" Call="GetInfo" Cors="true"/>
<!-- Swagger specs -->
<Route Url="/_spec" Method="GET" Call="SwaggerSpec" />

<!-- Get all records of emission unit class -->
<Route Url="/emissionunits" Method="GET" Call="GetAllEmissionUnits"/>
<!-- GET method to return JSON for a given emission unit id-->
<Route Url="/emissionunits/:id" Method="GET" Call="GetEmissionUnit"/>
<!-- Delete an emission unit with id-->
<Route Url="/emissionunits/:id" Method="DELETE" Call="DeleteEmissionUnit"/>
<!-- Post an emission unit -->
<Route Url="/emissionunits" Method="POST" Call="MergeEmissionUnit"/>

<!-- Get all records of emission type class -->
<Route Url="/emissiontypes" Method="GET" Call="GetAllEmissionType"/>
<!-- GET method to return JSON for a given emission type id-->
<Route Url="/emissiontypes/:id" Method="GET" Call="GetEmissionType"/>
<!-- Delete an emission type with id-->
<Route Url="/emissiontypes/:id" Method="DELETE" Call="DeleteEmissionType"/>
<!-- Post an emission type -->
<Route Url="/emissiontypes" Method="POST" Call="MergeEmissionType"/>

<!-- Get all records of emission segment class -->
<Route Url="/emissionsegments" Method="GET" Call="GetAllEmissionSegment"/>
<!-- GET method to return JSON for a given emission segment id-->
<Route Url="/emissionsegments/:id" Method="GET" Call="GetEmissionSegment"/>
<!-- Delete an emission segment with id-->
<Route Url="/emissionsegments/:id" Method="DELETE" Call="DeleteEmissionSegment"/>
<!-- Post an emission segment -->
<Route Url="/emissionsegments" Method="POST" Call="MergeEmissionSegment"/>

<!-- Get all records of emission factor class -->
<Route Url="/emissionfactors" Method="GET" Call="GetAllEmissionFactor"/>
<!-- GET method to return JSON for a given emission factor id-->
<Route Url="/emissionfactors/:id" Method="GET" Call="GetEmissionFactor"/>
<!-- Delete an emission factor with id-->
<Route Url="/emissionfactors/:id" Method="DELETE" Call="DeleteEmissionFactor"/>
<!-- Post an emission factor -->
<Route Url="/emissionfactors" Method="POST" Call="MergeEmissionFactor"/>
<!-- get emission factors by segment -->
<Route Url="/emissionfactors/segment/:id" Method="GET" Call="GetAllEmissionFactorBySegment"/>


<!-- Get all records of stationary combustion class -->
<Route Url="/stationary" Method="GET" Call="GetAllStationary"/>
<!-- GET method to return JSON for a given stationary combustion id-->
<Route Url="/stationary/:id" Method="GET" Call="GetStationary"/>
<!-- GET method to return carbon calculation JSON for a given emission factor id-->
<Route Url="/stationary/calculate/:id/:amount" Method="GET" Call="GetStationaryCalculation"/>
<!-- Delete an stationary combustion with id-->
<Route Url="/stationary/:id" Method="DELETE" Call="DeleteStationary"/>
<!-- Post an stationary combustion -->
<Route Url="/stationary" Method="POST" Call="MergeStationary"/>

<!-- Get all records of mobile combustion class -->
<Route Url="/mobile" Method="GET" Call="GetAllMobile"/>
<!-- GET method to return JSON for a given mobile combustion id-->
<Route Url="/mobile/:id" Method="GET" Call="GetMobile"/>
<!-- GET method to return carbon calculation JSON for a given emission factor id-->
<Route Url="/mobile/calculate/:id/:amount" Method="GET" Call="GetMobileCalculation"/>
<!-- Delete an mobile combustion with id-->
<Route Url="/mobile/:id" Method="DELETE" Call="DeleteMobile"/>
<!-- Post an mobile combustion -->
<Route Url="/mobile" Method="POST" Call="MergeMobile"/>

<!-- Get all records of transportation class -->
<Route Url="/transportation" Method="GET" Call="GetAllTransportation"/>
<!-- GET method to return JSON for a given transportaion id-->
<Route Url="/transportation/:id" Method="GET" Call="GetTransportation"/>
<!-- GET method to return carbon calculation JSON for a given emission factor id-->
<Route Url="/transportation/calculate/:id/:amount" Method="GET" Call="GetTransportationCalculation"/>
<!-- Delete a transportation with id-->
<Route Url="/transportation/:id" Method="DELETE" Call="DeleteTransportation"/>
<!-- Post a transportation -->
<Route Url="/transportation" Method="POST" Call="MergeTransportation"/>


<!-- Get all records of electricity class -->
<Route Url="/electricity" Method="GET" Call="GetAllElectricity"/>
<!-- GET method to return JSON for a given electricity id-->
<Route Url="/electricity/:id" Method="GET" Call="GetElectricity"/>
<!-- GET method to return carbon calculation JSON for a given emission factor id-->
<Route Url="/electricity/calculate/:id/:amount" Method="GET" Call="GetElectricityCalculation"/>
<!-- Delete an electricity with id-->
<Route Url="/electricity/:id" Method="DELETE" Call="DeleteElectricity"/>
<!-- Post an electricity -->
<Route Url="/electricity" Method="POST" Call="MergeElectricity"/>

<!-- Get all records of electricity class -->
<Route Url="/totals" Method="GET" Call="GetTotals"/>


</Routes>
}

/// PersonsREST general information
ClassMethod GetInfo() As %Status
{
  SET version = ..#Version
  SET info = {
    "version": (version)
  }
  RETURN ..%ProcessResult($$$OK, info)
}

/// Retrieve all the records of Emission Unit
ClassMethod GetAllEmissionUnits() As %Status
{

    #dim tSC As %Status = $$$OK

    Set tSC = ..GetSQLResults("SELECT ID FROM dc_carboncounter.EmissionUnit", .rset)
  
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.EmissionUnit).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    While rset.%Next() {   
        Write ","
        Set obj = ##class(dc.carboncounter.EmissionUnit).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    Write "]"
    Quit tSC
}

/// Return one record of Emission Unit
ClassMethod GetEmissionUnit(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.EmissionUnit).%OpenId(id)

    If '$IsObject(obj) Quit ..Http404()

    Do obj.%JSONExport()

    Quit tSC
}

/// Creates or update an Emission Unit record
ClassMethod MergeEmissionUnit() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set data=%request.Content
    
    If data.emissionUnitId '= "" {
        Set obj = ##class(dc.carboncounter.EmissionUnit).%OpenId(data.emissionUnitId)
    } Else {
        Set obj = ##class(dc.carboncounter.EmissionUnit).%New()
    }
    
    $$$TOE(tSC,obj.%JSONImport(data))
    $$$TOE(tSC,obj.%Save())

    Set %response.Status = 204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do obj.%JSONExport()

    Quit tSC
}

/// Delete a record with id in Emission Unit
ClassMethod DeleteEmissionUnit(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set obj = ##class(dc.carboncounter.EmissionUnit).%OpenId(id)
    If '$IsObject(obj) Return ..Http404()

    $$$TOE(tSC,obj.%DeleteId(id))

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

/// Retrieve all the records of Emission Type
ClassMethod GetAllEmissionType() As %Status
{

    #dim tSC As %Status = $$$OK

    Set tSC = ..GetSQLResults("SELECT ID FROM dc_carboncounter.EmissionType", .rset)
  
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.EmissionType).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    While rset.%Next() {   
        Write ","
        Set obj = ##class(dc.carboncounter.EmissionType).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    Write "]"
    Quit tSC
}

/// Return one record of Emission Type
ClassMethod GetEmissionType(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.EmissionType).%OpenId(id)

    If '$IsObject(obj) Quit ..Http404()

    Do obj.%JSONExport()

    Quit tSC
}

/// Creates or update an Emission Type record
ClassMethod MergeEmissionType() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set data=%request.Content
    
    If data.emissionTypeId '= "" {
        Set obj = ##class(dc.carboncounter.EmissionType).%OpenId(data.emissionTypeId)
    } Else {
        Set obj = ##class(dc.carboncounter.EmissionType).%New()
    }
    
    $$$TOE(tSC,obj.%JSONImport(data))
    $$$TOE(tSC,obj.%Save())

    Set %response.Status = 204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do obj.%JSONExport()

    Quit tSC
}

/// Delete a record with id in Emission Type
ClassMethod DeleteEmissionType(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set obj = ##class(dc.carboncounter.EmissionType).%OpenId(id)
    If '$IsObject(obj) Return ..Http404()

    $$$TOE(tSC,obj.%DeleteId(id))

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

/// Retrieve all the records of Emission Segment
ClassMethod GetAllEmissionSegment() As %Status
{

    #dim tSC As %Status = $$$OK

    Set tSC = ..GetSQLResults("SELECT ID FROM dc_carboncounter.EmissionSegment", .rset)
  
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.EmissionSegment).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    While rset.%Next() {   
        Write ","
        Set obj = ##class(dc.carboncounter.EmissionSegment).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    Write "]"
    Quit tSC
}

/// Return one record of Emission Segment
ClassMethod GetEmissionSegment(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.EmissionSegment).%OpenId(id)

    If '$IsObject(obj) Quit ..Http404()

    Do obj.%JSONExport()

    Quit tSC
}

/// Creates or update an Emission Segment record
ClassMethod MergeEmissionSegment() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set data=%request.Content
    
    If data.emissionSegmentId '= "" {
        Set obj = ##class(dc.carboncounter.EmissionSegment).%OpenId(data.emissionSegmentId)
    } Else {
        Set obj = ##class(dc.carboncounter.EmissionSegment).%New()
    }
    
    $$$TOE(tSC,obj.%JSONImport(data))
    $$$TOE(tSC,obj.%Save())

    Set %response.Status = 204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do obj.%JSONExport()

    Quit tSC
}

/// Delete a record with id in Emission Segment
ClassMethod DeleteEmissionSegment(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set obj = ##class(dc.carboncounter.EmissionSegment).%OpenId(id)
    If '$IsObject(obj) Return ..Http404()

    $$$TOE(tSC,obj.%DeleteId(id))

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

/// Retrieve all the records of Emission Factor
ClassMethod GetAllEmissionFactor() As %Status
{

    #dim tSC As %Status = $$$OK

    Set tSC = ..GetSQLResults("SELECT ID FROM dc_carboncounter.EmissionFactor", .rset)
  
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    While rset.%Next() {   
        Write ","
        Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    Write "]"
    Quit tSC
}

/// Retrieve all the records of Emission Factor by segment
ClassMethod GetAllEmissionFactorBySegment(id As %Integer) As %Status
{

    #dim tSC As %Status = $$$OK

    Set tSC = ..GetSQLResults("SELECT ID FROM dc_carboncounter.EmissionFactor WHERE emissionType->emissionSegment->emissionSegmentId = ?", .rset, id)
  
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    While rset.%Next() {   
        Write ","
        Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    Write "]"
    Quit tSC
}

/// Return one record of Emission Factor
ClassMethod GetEmissionFactor(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(id)

    If '$IsObject(obj) Quit ..Http404()

    Do obj.%JSONExport()

    Quit tSC
}

/// Creates or update an Emission Factor record
ClassMethod MergeEmissionFactor() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set data=%request.Content
    
    If data.emissionFactorId '= "" {
        Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(data.emissionFactorId)
    } Else {
        Set obj = ##class(dc.carboncounter.EmissionFactor).%New()
    }
    
    $$$TOE(tSC,obj.%JSONImport(data))
    $$$TOE(tSC,obj.%Save())

    Set %response.Status = 204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do obj.%JSONExport()

    Quit tSC
}

/// Delete a record with id in Emission Factor
ClassMethod DeleteEmissionFactor(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(id)
    If '$IsObject(obj) Return ..Http404()

    $$$TOE(tSC,obj.%DeleteId(id))

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

/// Retrieve all the records of Stationary Combustion
ClassMethod GetAllStationary() As %Status
{

    #dim tSC As %Status = $$$OK

    Set tSC = ..GetSQLResults("SELECT ID FROM dc_carboncounter.StationaryCombustion", .rset)
  
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.StationaryCombustion).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    While rset.%Next() {   
        Write ","
        Set obj = ##class(dc.carboncounter.StationaryCombustion).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    Write "]"
    Quit tSC
}

/// Return one record of Stationary Combustion
ClassMethod GetStationary(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.StationaryCombustion).%OpenId(id)

    If '$IsObject(obj) Quit ..Http404()

    Do obj.%JSONExport()

    Quit tSC
}

/// Return the carbon calculation of Stationary Combustion
ClassMethod GetStationaryCalculation(id As %Integer, amount As %Double) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(id)

    Set result = ##class(dc.carboncounter.StationaryCombustion).%New()
    Set result.fuel = obj
    Set result.co2 = obj.co2Factor * (amount/1000)
    Set result.ch4 = obj.ch4Factor * (amount/1000000)
    Set result.n2o = obj.n2oFactor * (amount/1000000)

    If '$IsObject(obj) Quit ..Http404()

    Do result.%JSONExport()

    Quit tSC
}

/// Creates or update an Stationary Combustion record
ClassMethod MergeStationary() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set data=%request.Content
    
    If data.stationaryCombustionId '= "" {
        Set obj = ##class(dc.carboncounter.StationaryCombustion).%OpenId(data.stationaryCombustionId)
    } Else {
        Set obj = ##class(dc.carboncounter.StationaryCombustion).%New()
    }
    
    $$$TOE(tSC,obj.%JSONImport(data))
    $$$TOE(tSC,obj.%Save())

    Set %response.Status = 204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do obj.%JSONExport()

    Quit tSC
}

/// Delete a record with id in Stationary Combustion
ClassMethod DeleteStationary(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set obj = ##class(dc.carboncounter.StationaryCombustion).%OpenId(id)
    If '$IsObject(obj) Return ..Http404()

    $$$TOE(tSC,obj.%DeleteId(id))

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

/// Retrieve all the records of Mobile Combustion
ClassMethod GetAllMobile() As %Status
{

    #dim tSC As %Status = $$$OK

    Set tSC = ..GetSQLResults("SELECT ID FROM dc_carboncounter.MobileCombustion", .rset)
  
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.MobileCombustion).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    While rset.%Next() {   
        Write ","
        Set obj = ##class(dc.carboncounter.MobileCombustion).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    Write "]"
    Quit tSC
}

/// Return one record of Mobile Combustion
ClassMethod GetMobile(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.MobileCombustion).%OpenId(id)

    If '$IsObject(obj) Quit ..Http404()

    Do obj.%JSONExport()

    Quit tSC
}

/// Return the carbon calculation of Mobile Combustion
ClassMethod GetMobileCalculation(id As %Integer, amount As %Double) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(id)

    Set result = ##class(dc.carboncounter.MobileCombustion).%New()
    Set result.fuel = obj
    Set result.co2 = obj.co2Factor * (amount/1000)
    Set result.ch4 = obj.ch4Factor * (amount/1000)
    Set result.n2o = obj.n2oFactor * (amount/1000)

    If obj.fuelEfficiency '= "" {
        Set result.co2 = result.co2 / obj.fuelEfficiency
        Set result.ch4 = result.ch4 / obj.fuelEfficiency
        Set result.n2o = result.n2o / obj.fuelEfficiency
    }

    If '$IsObject(obj) Quit ..Http404()

    Do result.%JSONExport()

    Quit tSC
}

/// Creates or update an Mobile Combustion record
ClassMethod MergeMobile() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set data=%request.Content
    
    If data.mobileCombustionId '= "" {
        Set obj = ##class(dc.carboncounter.MobileCombustion).%OpenId(data.mobileCombustionId)
    } Else {
        Set obj = ##class(dc.carboncounter.MobileCombustion).%New()
    }
    
    $$$TOE(tSC,obj.%JSONImport(data))
    $$$TOE(tSC,obj.%Save())

    Set %response.Status = 204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do obj.%JSONExport()

    Quit tSC
}

/// Delete a record with id in Mobile Combustion
ClassMethod DeleteMobile(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set obj = ##class(dc.carboncounter.MobileCombustion).%OpenId(id)
    If '$IsObject(obj) Return ..Http404()

    $$$TOE(tSC,obj.%DeleteId(id))

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

/// Retrieve all the records of Transportation
ClassMethod GetAllTransportation() As %Status
{

    #dim tSC As %Status = $$$OK

    Set tSC = ..GetSQLResults("SELECT ID FROM dc_carboncounter.Transportation", .rset)
  
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.Transportation).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    While rset.%Next() {   
        Write ","
        Set obj = ##class(dc.carboncounter.Transportation).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    Write "]"
    Quit tSC
}

/// Return one record of Transportation
ClassMethod GetTransportation(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.Transportation).%OpenId(id)

    If '$IsObject(obj) Quit ..Http404()

    Do obj.%JSONExport()

    Quit tSC
}

/// Return the carbon calculation of Transportation
ClassMethod GetTransportationCalculation(id As %Integer, amount As %Double) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(id)

    Set result = ##class(dc.carboncounter.Transportation).%New()
    Set result.fuel = obj
    Set result.co2 = obj.co2Factor * (amount/1000)
    Set result.ch4 = obj.ch4Factor * (amount/1000)
    Set result.n2o = obj.n2oFactor * (amount/1000)

    If '$IsObject(obj) Quit ..Http404()

    Do result.%JSONExport()

    Quit tSC
}

/// Creates or update a Transportation record
ClassMethod MergeTransportation() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set data=%request.Content
    
    If data.mobileCombustionId '= "" {
        Set obj = ##class(dc.carboncounter.Transportation).%OpenId(data.transportationId)
    } Else {
        Set obj = ##class(dc.carboncounter.Transportation).%New()
    }
    
    $$$TOE(tSC,obj.%JSONImport(data))
    $$$TOE(tSC,obj.%Save())

    Set %response.Status = 204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do obj.%JSONExport()

    Quit tSC
}

/// Delete a record with id in Transportation
ClassMethod DeleteTransportation(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set obj = ##class(dc.carboncounter.Transportation).%OpenId(id)
    If '$IsObject(obj) Return ..Http404()

    $$$TOE(tSC,obj.%DeleteId(id))

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

/// Retrieve all the records of Electricity
ClassMethod GetAllElectricity() As %Status
{

    #dim tSC As %Status = $$$OK

    Set tSC = ..GetSQLResults("SELECT ID FROM dc_carboncounter.Electricity", .rset)
  
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Write "["
    if rset.%Next() {
        Set obj = ##class(dc.carboncounter.Electricity).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    While rset.%Next() {   
        Write ","
        Set obj = ##class(dc.carboncounter.Electricity).%OpenId(rset.ID)    
        Do obj.%JSONExport()
    }
    Write "]"
    Quit tSC
}

/// Return one record of Electricity
ClassMethod GetElectricity(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.Electricity).%OpenId(id)

    If '$IsObject(obj) Quit ..Http404()

    Do obj.%JSONExport()

    Quit tSC
}

/// Return the carbon calculation of Electricity
ClassMethod GetElectricityCalculation(id As %Integer, amount As %Double) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Set obj = ##class(dc.carboncounter.EmissionFactor).%OpenId(id)

    Set result = ##class(dc.carboncounter.Electricity).%New()
    Set result.fuel = obj
    Set result.co2 = obj.co2Factor * (amount/1000)
    Set result.ch4 = obj.ch4Factor * (amount/1000)
    Set result.n2o = obj.n2oFactor * (amount/1000)

    If '$IsObject(obj) Quit ..Http404()

    Do result.%JSONExport()

    Quit tSC
}

/// Creates or update a Electricity record
ClassMethod MergeElectricity() As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set data=%request.Content
    
    If data.mobileCombustionId '= "" {
        Set obj = ##class(dc.carboncounter.Electricity).%OpenId(data.electricityId)
    } Else {
        Set obj = ##class(dc.carboncounter.Electricity).%New()
    }
    
    $$$TOE(tSC,obj.%JSONImport(data))
    $$$TOE(tSC,obj.%Save())

    Set %response.Status = 204
    Set %response.ContentType = ..#CONTENTTYPEJSON
    Do obj.%JSONExport()

    Quit tSC
}

/// Delete a record with id in Electricity
ClassMethod DeleteElectricity(id As %Integer) As %Status
{
	#dim tSC As %Status = $$$OK
    #dim e As %Exception.AbstractException
    Set obj = ##class(dc.carboncounter.Electricity).%OpenId(id)
    If '$IsObject(obj) Return ..Http404()

    $$$TOE(tSC,obj.%DeleteId(id))

    Set %response.Status = 200

    Set %response.ContentType = ..#CONTENTTYPEJSON

    Quit tSC
}

/// Retrieve emission totals
ClassMethod GetTotals() As %Status
{

    #dim tSC As %Status = $$$OK

    Set tSC = ..GetSQLResults("SELECT sum(ch4) ch4, sum(co2) co2, sum(n2o) n2o "_
                                "FROM dc_carboncounter.StationaryCombustion", .rsetStationary)
    
    Set tSC = ..GetSQLResults("SELECT sum(ch4) ch4, sum(co2) co2, sum(n2o) n2o "_
                                "FROM dc_carboncounter.MobileCombustion", .rsetMobile)
  
    Set tSC = ..GetSQLResults("SELECT sum(ch4) ch4, sum(co2) co2, sum(n2o) n2o "_
                                "FROM dc_carboncounter.Transportation", .rsetTransportation)
    
    Set tSC = ..GetSQLResults("SELECT sum(ch4) ch4, sum(co2) co2, sum(n2o) n2o "_
                                "FROM dc_carboncounter.Electricity", .rsetElectricity)
    
    Set co2 = 0
    Set ch4 = 0
    Set n2o = 0

    If rsetStationary.%Next() {
        Set co2 = co2 + rsetStationary.co2
        Set ch4 = ch4 + rsetStationary.ch4
        Set n2o = n2o + rsetStationary.n2o
    }

    If rsetMobile.%Next() {
        Set co2 = co2 + rsetMobile.co2
        Set ch4 = ch4 + rsetMobile.ch4
        Set n2o = n2o + rsetMobile.n2o
    }

    If rsetTransportation.%Next() {
        Set co2 = co2 + rsetTransportation.co2
        Set ch4 = ch4 + rsetTransportation.ch4
        Set n2o = n2o + rsetTransportation.n2o
    }

    If rsetElectricity.%Next() {
        Set co2 = co2 + rsetElectricity.co2
        Set ch4 = ch4 + rsetElectricity.ch4
        Set n2o = n2o + rsetElectricity.n2o
    }

    Set result = {}
    Set result.co2 = co2
    Set result.ch4 = ch4
    Set result.n2o = n2o
    
    Set %response.ContentType = ..#CONTENTTYPEJSON 
    
    Write result.%ToJSON()

    Quit tSC
}

ClassMethod SwaggerSpec() As %Status
{
  Set tSC = ##class(%REST.API).GetWebRESTApplication($NAMESPACE, %request.Application, .swagger)
  Do swagger.info.%Remove("x-ISC_Namespace")
  Set swagger.basePath = "/rest/carbon-counter"
  Set swagger.info.title = "Carbon Footprint Counter"
  Set swagger.info.version = "1.0.0"
  Set swagger.host = "localhost:52775"
  Return ..%ProcessResult($$$OK, swagger)
}

}
