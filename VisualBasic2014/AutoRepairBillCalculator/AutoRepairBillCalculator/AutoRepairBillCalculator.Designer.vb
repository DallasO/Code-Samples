<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class AutoRepairBillCalculator
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
        Me.lblCustomer = New System.Windows.Forms.Label()
        Me.lblLaborHours = New System.Windows.Forms.Label()
        Me.lblCost = New System.Windows.Forms.Label()
        Me.txtCustomerName = New System.Windows.Forms.TextBox()
        Me.txtLaborHours = New System.Windows.Forms.TextBox()
        Me.txtCost = New System.Windows.Forms.TextBox()
        Me.btnCalc = New System.Windows.Forms.Button()
        Me.lstBill = New System.Windows.Forms.ListBox()
        Me.SuspendLayout()
        '
        'lblCustomer
        '
        Me.lblCustomer.AutoSize = True
        Me.lblCustomer.Location = New System.Drawing.Point(38, 12)
        Me.lblCustomer.Name = "lblCustomer"
        Me.lblCustomer.Size = New System.Drawing.Size(54, 13)
        Me.lblCustomer.TabIndex = 0
        Me.lblCustomer.Text = "Customer:"
        '
        'lblLaborHours
        '
        Me.lblLaborHours.AutoSize = True
        Me.lblLaborHours.Location = New System.Drawing.Point(12, 38)
        Me.lblLaborHours.Name = "lblLaborHours"
        Me.lblLaborHours.Size = New System.Drawing.Size(80, 13)
        Me.lblLaborHours.TabIndex = 1
        Me.lblLaborHours.Text = "Hours of Labor:"
        '
        'lblCost
        '
        Me.lblCost.AutoSize = True
        Me.lblCost.Location = New System.Drawing.Point(21, 61)
        Me.lblCost.Name = "lblCost"
        Me.lblCost.Size = New System.Drawing.Size(71, 26)
        Me.lblCost.TabIndex = 2
        Me.lblCost.Text = "Cost of Parts" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "and Supplies:"
        '
        'txtCustomerName
        '
        Me.txtCustomerName.Location = New System.Drawing.Point(109, 9)
        Me.txtCustomerName.MaxLength = 15
        Me.txtCustomerName.Name = "txtCustomerName"
        Me.txtCustomerName.Size = New System.Drawing.Size(100, 20)
        Me.txtCustomerName.TabIndex = 3
        '
        'txtLaborHours
        '
        Me.txtLaborHours.Location = New System.Drawing.Point(109, 35)
        Me.txtLaborHours.MaxLength = 6
        Me.txtLaborHours.Name = "txtLaborHours"
        Me.txtLaborHours.Size = New System.Drawing.Size(73, 20)
        Me.txtLaborHours.TabIndex = 4
        '
        'txtCost
        '
        Me.txtCost.Location = New System.Drawing.Point(109, 61)
        Me.txtCost.MaxLength = 6
        Me.txtCost.Name = "txtCost"
        Me.txtCost.Size = New System.Drawing.Size(73, 20)
        Me.txtCost.TabIndex = 5
        '
        'btnCalc
        '
        Me.btnCalc.Location = New System.Drawing.Point(41, 100)
        Me.btnCalc.Name = "btnCalc"
        Me.btnCalc.Size = New System.Drawing.Size(98, 25)
        Me.btnCalc.TabIndex = 6
        Me.btnCalc.Text = "Calculate Bill"
        Me.btnCalc.UseVisualStyleBackColor = True
        '
        'lstBill
        '
        Me.lstBill.FormattingEnabled = True
        Me.lstBill.Location = New System.Drawing.Point(188, 38)
        Me.lstBill.Name = "lstBill"
        Me.lstBill.Size = New System.Drawing.Size(170, 82)
        Me.lstBill.TabIndex = 0
        '
        'AutoRepairBillCalculator
        '
        Me.AcceptButton = Me.btnCalc
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(370, 130)
        Me.Controls.Add(Me.lstBill)
        Me.Controls.Add(Me.btnCalc)
        Me.Controls.Add(Me.txtCost)
        Me.Controls.Add(Me.txtLaborHours)
        Me.Controls.Add(Me.txtCustomerName)
        Me.Controls.Add(Me.lblCost)
        Me.Controls.Add(Me.lblLaborHours)
        Me.Controls.Add(Me.lblCustomer)
        Me.Name = "AutoRepairBillCalculator"
        Me.Text = "Andies Auto Care Center"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents lblCustomer As System.Windows.Forms.Label
    Friend WithEvents lblLaborHours As System.Windows.Forms.Label
    Friend WithEvents lblCost As System.Windows.Forms.Label
    Friend WithEvents txtCustomerName As System.Windows.Forms.TextBox
    Friend WithEvents txtLaborHours As System.Windows.Forms.TextBox
    Friend WithEvents txtCost As System.Windows.Forms.TextBox
    Friend WithEvents btnCalc As System.Windows.Forms.Button
    Friend WithEvents lstBill As System.Windows.Forms.ListBox

End Class
