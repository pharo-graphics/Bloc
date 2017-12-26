updating
updateColor
	widget border: (widget border copyWithPaint: self color).
	thumb background: self color.
	track background: (self color alpha: 0.3)