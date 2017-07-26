initialization
setUp
	super setUp.

	buffer := BlMockedKeyboardBuffer new.
	event := BlShortcutEvent new buffer: buffer.
	handler := BlShortcutHandler new.