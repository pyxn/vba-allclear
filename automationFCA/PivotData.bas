Option Explicit

Sub ChangeAllPivotSources()

  Dim wb As Workbook
  Dim ws As Worksheet
  Dim pt As PivotTable

  Dim sourceTableName As String


  sourceTableName = InputBox(Prompt:="Enter Table Name", Title:="Source Data")

        If sourceTableName = "" Then
          MsgBox "Cancelled."
          Exit Sub

        Else
          For Each ws In wb.Worksheets
            For Each pt In ws.PivotTables

              If pt.PivotCache.OLAP = False Then
                pt.ChangePivotCache _
                  wb.PivotCaches.Create(SourceType:=xlDatabase, _
                                        SourceData:=sourceTableName)
              End If
            Next pt
          Next ws

        End If

        MsgBox "Pivot datasource switch success."

End Sub


Sub UnifyAllPivotCaches()

  Dim pt As PivotTable
  Dim wks As Worksheet
  Dim answer As Integer

  answer = MsgBox("Unify all Pivot Caches?", vbYesNo + vbQuestion)

      If answer = vbYes Then

        For Each wks In ActiveWorkbook.Worksheets
          For Each pt In wks.PivotTables
            pt.CacheIndex = Sheets("DEVELOPMENT").PivotTables("MasterTable").CacheIndex
          Next pt
        Next wks

        MsgBox "Pivot cache unification success. "& _
                "There are " _
                & ActiveWorkbook.PivotCaches.Count _
                & " pivot caches in the active workook."

      Else
      ' Do nothing.

      End If

End Sub