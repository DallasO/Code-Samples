Public Class frmWindChillCalculator
    'Creating constants for use with determining the WindChill value.
    Private Const intWindSpeedLowerLimit As Integer = 3
    Private Const intTempUpperLimit As Integer = 50

    'Creating Constants for use with calculating time for frostbite.
    Private Const int30MinFrostbite As Integer = -17
    Private Const int10MinFrostbite As Integer = -35
    Private Const int5MinFrostbite As Integer = -60

    Private Sub btnExit_Click(sender As System.Object, e As System.EventArgs) Handles btnExit.Click
        Close()
    End Sub

    Private Sub btnCalculate_Click(sender As System.Object, e As System.EventArgs) Handles btnCalculate.Click
        'Declaring variables to hold the inputs
        Dim dblTemperature As Double
        Dim dblWindSpeed As Double
        Dim dblWindChill As Double
        Dim intTimeToFrostbite As Integer

        'Making sure that the user entered numbers
        If Not IsNumeric(txtAirTemp.Text) Or Not IsNumeric(txtWindSpeed.Text) Then
            MsgBox("Please Enter Numbers!", MsgBoxStyle.Information, "Problem")

        Else
            'Assingning the values entered in the text boxes to the variables
            dblTemperature = CDbl(txtAirTemp.Text)
            dblWindSpeed = CDbl(txtWindSpeed.Text)

            'Determining the value to give to WindChill
            If dblWindSpeed <= intWindSpeedLowerLimit Or dblTemperature >= intTempUpperLimit Then
                dblWindChill = dblTemperature
            Else
                dblWindChill = 35.74 + 0.6215 * dblTemperature - 35.75 * (dblWindSpeed ^ 0.16) + 0.4275 * dblTemperature * (dblWindSpeed ^ 0.16)
            End If
            dblWindChill = Format(dblWindChill, "0.0")
            lblWindChill.Text = dblWindChill

        End If

        'Calculating the time it takes to get frostbitten.
        If dblWindChill < int5MinFrostbite Then
            grpTimeToFrostbite.Visible = True
            intTimeToFrostbite = 5
            lblTimeToFrostbite.Text = intTimeToFrostbite & " Minutes!!!"

        ElseIf dblWindChill < int10MinFrostbite Then
            grpTimeToFrostbite.Visible = True
            intTimeToFrostbite = 10
            lblTimeToFrostbite.Text = intTimeToFrostbite & " Minutes!!"
        ElseIf dblWindChill < int30MinFrostbite Then
            grpTimeToFrostbite.Visible = True
            intTimeToFrostbite = 30
            lblTimeToFrostbite.Text = intTimeToFrostbite & " Minutes!"
        Else
            grpTimeToFrostbite.Visible = False
        End If

    End Sub
End Class
