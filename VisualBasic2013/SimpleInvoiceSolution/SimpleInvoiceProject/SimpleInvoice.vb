Public Class SimpleInvoice

    'Declaring Class Variables.
    Private Const decTaxRate As Decimal = 0.055

    Private Sub btnTotal_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTotal.Click

        'Declaring variables for the item prices.
        Dim decMilk As Decimal
        Dim decCoke As Decimal
        Dim decBabyCarrots As Decimal
        Dim decCranGrapeJuice As Decimal
        Dim decCoolRanDoritos As Decimal
        Dim decCknBrst As Decimal
        Dim decWhiteBread As Decimal

        'Declaring variables for the subtotal, tax, and total.
        Dim decSubtotal, decTax, decTotal As Decimal

        'Assigning the prices to the variables
        decMilk = CDec(lblMilkPrice.Text)
        decCoke = CDec(lblCokePrice.Text)
        decBabyCarrots = CDec(lblCarrotPrice.Text)
        decCranGrapeJuice = CDec(lblJuicePrice.Text)
        decCoolRanDoritos = CDec(lblDoritoPrice.Text)
        decCknBrst = CDec(lblChickenPrice.Text)
        decWhiteBread = CDec(lblBreadPrice.Text)

        'Calculating the subtotal, tax, and total.
        decSubtotal = decMilk + decCoke + decBabyCarrots + decCranGrapeJuice + decCoolRanDoritos + decCknBrst + decWhiteBread
        decTax = decSubtotal * decTaxRate
        decTotal = decSubtotal + decTax

        'Displaying the subtotal, tax, and total on the form.
        lblDisplaySubtotal.Text = CStr(Format(decSubtotal, "currency"))
        lblDisplayTax.Text = CStr(Format(decTax, "currency"))
        lblDisplayTotal.Text = CStr(Format(decTotal, "currency"))

    End Sub
End Class
