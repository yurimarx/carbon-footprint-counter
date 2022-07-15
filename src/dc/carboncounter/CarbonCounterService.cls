Class dc.carboncounter.CarbonCounterService
{

/// Retrieve all the records of a class
ClassMethod GetAll(className As %String, Output rset As %SQL.StatementResult) As %Status
{

    #dim tSC As %Status = $$$OK

    Try {
        Set tSC = ..GetSQLResults("SELECT ID FROM dc_carboncounter."_className, .rset)
    } Catch err {
        Set tSC = 0
        Write !, "Error name: ", ?20, err.Name,
              !, "Error code: ", ?20, err.Code,
              !, "Error location: ", ?20, err.Location,
              !, "Additional data: ", ?20, err.Data, !
    }
  
    Quit tSC
}

/// Return one record of a class
ClassMethod GetOne(className As %Persistent, Output obj As %Persistent, id As %Integer) As %Status
{
	Set tSC = 1

    Try {
        Set obj = className.%OpenId(id)
    } Catch err {
        Set tSC = 0
        Write !, "Error name: ", ?20, err.Name,
              !, "Error code: ", ?20, err.Code,
              !, "Error location: ", ?20, err.Location,
              !, "Additional data: ", ?20, err.Data, !
    }
    Quit tSC
}

/// Save one record of a class
ClassMethod Save(obj As %Persistent) As %Status
{
	Set tSC = 1

    $$$TOE(tSC,obj.%Save())

    Quit tSC
}

/// Get Results from SQL 
ClassMethod GetSQLResults(Sql As %String, Output rset As %SQL.StatementResult, filter As %Integer = 0) As %Status
{
    #Dim tSC As %Status

    Set qry = Sql
    Set tStatement = ##class(%SQL.Statement).%New()
    Set tSC = tStatement.%Prepare(qry)
    If tSC'=1 {WRITE "%Prepare failed:" DO $System.Status.DisplayError(tSC) QUIT}
    If filter = 0 {
      Set rset = tStatement.%Execute()
    } Else {
      Set rset = tStatement.%Execute(filter)
    }
    Return tSC
}

}
