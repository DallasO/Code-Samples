<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmDelicatessen
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
        Me.grpMainMenu = New System.Windows.Forms.GroupBox()
        Me.chkBagel = New System.Windows.Forms.CheckBox()
        Me.chkSalad = New System.Windows.Forms.CheckBox()
        Me.chkSoda = New System.Windows.Forms.CheckBox()
        Me.grpSoda = New System.Windows.Forms.GroupBox()
        Me.rdbCreamSoda = New System.Windows.Forms.RadioButton()
        Me.rdbCola = New System.Windows.Forms.RadioButton()
        Me.grpSaladChoice = New System.Windows.Forms.GroupBox()
        Me.rdbChef = New System.Windows.Forms.RadioButton()
        Me.rdbSpinach = New System.Windows.Forms.RadioButton()
        Me.grpBagelFilling = New System.Windows.Forms.GroupBox()
        Me.chkLox = New System.Windows.Forms.CheckBox()
        Me.chkCreamCheese = New System.Windows.Forms.CheckBox()
        Me.lblPrice = New System.Windows.Forms.Label()
        Me.txtBagelPrice = New System.Windows.Forms.TextBox()
        Me.txtSaladPrice = New System.Windows.Forms.TextBox()
        Me.txtSodaPrice = New System.Windows.Forms.TextBox()
        Me.txtTotal = New System.Windows.Forms.TextBox()
        Me.lblTotal = New System.Windows.Forms.Label()
        Me.lblDelicatessenLogo = New System.Windows.Forms.Label()
        Me.grpMainMenu.SuspendLayout()
        Me.grpSoda.SuspendLayout()
        Me.grpSaladChoice.SuspendLayout()
        Me.grpBagelFilling.SuspendLayout()
        Me.SuspendLayout()
        '
        'grpMainMenu
        '
        Me.grpMainMenu.Controls.Add(Me.chkBagel)
        Me.grpMainMenu.Controls.Add(Me.chkSalad)
        Me.grpMainMenu.Controls.Add(Me.chkSoda)
        Me.grpMainMenu.Location = New System.Drawing.Point(12, 12)
        Me.grpMainMenu.Name = "grpMainMenu"
        Me.grpMainMenu.Size = New System.Drawing.Size(321, 60)
        Me.grpMainMenu.TabIndex = 0
        Me.grpMainMenu.TabStop = False
        Me.grpMainMenu.Text = "Main Menu"
        '
        'chkBagel
        '
        Me.chkBagel.AutoSize = True
        Me.chkBagel.Location = New System.Drawing.Point(6, 19)
        Me.chkBagel.Name = "chkBagel"
        Me.chkBagel.Size = New System.Drawing.Size(53, 17)
        Me.chkBagel.TabIndex = 1
        Me.chkBagel.Text = "Bagel"
        Me.chkBagel.UseVisualStyleBackColor = True
        '
        'chkSalad
        '
        Me.chkSalad.AutoSize = True
        Me.chkSalad.Location = New System.Drawing.Point(109, 19)
        Me.chkSalad.Name = "chkSalad"
        Me.chkSalad.Size = New System.Drawing.Size(53, 17)
        Me.chkSalad.TabIndex = 2
        Me.chkSalad.Text = "Salad"
        Me.chkSalad.UseVisualStyleBackColor = True
        '
        'chkSoda
        '
        Me.chkSoda.AutoSize = True
        Me.chkSoda.Location = New System.Drawing.Point(218, 19)
        Me.chkSoda.Name = "chkSoda"
        Me.chkSoda.Size = New System.Drawing.Size(51, 17)
        Me.chkSoda.TabIndex = 3
        Me.chkSoda.Text = "Soda"
        Me.chkSoda.UseVisualStyleBackColor = True
        '
        'grpSoda
        '
        Me.grpSoda.Controls.Add(Me.rdbCreamSoda)
        Me.grpSoda.Controls.Add(Me.rdbCola)
        Me.grpSoda.Location = New System.Drawing.Point(230, 78)
        Me.grpSoda.Name = "grpSoda"
        Me.grpSoda.Size = New System.Drawing.Size(103, 100)
        Me.grpSoda.TabIndex = 0
        Me.grpSoda.TabStop = False
        Me.grpSoda.Text = "Soda"
        '
        'rdbCreamSoda
        '
        Me.rdbCreamSoda.AutoSize = True
        Me.rdbCreamSoda.Location = New System.Drawing.Point(6, 59)
        Me.rdbCreamSoda.Name = "rdbCreamSoda"
        Me.rdbCreamSoda.Size = New System.Drawing.Size(83, 17)
        Me.rdbCreamSoda.TabIndex = 1
        Me.rdbCreamSoda.TabStop = True
        Me.rdbCreamSoda.Text = "Cream Soda"
        Me.rdbCreamSoda.UseVisualStyleBackColor = True
        '
        'rdbCola
        '
        Me.rdbCola.AutoSize = True
        Me.rdbCola.Location = New System.Drawing.Point(6, 28)
        Me.rdbCola.Name = "rdbCola"
        Me.rdbCola.Size = New System.Drawing.Size(46, 17)
        Me.rdbCola.TabIndex = 0
        Me.rdbCola.TabStop = True
        Me.rdbCola.Text = "Cola"
        Me.rdbCola.UseVisualStyleBackColor = True
        '
        'grpSaladChoice
        '
        Me.grpSaladChoice.Controls.Add(Me.rdbChef)
        Me.grpSaladChoice.Controls.Add(Me.rdbSpinach)
        Me.grpSaladChoice.Location = New System.Drawing.Point(121, 78)
        Me.grpSaladChoice.Name = "grpSaladChoice"
        Me.grpSaladChoice.Size = New System.Drawing.Size(103, 100)
        Me.grpSaladChoice.TabIndex = 0
        Me.grpSaladChoice.TabStop = False
        Me.grpSaladChoice.Text = "Salad Choice"
        '
        'rdbChef
        '
        Me.rdbChef.AutoSize = True
        Me.rdbChef.Location = New System.Drawing.Point(7, 60)
        Me.rdbChef.Name = "rdbChef"
        Me.rdbChef.Size = New System.Drawing.Size(47, 17)
        Me.rdbChef.TabIndex = 1
        Me.rdbChef.TabStop = True
        Me.rdbChef.Text = "Chef"
        Me.rdbChef.UseVisualStyleBackColor = True
        '
        'rdbSpinach
        '
        Me.rdbSpinach.AutoSize = True
        Me.rdbSpinach.Location = New System.Drawing.Point(7, 27)
        Me.rdbSpinach.Name = "rdbSpinach"
        Me.rdbSpinach.Size = New System.Drawing.Size(64, 17)
        Me.rdbSpinach.TabIndex = 0
        Me.rdbSpinach.TabStop = True
        Me.rdbSpinach.Text = "Spinach"
        Me.rdbSpinach.UseVisualStyleBackColor = True
        '
        'grpBagelFilling
        '
        Me.grpBagelFilling.Controls.Add(Me.chkLox)
        Me.grpBagelFilling.Controls.Add(Me.chkCreamCheese)
        Me.grpBagelFilling.Location = New System.Drawing.Point(12, 78)
        Me.grpBagelFilling.Name = "grpBagelFilling"
        Me.grpBagelFilling.Size = New System.Drawing.Size(103, 100)
        Me.grpBagelFilling.TabIndex = 0
        Me.grpBagelFilling.TabStop = False
        Me.grpBagelFilling.Text = "Bagel Filling"
        '
        'chkLox
        '
        Me.chkLox.AutoSize = True
        Me.chkLox.Location = New System.Drawing.Point(6, 28)
        Me.chkLox.Name = "chkLox"
        Me.chkLox.Size = New System.Drawing.Size(43, 17)
        Me.chkLox.TabIndex = 1
        Me.chkLox.Text = "Lox"
        Me.chkLox.UseVisualStyleBackColor = True
        '
        'chkCreamCheese
        '
        Me.chkCreamCheese.AutoSize = True
        Me.chkCreamCheese.Location = New System.Drawing.Point(6, 60)
        Me.chkCreamCheese.Name = "chkCreamCheese"
        Me.chkCreamCheese.Size = New System.Drawing.Size(95, 17)
        Me.chkCreamCheese.TabIndex = 2
        Me.chkCreamCheese.Text = "Cream Cheese"
        Me.chkCreamCheese.UseVisualStyleBackColor = True
        '
        'lblPrice
        '
        Me.lblPrice.AutoSize = True
        Me.lblPrice.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.lblPrice.Location = New System.Drawing.Point(9, 190)
        Me.lblPrice.Name = "lblPrice"
        Me.lblPrice.Size = New System.Drawing.Size(34, 13)
        Me.lblPrice.TabIndex = 1
        Me.lblPrice.Text = "Price:"
        '
        'txtBagelPrice
        '
        Me.txtBagelPrice.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.txtBagelPrice.Location = New System.Drawing.Point(49, 187)
        Me.txtBagelPrice.MaxLength = 5
        Me.txtBagelPrice.Name = "txtBagelPrice"
        Me.txtBagelPrice.ReadOnly = True
        Me.txtBagelPrice.Size = New System.Drawing.Size(65, 20)
        Me.txtBagelPrice.TabIndex = 2
        '
        'txtSaladPrice
        '
        Me.txtSaladPrice.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.txtSaladPrice.Location = New System.Drawing.Point(159, 187)
        Me.txtSaladPrice.MaxLength = 5
        Me.txtSaladPrice.Name = "txtSaladPrice"
        Me.txtSaladPrice.ReadOnly = True
        Me.txtSaladPrice.Size = New System.Drawing.Size(65, 20)
        Me.txtSaladPrice.TabIndex = 3
        '
        'txtSodaPrice
        '
        Me.txtSodaPrice.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.txtSodaPrice.Location = New System.Drawing.Point(268, 187)
        Me.txtSodaPrice.MaxLength = 5
        Me.txtSodaPrice.Name = "txtSodaPrice"
        Me.txtSodaPrice.ReadOnly = True
        Me.txtSodaPrice.Size = New System.Drawing.Size(65, 20)
        Me.txtSodaPrice.TabIndex = 4
        '
        'txtTotal
        '
        Me.txtTotal.BackColor = System.Drawing.Color.White
        Me.txtTotal.Location = New System.Drawing.Point(268, 222)
        Me.txtTotal.MaxLength = 6
        Me.txtTotal.Name = "txtTotal"
        Me.txtTotal.ReadOnly = True
        Me.txtTotal.Size = New System.Drawing.Size(65, 20)
        Me.txtTotal.TabIndex = 5
        '
        'lblTotal
        '
        Me.lblTotal.AutoSize = True
        Me.lblTotal.BackColor = System.Drawing.Color.FromArgb(CType(CType(128, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.lblTotal.Location = New System.Drawing.Point(223, 225)
        Me.lblTotal.Name = "lblTotal"
        Me.lblTotal.Size = New System.Drawing.Size(34, 13)
        Me.lblTotal.TabIndex = 6
        Me.lblTotal.Text = "Total:"
        Me.lblTotal.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblDelicatessenLogo
        '
        Me.lblDelicatessenLogo.AutoSize = True
        Me.lblDelicatessenLogo.BackColor = System.Drawing.Color.FromArgb(CType(CType(128, Byte), Integer), CType(CType(255, Byte), Integer), CType(CType(255, Byte), Integer))
        Me.lblDelicatessenLogo.Font = New System.Drawing.Font("Microsoft Sans Serif", 12.0!, CType((System.Drawing.FontStyle.Bold Or System.Drawing.FontStyle.Italic), System.Drawing.FontStyle), System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblDelicatessenLogo.ForeColor = System.Drawing.Color.Red
        Me.lblDelicatessenLogo.Location = New System.Drawing.Point(14, 221)
        Me.lblDelicatessenLogo.Name = "lblDelicatessenLogo"
        Me.lblDelicatessenLogo.Size = New System.Drawing.Size(113, 20)
        Me.lblDelicatessenLogo.TabIndex = 7
        Me.lblDelicatessenLogo.Text = "Delicatessen"
        '
        'frmDelicatessen
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(340, 250)
        Me.Controls.Add(Me.lblDelicatessenLogo)
        Me.Controls.Add(Me.lblTotal)
        Me.Controls.Add(Me.txtTotal)
        Me.Controls.Add(Me.txtSodaPrice)
        Me.Controls.Add(Me.txtSaladPrice)
        Me.Controls.Add(Me.txtBagelPrice)
        Me.Controls.Add(Me.lblPrice)
        Me.Controls.Add(Me.grpSoda)
        Me.Controls.Add(Me.grpSaladChoice)
        Me.Controls.Add(Me.grpBagelFilling)
        Me.Controls.Add(Me.grpMainMenu)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.Name = "frmDelicatessen"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Delicatessen"
        Me.grpMainMenu.ResumeLayout(False)
        Me.grpMainMenu.PerformLayout()
        Me.grpSoda.ResumeLayout(False)
        Me.grpSoda.PerformLayout()
        Me.grpSaladChoice.ResumeLayout(False)
        Me.grpSaladChoice.PerformLayout()
        Me.grpBagelFilling.ResumeLayout(False)
        Me.grpBagelFilling.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents grpMainMenu As System.Windows.Forms.GroupBox
    Friend WithEvents chkBagel As System.Windows.Forms.CheckBox
    Friend WithEvents chkSalad As System.Windows.Forms.CheckBox
    Friend WithEvents chkSoda As System.Windows.Forms.CheckBox
    Friend WithEvents grpSoda As System.Windows.Forms.GroupBox
    Friend WithEvents rdbCreamSoda As System.Windows.Forms.RadioButton
    Friend WithEvents rdbCola As System.Windows.Forms.RadioButton
    Friend WithEvents grpSaladChoice As System.Windows.Forms.GroupBox
    Friend WithEvents rdbChef As System.Windows.Forms.RadioButton
    Friend WithEvents rdbSpinach As System.Windows.Forms.RadioButton
    Friend WithEvents grpBagelFilling As System.Windows.Forms.GroupBox
    Friend WithEvents chkLox As System.Windows.Forms.CheckBox
    Friend WithEvents chkCreamCheese As System.Windows.Forms.CheckBox
    Friend WithEvents lblPrice As System.Windows.Forms.Label
    Friend WithEvents txtBagelPrice As System.Windows.Forms.TextBox
    Friend WithEvents txtSaladPrice As System.Windows.Forms.TextBox
    Friend WithEvents txtSodaPrice As System.Windows.Forms.TextBox
    Friend WithEvents txtTotal As System.Windows.Forms.TextBox
    Friend WithEvents lblTotal As System.Windows.Forms.Label
    Friend WithEvents lblDelicatessenLogo As System.Windows.Forms.Label

End Class
