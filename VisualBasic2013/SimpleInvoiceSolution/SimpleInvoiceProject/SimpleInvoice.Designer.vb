<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class SimpleInvoice
    Inherits System.Windows.Forms.Form

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.grpItems = New System.Windows.Forms.GroupBox()
        Me.lblBreadPrice = New System.Windows.Forms.Label()
        Me.lblChickenPrice = New System.Windows.Forms.Label()
        Me.lblMilkPrice = New System.Windows.Forms.Label()
        Me.lblDoritoPrice = New System.Windows.Forms.Label()
        Me.lblBread = New System.Windows.Forms.Label()
        Me.lblChicken = New System.Windows.Forms.Label()
        Me.lblJuicePrice = New System.Windows.Forms.Label()
        Me.lblMilk = New System.Windows.Forms.Label()
        Me.lblCarrotPrice = New System.Windows.Forms.Label()
        Me.lblDoritos = New System.Windows.Forms.Label()
        Me.lblCokePrice = New System.Windows.Forms.Label()
        Me.lblCoke = New System.Windows.Forms.Label()
        Me.lblJuice = New System.Windows.Forms.Label()
        Me.lblCarrots = New System.Windows.Forms.Label()
        Me.grpTotals = New System.Windows.Forms.GroupBox()
        Me.btnTotal = New System.Windows.Forms.Button()
        Me.lblDisplayTotal = New System.Windows.Forms.Label()
        Me.lblDisplayTax = New System.Windows.Forms.Label()
        Me.lblDisplaySubtotal = New System.Windows.Forms.Label()
        Me.lblTotal = New System.Windows.Forms.Label()
        Me.lblTax = New System.Windows.Forms.Label()
        Me.lblSubtotal = New System.Windows.Forms.Label()
        Me.grpItems.SuspendLayout()
        Me.grpTotals.SuspendLayout()
        Me.SuspendLayout()
        '
        'grpItems
        '
        Me.grpItems.Controls.Add(Me.lblBreadPrice)
        Me.grpItems.Controls.Add(Me.lblChickenPrice)
        Me.grpItems.Controls.Add(Me.lblMilkPrice)
        Me.grpItems.Controls.Add(Me.lblDoritoPrice)
        Me.grpItems.Controls.Add(Me.lblBread)
        Me.grpItems.Controls.Add(Me.lblChicken)
        Me.grpItems.Controls.Add(Me.lblJuicePrice)
        Me.grpItems.Controls.Add(Me.lblMilk)
        Me.grpItems.Controls.Add(Me.lblCarrotPrice)
        Me.grpItems.Controls.Add(Me.lblDoritos)
        Me.grpItems.Controls.Add(Me.lblCokePrice)
        Me.grpItems.Controls.Add(Me.lblCoke)
        Me.grpItems.Controls.Add(Me.lblJuice)
        Me.grpItems.Controls.Add(Me.lblCarrots)
        Me.grpItems.Location = New System.Drawing.Point(12, 12)
        Me.grpItems.Name = "grpItems"
        Me.grpItems.Size = New System.Drawing.Size(233, 219)
        Me.grpItems.TabIndex = 0
        Me.grpItems.TabStop = False
        Me.grpItems.Text = "Items"
        '
        'lblBreadPrice
        '
        Me.lblBreadPrice.Location = New System.Drawing.Point(178, 183)
        Me.lblBreadPrice.Name = "lblBreadPrice"
        Me.lblBreadPrice.Size = New System.Drawing.Size(44, 23)
        Me.lblBreadPrice.TabIndex = 8
        Me.lblBreadPrice.Text = "2.19"
        Me.lblBreadPrice.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblChickenPrice
        '
        Me.lblChickenPrice.Location = New System.Drawing.Point(178, 156)
        Me.lblChickenPrice.Name = "lblChickenPrice"
        Me.lblChickenPrice.Size = New System.Drawing.Size(44, 23)
        Me.lblChickenPrice.TabIndex = 6
        Me.lblChickenPrice.Text = "4.56"
        Me.lblChickenPrice.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblMilkPrice
        '
        Me.lblMilkPrice.Location = New System.Drawing.Point(178, 16)
        Me.lblMilkPrice.Name = "lblMilkPrice"
        Me.lblMilkPrice.Size = New System.Drawing.Size(44, 23)
        Me.lblMilkPrice.TabIndex = 2
        Me.lblMilkPrice.Text = "2.13"
        Me.lblMilkPrice.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblDoritoPrice
        '
        Me.lblDoritoPrice.Location = New System.Drawing.Point(178, 138)
        Me.lblDoritoPrice.Name = "lblDoritoPrice"
        Me.lblDoritoPrice.Size = New System.Drawing.Size(44, 23)
        Me.lblDoritoPrice.TabIndex = 7
        Me.lblDoritoPrice.Text = "3.47"
        Me.lblDoritoPrice.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblBread
        '
        Me.lblBread.Location = New System.Drawing.Point(6, 183)
        Me.lblBread.Name = "lblBread"
        Me.lblBread.Size = New System.Drawing.Size(100, 32)
        Me.lblBread.TabIndex = 7
        Me.lblBread.Text = "White Bread" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "-Fest Brand"
        Me.lblBread.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblChicken
        '
        Me.lblChicken.Location = New System.Drawing.Point(6, 156)
        Me.lblChicken.Name = "lblChicken"
        Me.lblChicken.Size = New System.Drawing.Size(129, 27)
        Me.lblChicken.TabIndex = 6
        Me.lblChicken.Text = "Chicken Brst" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "-4 pk Amish Farms Brand"
        Me.lblChicken.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblJuicePrice
        '
        Me.lblJuicePrice.Location = New System.Drawing.Point(178, 108)
        Me.lblJuicePrice.Name = "lblJuicePrice"
        Me.lblJuicePrice.Size = New System.Drawing.Size(44, 23)
        Me.lblJuicePrice.TabIndex = 5
        Me.lblJuicePrice.Text = "3.99"
        Me.lblJuicePrice.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblMilk
        '
        Me.lblMilk.Location = New System.Drawing.Point(6, 16)
        Me.lblMilk.Name = "lblMilk"
        Me.lblMilk.Size = New System.Drawing.Size(100, 31)
        Me.lblMilk.TabIndex = 0
        Me.lblMilk.Text = "Skim Milk" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "-1gal Fest Brand"
        Me.lblMilk.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblCarrotPrice
        '
        Me.lblCarrotPrice.Location = New System.Drawing.Point(178, 76)
        Me.lblCarrotPrice.Name = "lblCarrotPrice"
        Me.lblCarrotPrice.Size = New System.Drawing.Size(44, 23)
        Me.lblCarrotPrice.TabIndex = 4
        Me.lblCarrotPrice.Text = "2.98"
        Me.lblCarrotPrice.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblDoritos
        '
        Me.lblDoritos.Location = New System.Drawing.Point(6, 138)
        Me.lblDoritos.Name = "lblDoritos"
        Me.lblDoritos.Size = New System.Drawing.Size(100, 18)
        Me.lblDoritos.TabIndex = 5
        Me.lblDoritos.Text = "Cool Ranch Doritos"
        Me.lblDoritos.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblCokePrice
        '
        Me.lblCokePrice.Location = New System.Drawing.Point(178, 47)
        Me.lblCokePrice.Name = "lblCokePrice"
        Me.lblCokePrice.Size = New System.Drawing.Size(44, 23)
        Me.lblCokePrice.TabIndex = 3
        Me.lblCokePrice.Text = "3.99"
        Me.lblCokePrice.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblCoke
        '
        Me.lblCoke.Location = New System.Drawing.Point(6, 47)
        Me.lblCoke.Name = "lblCoke"
        Me.lblCoke.Size = New System.Drawing.Size(100, 29)
        Me.lblCoke.TabIndex = 2
        Me.lblCoke.Text = "Coca-Cola" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "-12pk"
        Me.lblCoke.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblJuice
        '
        Me.lblJuice.Location = New System.Drawing.Point(6, 108)
        Me.lblJuice.Name = "lblJuice"
        Me.lblJuice.Size = New System.Drawing.Size(107, 30)
        Me.lblJuice.TabIndex = 4
        Me.lblJuice.Text = "Cran-Grape Juice" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "-Ocean Spray Brand"
        Me.lblJuice.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblCarrots
        '
        Me.lblCarrots.Location = New System.Drawing.Point(6, 76)
        Me.lblCarrots.Name = "lblCarrots"
        Me.lblCarrots.Size = New System.Drawing.Size(100, 32)
        Me.lblCarrots.TabIndex = 3
        Me.lblCarrots.Text = "Baby Carrots" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "-Green Giant Brand"
        Me.lblCarrots.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'grpTotals
        '
        Me.grpTotals.Controls.Add(Me.btnTotal)
        Me.grpTotals.Controls.Add(Me.lblDisplayTotal)
        Me.grpTotals.Controls.Add(Me.lblDisplayTax)
        Me.grpTotals.Controls.Add(Me.lblDisplaySubtotal)
        Me.grpTotals.Controls.Add(Me.lblTotal)
        Me.grpTotals.Controls.Add(Me.lblTax)
        Me.grpTotals.Controls.Add(Me.lblSubtotal)
        Me.grpTotals.Location = New System.Drawing.Point(12, 237)
        Me.grpTotals.Name = "grpTotals"
        Me.grpTotals.Size = New System.Drawing.Size(233, 77)
        Me.grpTotals.TabIndex = 1
        Me.grpTotals.TabStop = False
        Me.grpTotals.Text = "Totals"
        '
        'btnTotal
        '
        Me.btnTotal.Location = New System.Drawing.Point(147, 53)
        Me.btnTotal.Name = "btnTotal"
        Me.btnTotal.Size = New System.Drawing.Size(75, 23)
        Me.btnTotal.TabIndex = 6
        Me.btnTotal.Text = "Total"
        Me.btnTotal.UseVisualStyleBackColor = True
        '
        'lblDisplayTotal
        '
        Me.lblDisplayTotal.AutoSize = True
        Me.lblDisplayTotal.Location = New System.Drawing.Point(96, 58)
        Me.lblDisplayTotal.Name = "lblDisplayTotal"
        Me.lblDisplayTotal.Size = New System.Drawing.Size(0, 13)
        Me.lblDisplayTotal.TabIndex = 5
        Me.lblDisplayTotal.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblDisplayTax
        '
        Me.lblDisplayTax.AutoSize = True
        Me.lblDisplayTax.Location = New System.Drawing.Point(96, 45)
        Me.lblDisplayTax.Name = "lblDisplayTax"
        Me.lblDisplayTax.Size = New System.Drawing.Size(0, 13)
        Me.lblDisplayTax.TabIndex = 4
        Me.lblDisplayTax.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblDisplaySubtotal
        '
        Me.lblDisplaySubtotal.AutoSize = True
        Me.lblDisplaySubtotal.Location = New System.Drawing.Point(96, 32)
        Me.lblDisplaySubtotal.Name = "lblDisplaySubtotal"
        Me.lblDisplaySubtotal.Size = New System.Drawing.Size(0, 13)
        Me.lblDisplaySubtotal.TabIndex = 3
        Me.lblDisplaySubtotal.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblTotal
        '
        Me.lblTotal.AutoSize = True
        Me.lblTotal.Location = New System.Drawing.Point(22, 58)
        Me.lblTotal.Name = "lblTotal"
        Me.lblTotal.Size = New System.Drawing.Size(34, 13)
        Me.lblTotal.TabIndex = 2
        Me.lblTotal.Text = "Total:"
        Me.lblTotal.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblTax
        '
        Me.lblTax.AutoSize = True
        Me.lblTax.Location = New System.Drawing.Point(28, 45)
        Me.lblTax.Name = "lblTax"
        Me.lblTax.Size = New System.Drawing.Size(28, 13)
        Me.lblTax.TabIndex = 1
        Me.lblTax.Text = "Tax:"
        Me.lblTax.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblSubtotal
        '
        Me.lblSubtotal.AutoSize = True
        Me.lblSubtotal.Location = New System.Drawing.Point(7, 32)
        Me.lblSubtotal.Name = "lblSubtotal"
        Me.lblSubtotal.Size = New System.Drawing.Size(49, 13)
        Me.lblSubtotal.TabIndex = 0
        Me.lblSubtotal.Text = "Subtotal:"
        Me.lblSubtotal.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'SimpleInvoice
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(257, 326)
        Me.Controls.Add(Me.grpTotals)
        Me.Controls.Add(Me.grpItems)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.Name = "SimpleInvoice"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Festival Foods Simple Invoice"
        Me.grpItems.ResumeLayout(False)
        Me.grpTotals.ResumeLayout(False)
        Me.grpTotals.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents grpItems As System.Windows.Forms.GroupBox
    Friend WithEvents lblBreadPrice As System.Windows.Forms.Label
    Friend WithEvents lblChickenPrice As System.Windows.Forms.Label
    Friend WithEvents lblMilkPrice As System.Windows.Forms.Label
    Friend WithEvents lblDoritoPrice As System.Windows.Forms.Label
    Friend WithEvents lblBread As System.Windows.Forms.Label
    Friend WithEvents lblChicken As System.Windows.Forms.Label
    Friend WithEvents lblJuicePrice As System.Windows.Forms.Label
    Friend WithEvents lblMilk As System.Windows.Forms.Label
    Friend WithEvents lblCarrotPrice As System.Windows.Forms.Label
    Friend WithEvents lblDoritos As System.Windows.Forms.Label
    Friend WithEvents lblCokePrice As System.Windows.Forms.Label
    Friend WithEvents lblCoke As System.Windows.Forms.Label
    Friend WithEvents lblJuice As System.Windows.Forms.Label
    Friend WithEvents lblCarrots As System.Windows.Forms.Label
    Friend WithEvents grpTotals As System.Windows.Forms.GroupBox
    Friend WithEvents btnTotal As System.Windows.Forms.Button
    Friend WithEvents lblDisplayTotal As System.Windows.Forms.Label
    Friend WithEvents lblDisplayTax As System.Windows.Forms.Label
    Friend WithEvents lblDisplaySubtotal As System.Windows.Forms.Label
    Friend WithEvents lblTotal As System.Windows.Forms.Label
    Friend WithEvents lblTax As System.Windows.Forms.Label
    Friend WithEvents lblSubtotal As System.Windows.Forms.Label

End Class
