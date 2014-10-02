<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmWindChillCalculator
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
        Me.btnCalculate = New System.Windows.Forms.Button()
        Me.btnExit = New System.Windows.Forms.Button()
        Me.lblEnterAirTemp = New System.Windows.Forms.Label()
        Me.lblEnterWindSpeed = New System.Windows.Forms.Label()
        Me.lblProgramDescription = New System.Windows.Forms.Label()
        Me.txtAirTemp = New System.Windows.Forms.TextBox()
        Me.txtWindSpeed = New System.Windows.Forms.TextBox()
        Me.grpInput = New System.Windows.Forms.GroupBox()
        Me.grpTimeToFrostbite = New System.Windows.Forms.GroupBox()
        Me.grpOutput = New System.Windows.Forms.GroupBox()
        Me.lblDisplayDegreeFahrenheit = New System.Windows.Forms.Label()
        Me.lblWindChill = New System.Windows.Forms.Label()
        Me.lblDisplayCurrentWindChill = New System.Windows.Forms.Label()
        Me.lblDisplayTimeToFrostbite = New System.Windows.Forms.Label()
        Me.lblTimeToFrostbite = New System.Windows.Forms.Label()
        Me.grpInput.SuspendLayout()
        Me.grpTimeToFrostbite.SuspendLayout()
        Me.grpOutput.SuspendLayout()
        Me.SuspendLayout()
        '
        'btnCalculate
        '
        Me.btnCalculate.Location = New System.Drawing.Point(180, 80)
        Me.btnCalculate.Name = "btnCalculate"
        Me.btnCalculate.Size = New System.Drawing.Size(75, 23)
        Me.btnCalculate.TabIndex = 2
        Me.btnCalculate.Text = "Calculate"
        Me.btnCalculate.UseVisualStyleBackColor = True
        '
        'btnExit
        '
        Me.btnExit.DialogResult = System.Windows.Forms.DialogResult.Cancel
        Me.btnExit.Location = New System.Drawing.Point(180, 112)
        Me.btnExit.Name = "btnExit"
        Me.btnExit.Size = New System.Drawing.Size(75, 23)
        Me.btnExit.TabIndex = 3
        Me.btnExit.Text = "Exit"
        Me.btnExit.UseVisualStyleBackColor = True
        '
        'lblEnterAirTemp
        '
        Me.lblEnterAirTemp.AutoSize = True
        Me.lblEnterAirTemp.Location = New System.Drawing.Point(16, 24)
        Me.lblEnterAirTemp.Name = "lblEnterAirTemp"
        Me.lblEnterAirTemp.Size = New System.Drawing.Size(132, 13)
        Me.lblEnterAirTemp.TabIndex = 4
        Me.lblEnterAirTemp.Text = "Enter Air Temperature (ºF):"
        Me.lblEnterAirTemp.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblEnterWindSpeed
        '
        Me.lblEnterWindSpeed.AutoSize = True
        Me.lblEnterWindSpeed.Location = New System.Drawing.Point(20, 52)
        Me.lblEnterWindSpeed.Name = "lblEnterWindSpeed"
        Me.lblEnterWindSpeed.Size = New System.Drawing.Size(126, 13)
        Me.lblEnterWindSpeed.TabIndex = 5
        Me.lblEnterWindSpeed.Text = "Enter Wind Speed (mph):"
        Me.lblEnterWindSpeed.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'lblProgramDescription
        '
        Me.lblProgramDescription.AutoSize = True
        Me.lblProgramDescription.Location = New System.Drawing.Point(92, 12)
        Me.lblProgramDescription.Name = "lblProgramDescription"
        Me.lblProgramDescription.Size = New System.Drawing.Size(222, 26)
        Me.lblProgramDescription.TabIndex = 0
        Me.lblProgramDescription.Text = "This program calculates the current wind chill " & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "from the current temperature and" & _
    " wind speed."
        '
        'txtAirTemp
        '
        Me.txtAirTemp.Location = New System.Drawing.Point(156, 20)
        Me.txtAirTemp.Name = "txtAirTemp"
        Me.txtAirTemp.Size = New System.Drawing.Size(100, 20)
        Me.txtAirTemp.TabIndex = 0
        '
        'txtWindSpeed
        '
        Me.txtWindSpeed.Location = New System.Drawing.Point(156, 48)
        Me.txtWindSpeed.Name = "txtWindSpeed"
        Me.txtWindSpeed.Size = New System.Drawing.Size(100, 20)
        Me.txtWindSpeed.TabIndex = 1
        '
        'grpInput
        '
        Me.grpInput.Controls.Add(Me.grpTimeToFrostbite)
        Me.grpInput.Controls.Add(Me.txtWindSpeed)
        Me.grpInput.Controls.Add(Me.btnExit)
        Me.grpInput.Controls.Add(Me.lblEnterAirTemp)
        Me.grpInput.Controls.Add(Me.btnCalculate)
        Me.grpInput.Controls.Add(Me.txtAirTemp)
        Me.grpInput.Controls.Add(Me.lblEnterWindSpeed)
        Me.grpInput.Location = New System.Drawing.Point(128, 40)
        Me.grpInput.Name = "grpInput"
        Me.grpInput.Size = New System.Drawing.Size(268, 148)
        Me.grpInput.TabIndex = 2
        Me.grpInput.TabStop = False
        '
        'grpTimeToFrostbite
        '
        Me.grpTimeToFrostbite.BackColor = System.Drawing.Color.Red
        Me.grpTimeToFrostbite.Controls.Add(Me.lblTimeToFrostbite)
        Me.grpTimeToFrostbite.Controls.Add(Me.lblDisplayTimeToFrostbite)
        Me.grpTimeToFrostbite.Location = New System.Drawing.Point(20, 72)
        Me.grpTimeToFrostbite.Name = "grpTimeToFrostbite"
        Me.grpTimeToFrostbite.Size = New System.Drawing.Size(148, 64)
        Me.grpTimeToFrostbite.TabIndex = 6
        Me.grpTimeToFrostbite.TabStop = False
        Me.grpTimeToFrostbite.Visible = False
        '
        'grpOutput
        '
        Me.grpOutput.Controls.Add(Me.lblDisplayDegreeFahrenheit)
        Me.grpOutput.Controls.Add(Me.lblWindChill)
        Me.grpOutput.Controls.Add(Me.lblDisplayCurrentWindChill)
        Me.grpOutput.Location = New System.Drawing.Point(12, 44)
        Me.grpOutput.Name = "grpOutput"
        Me.grpOutput.Size = New System.Drawing.Size(108, 124)
        Me.grpOutput.TabIndex = 1
        Me.grpOutput.TabStop = False
        '
        'lblDisplayDegreeFahrenheit
        '
        Me.lblDisplayDegreeFahrenheit.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.lblDisplayDegreeFahrenheit.Font = New System.Drawing.Font("Microsoft Sans Serif", 12.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblDisplayDegreeFahrenheit.Location = New System.Drawing.Point(76, 68)
        Me.lblDisplayDegreeFahrenheit.Name = "lblDisplayDegreeFahrenheit"
        Me.lblDisplayDegreeFahrenheit.Size = New System.Drawing.Size(32, 20)
        Me.lblDisplayDegreeFahrenheit.TabIndex = 2
        Me.lblDisplayDegreeFahrenheit.Text = "ºF"
        '
        'lblWindChill
        '
        Me.lblWindChill.BackColor = System.Drawing.Color.FromArgb(CType(CType(255, Byte), Integer), CType(CType(192, Byte), Integer), CType(CType(128, Byte), Integer))
        Me.lblWindChill.Font = New System.Drawing.Font("Microsoft Sans Serif", 15.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblWindChill.Location = New System.Drawing.Point(12, 68)
        Me.lblWindChill.Name = "lblWindChill"
        Me.lblWindChill.Size = New System.Drawing.Size(64, 24)
        Me.lblWindChill.TabIndex = 1
        Me.lblWindChill.Text = "--"
        Me.lblWindChill.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'lblDisplayCurrentWindChill
        '
        Me.lblDisplayCurrentWindChill.AutoSize = True
        Me.lblDisplayCurrentWindChill.BackColor = System.Drawing.Color.Silver
        Me.lblDisplayCurrentWindChill.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblDisplayCurrentWindChill.ForeColor = System.Drawing.Color.Black
        Me.lblDisplayCurrentWindChill.Location = New System.Drawing.Point(20, 28)
        Me.lblDisplayCurrentWindChill.Name = "lblDisplayCurrentWindChill"
        Me.lblDisplayCurrentWindChill.Size = New System.Drawing.Size(75, 32)
        Me.lblDisplayCurrentWindChill.TabIndex = 0
        Me.lblDisplayCurrentWindChill.Text = "The current" & Global.Microsoft.VisualBasic.ChrW(13) & Global.Microsoft.VisualBasic.ChrW(10) & "wind chill:"
        Me.lblDisplayCurrentWindChill.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'lblDisplayTimeToFrostbite
        '
        Me.lblDisplayTimeToFrostbite.AutoSize = True
        Me.lblDisplayTimeToFrostbite.Font = New System.Drawing.Font("Microsoft Sans Serif", 8.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblDisplayTimeToFrostbite.Location = New System.Drawing.Point(4, 16)
        Me.lblDisplayTimeToFrostbite.Name = "lblDisplayTimeToFrostbite"
        Me.lblDisplayTimeToFrostbite.Size = New System.Drawing.Size(128, 13)
        Me.lblDisplayTimeToFrostbite.TabIndex = 0
        Me.lblDisplayTimeToFrostbite.Text = "Time to get Frostbite:"
        '
        'lblTimeToFrostbite
        '
        Me.lblTimeToFrostbite.AutoSize = True
        Me.lblTimeToFrostbite.Font = New System.Drawing.Font("Microsoft Sans Serif", 9.75!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTimeToFrostbite.Location = New System.Drawing.Point(56, 40)
        Me.lblTimeToFrostbite.Name = "lblTimeToFrostbite"
        Me.lblTimeToFrostbite.Size = New System.Drawing.Size(0, 16)
        Me.lblTimeToFrostbite.TabIndex = 1
        Me.lblTimeToFrostbite.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'frmWindChillCalculator
        '
        Me.AcceptButton = Me.btnCalculate
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.CancelButton = Me.btnExit
        Me.ClientSize = New System.Drawing.Size(405, 198)
        Me.Controls.Add(Me.grpOutput)
        Me.Controls.Add(Me.lblProgramDescription)
        Me.Controls.Add(Me.grpInput)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog
        Me.MaximizeBox = False
        Me.Name = "frmWindChillCalculator"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Wind Chill Calculator"
        Me.grpInput.ResumeLayout(False)
        Me.grpInput.PerformLayout()
        Me.grpTimeToFrostbite.ResumeLayout(False)
        Me.grpTimeToFrostbite.PerformLayout()
        Me.grpOutput.ResumeLayout(False)
        Me.grpOutput.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnCalculate As System.Windows.Forms.Button
    Friend WithEvents btnExit As System.Windows.Forms.Button
    Friend WithEvents lblEnterAirTemp As System.Windows.Forms.Label
    Friend WithEvents lblEnterWindSpeed As System.Windows.Forms.Label
    Friend WithEvents lblProgramDescription As System.Windows.Forms.Label
    Friend WithEvents txtAirTemp As System.Windows.Forms.TextBox
    Friend WithEvents txtWindSpeed As System.Windows.Forms.TextBox
    Friend WithEvents grpInput As System.Windows.Forms.GroupBox
    Friend WithEvents grpOutput As System.Windows.Forms.GroupBox
    Friend WithEvents lblDisplayDegreeFahrenheit As System.Windows.Forms.Label
    Friend WithEvents lblWindChill As System.Windows.Forms.Label
    Friend WithEvents lblDisplayCurrentWindChill As System.Windows.Forms.Label
    Friend WithEvents grpTimeToFrostbite As System.Windows.Forms.GroupBox
    Friend WithEvents lblTimeToFrostbite As System.Windows.Forms.Label
    Friend WithEvents lblDisplayTimeToFrostbite As System.Windows.Forms.Label

End Class
