converting
convertKeyModifiers: modifiers
	<return: #BlKeyModifiers>

	^ BlKeyModifiers
		shift: modifiers shift
		ctrl: modifiers ctrl
		alt: modifiers alt
		cmd: modifiers cmd