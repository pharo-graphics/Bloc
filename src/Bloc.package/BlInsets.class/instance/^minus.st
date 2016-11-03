converting
- anInsets
	^ BlInsets
		top: (top - anInsets top max: 0)
		right: (right - anInsets right max: 0)
		bottom: (bottom - anInsets bottom max: 0)
		left: (left - anInsets left max: 0)