Public Class AutoRepairBillCalculator
    'These variables hold the place for numbers that may change in the future
    Dim LaborPerHour As Double = 35.0
    Dim SalesTax As Double = 0.05

    Dim CustomerName As String
    Dim CostOfLabor As Double
    Dim CostOfParts As Double

    'Performs validation, calculation, and displays results on click
    Private Sub btnCalc_Click(sender As Object, e As EventArgs) Handles btnCalc.Click
        If ValidateFields() Then
            CustomerName = CStr(txtCustomerName.Text)
            CostOfLabor = CDbl(txtLaborHours.Text) * LaborPerHour
            CostOfParts = CDbl(txtCost.Text) * (1 + SalesTax)

            DisplayBill()
        End If
    End Sub

    'This function validates the fields to be entered and
    'displays messages to re-enter bad values
    Private Function ValidateFields() As Boolean
        Dim ValidFields As Boolean = False

        If String.IsNullOrEmpty(txtCustomerName.Text.Trim) Then
            ValidFields = False
            txtCustomerName.Focus()
            txtCustomerName.SelectAll()
            MsgBox("Please enter a name.")

        ElseIf Not IsNumeric(txtLaborHours.Text) Then
            ValidFields = False
            txtLaborHours.Focus()
            txtLaborHours.SelectAll()
            MsgBox("Please enter the hours of labor.")

        ElseIf Not IsNumeric(txtCost.Text) Then
            ValidFields = False
            txtCost.Focus()
            txtCost.SelectAll()
            MsgBox("Please enter the cost of parts.")

        Else
            ValidFields = True
        End If

        Return ValidFields
    End Function

    'This Sub Procedure displays the bill into the ListBox
    Private Sub DisplayBill()
        lstBill.Items.Clear()
        lstBill.Items.Add("Customer:" & vbTab & CustomerName)
        lstBill.Items.Add("Cost of Labor:" & vbTab & "  " & Format(CostOfLabor, "currency"))
        lstBill.Items.Add("Cost of Parts:" & vbTab & "  " & Format(CostOfParts, "currency"))
        lstBill.Items.Add("Total Cost:" & vbTab & "  " & Format((CostOfLabor + CostOfParts), "currency"))
    End Sub
End Class
