Class UnitTests.CarbonCounterServiceTest Extends %UnitTest.TestCase
{

Method TestGetAll()
{
    Do ##class(dc.carboncounter.CarbonCounterService).GetAll(##class(dc.carboncounter.EmissionUnit).%New(), .rset)
    If rset.%Next()
    Do $$$AssertEquals(rset.emissionUnitId, "")
}

Method TestGetOne() As %Status
{
    Do ##class(dc.carboncounter.CarbonCounterService).GetOne(##class(dc.carboncounter.EmissionUnit).%New(), .obj, 1)
    Do $$$AssertEquals(obj.emissionUnitId, 1)
}

Method TestSave()
{
    set obj = ##class(dc.carboncounter.EmissionUnit).%New()
    set obj.name = "test"
    set obj.description = "test"
    set tSC = ##class(dc.carboncounter.CarbonCounterService).Save(obj)
    Do $$$AssertEquals(tSC, 1)
    set id = obj.emissionUnitId
    Do obj.%DeleteId(id)
}

}
