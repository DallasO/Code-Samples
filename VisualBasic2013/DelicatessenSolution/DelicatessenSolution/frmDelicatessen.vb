Public Class frmDelicatessen

    '***Declaring the Constants for the Module.***
    Private Const decPlainBagel As Decimal = 1.55
    Private Const decLox As Decimal = 2.15
    Private Const decCreamCheese As Decimal = 1.55

    Private Const decSpinachSalad As Decimal = 4.6
    Private Const decChefSalad As Decimal = 5.75

    Private Const decCola As Decimal = 1.25
    Private Const decCreamSoda As Decimal = 1.5
    '******************************************************

    '***Declaring the variable to store the item amounts and total***
    Private decBagelTotal As Decimal
    Private decSaladTotal As Decimal
    Private decSodaTotal As Decimal
    Private decTotal As Decimal
    '******************************************************


    Private Sub frmDelicatessen_Activated(sender As Object, e As System.EventArgs) Handles Me.Activated
        rdbCola.Checked = False

    End Sub

    Private Sub frmDelicatessen_Load(sender As System.Object, e As System.EventArgs) Handles MyBase.Load
        '***Setting the default of having the submenu group boxed disabled***
        grpBagelFilling.Enabled = False
        grpSaladChoice.Enabled = False
        grpSoda.Enabled = False
        '******************************************************

        '***Establishing beginning values for each variable***
        decBagelTotal = 0
        decSaladTotal = 0
        decSodaTotal = 0
        decTotal = 0
        '******************************************************

        '***Setting the subtotal text boxes text value to default "$0.00"***
        txtBagelPrice.Text = Format(decBagelTotal, "currency")
        txtSaladPrice.Text = Format(decSaladTotal, "currency")
        txtSodaPrice.Text = Format(decSodaTotal, "currency")
        txtTotal.Text = Format(decTotal, "currency")

        '******************************************************

    End Sub

    Private Sub chkBagel_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles chkBagel.CheckedChanged
        'When checked, grpBagelFilling becomes enabled to allow choices
        'When unchecked, grpBagelFilling becomes disabled and everything inside is cleared.
        If chkBagel.Checked = True Then
            grpBagelFilling.Enabled = True

            decBagelTotal += decPlainBagel
        Else
            grpBagelFilling.Enabled = False
            chkLox.Checked = False
            chkCreamCheese.Checked = False

            decBagelTotal = 0.0
        End If

        'Reflecting the change in price.
        txtBagelPrice.Text = Format(decBagelTotal, "currency")
    End Sub

    Private Sub chkLox_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles chkLox.CheckedChanged
        'Will add or decrease the price of Lox to the bagel total.
        If chkLox.Checked = True Then
            decBagelTotal += decLox
        Else
            decBagelTotal -= decLox
        End If

        'Reflecting the change in price.
        txtBagelPrice.Text = Format(decBagelTotal, "currency")
    End Sub

    Private Sub chkCreamCheese_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles chkCreamCheese.CheckedChanged
        'Will add or decrease the price of Cream Cheese to the bagel total.
        If chkCreamCheese.Checked = True Then
            decBagelTotal += decCreamCheese
        Else
            decBagelTotal -= decCreamCheese
        End If

        'Reflecting the change in price.
        txtBagelPrice.Text = Format(decBagelTotal, "currency")

    End Sub

    Private Sub chkSalad_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles chkSalad.CheckedChanged
        'When checked, grpSaladChoice becomes enabled to allow choices
        'When unchecked, grpSaladChoice becomes disabled and everything inside is cleared.
        If chkSalad.Checked = True Then
            grpSaladChoice.Enabled = True
        Else
            grpSaladChoice.Enabled = False

            rdbSpinach.Checked = False
            rdbChef.Checked = False
        End If
    End Sub

    Private Sub rdbSpinach_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles rdbSpinach.CheckedChanged
        'Will add or decrease the price of a Spinach Salad to the salad total.
        If rdbSpinach.Checked = True Then
            decSaladTotal += decSpinachSalad
        Else
            decSaladTotal -= decSpinachSalad
        End If

        'Reflecting the change in price.
        txtSaladPrice.Text = Format(decSaladTotal, "currency")
    End Sub

    Private Sub rdbChef_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles rdbChef.CheckedChanged
        'Will add or decrease the price of a Chef Salad to the salad total.
        If rdbChef.Checked = True Then
            decSaladTotal += decChefSalad
        Else
            decSaladTotal -= decChefSalad
        End If

        'Reflecting the change in price.
        txtSaladPrice.Text = Format(decSaladTotal, "currency")

    End Sub

    Private Sub chkSoda_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles chkSoda.CheckedChanged
        'When checked, grpSoda becomes enabled to allow choices
        'When unchecked, grpSoda becomes disabled and everything inside is cleared.
        If chkSoda.Checked = True Then
            grpSoda.Enabled = True
        Else
            grpSoda.Enabled = False

            rdbCola.Checked = False
            rdbCreamSoda.Checked = False
        End If
    End Sub

    Private Sub rdbCola_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles rdbCola.CheckedChanged
        'Will add or decrease the price of a cola to the soda total.
        If rdbCola.Checked = True Then
            decSodaTotal += decCola
        Else
            decSodaTotal -= decCola
        End If

        'Reflecting the change in price.
        txtSodaPrice.Text = Format(decSodaTotal, "currency")

    End Sub

    Private Sub rdbCreamSoda_CheckedChanged(sender As System.Object, e As System.EventArgs) Handles rdbCreamSoda.CheckedChanged
        'Will add or decrease the price of a cream soda to the soda total.
        If rdbCreamSoda.Checked = True Then
            decSodaTotal += decCreamSoda
        Else
            decSodaTotal -= decCreamSoda
        End If

        'Reflecting the change in price.
        txtSodaPrice.Text = Format(decSodaTotal, "currency")
    End Sub

    Private Sub txtBagelPrice_TextChanged(sender As System.Object, e As System.EventArgs) Handles txtBagelPrice.TextChanged
        'Reflecting the change in the total.
        txtTotal.Text = Format(decBagelTotal + decSaladTotal + decSodaTotal, "currency")
    End Sub

    Private Sub txtSaladPrice_TextChanged(sender As System.Object, e As System.EventArgs) Handles txtSaladPrice.TextChanged
        'Reflecting the change in the total.
        txtTotal.Text = Format(decBagelTotal + decSaladTotal + decSodaTotal, "currency")

    End Sub

    Private Sub txtSodaPrice_TextChanged(sender As System.Object, e As System.EventArgs) Handles txtSodaPrice.TextChanged
        'Reflecting the change in the total.
        txtTotal.Text = Format(decBagelTotal + decSaladTotal + decSodaTotal, "currency")

    End Sub
End Class
