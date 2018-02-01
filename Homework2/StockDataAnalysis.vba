Attribute VB_Name = "Module1"
Sub StockDataAnalysis():
'Initialize variables
Dim Ticker As String
Dim LastRow As Long
Dim TotalStockVolume As Variant
Dim TableRow As Long
Dim YearlyChange As Double
Dim PercentChange As Double
Dim OpeningValue As Double
Dim ws As Worksheet







TableRow = 2
For Each ws In ActiveWorkbook.Worksheets

    LastRow = ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    
    Range("J1").Value = "Ticker"
    Range("K1").Value = "Total Stock Volume"
    Range("L1").Value = "Yearly Change"
    Range("M1").Value = "Percent Change"
'Loop through each row

For i = 2 To LastRow
    'initialize yearly change
    OpeningValue = Cells(TableRow, 3).Value
    
    If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
    'define Ticker
    Ticker = Cells(i, 1).Value
    'define Total Stock Volume
    TotalStockVolume = TotalStockVolume + Cells(i, 7).Value
    'define Yearly Change
    YearlyChange = Cells(i, 6).Value - OpeningValue
    'define Percent Change
    PercentChange = (YearlyChange / (OpeningValue)) * 100
    
    'Print Ticker'
    Range("J" & TableRow).Value = Ticker
    'Print the total stock volume
    Range("K" & TableRow).Value = TotalStockVolume
    'Print Yearly Change
    Range("L" & TableRow).Value = YearlyChange
    'Print Percent Change
    Range("M" & TableRow).Value = PercentChange

    'To find the Greatest Percent Increase and Greatest Percent Decrease
    If (YearlyChange < 0 And PercentChange < 0) Then
    Range("L" & TableRow).Interior.ColorIndex = 3
    Range("M" & TableRow).Interior.ColorIndex = 3

    ElseIf (YearlyChange > 0 And PercentChange > 0) Then
    Range("L" & TableRow).Interior.ColorIndex = 4
    Range("M" & TableRow).Interior.ColorIndex = 4
    End If

    'To find the Greatest Total Stock Volume

    If Cells(i + 1, 13).Value > Cells(i, 13).Value Then
    Range("O2").Value = "Greatest % Increase"
    Range("P1").Value = "Ticker"
    Range("Q1").Value = "Value"
    Range("Q2").Value = Cells(i + 1, 13).Value
    Range("P2").Value = Cells(i + 1, 1).Value

    ElseIf Cells(i + 1, 13).Value < Cells(i, 13).Value Then
    
    Range("O3").Value = "Greatest % Decrease"
    Range("P3").Value = Cells(i + 1, 1).Value
    Range("Q3").Value = Cells(i + 1, 13).Value

    End If
    If Cells(i + 1, 11).Value > Cells(i, 11).Value Then
    Range("O4").Value = "Greatest Total Stock Volume"
    Range("P4").Value = Cells(i + 1, 1).Value
    Range("Q4").Value = Cells(i + 1, 11).Value

    End If

   

    'Add one to the table row to add new data into the next row
    TableRow = TableRow + 1
    
    'Reset the total stock volume, opening value, yearly change and percent change
    
    TotalStockVolume = 0
    OpeningValue = Cells(TableRow, 3)
    YearlyChange = 0
    PercentChange = 0
    
    'If the cell following the row analyzed is the same ticker
    Else
    'Add to the total stock volume
    TotalStockVolume = TotalStockVolume + Cells(i, 7).Value
    
    
    End If
    
Next i


Next ws

    
End Sub
