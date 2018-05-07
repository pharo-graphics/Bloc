api
onAddedToWindow
	currentWindow := self window.
	currentWindow announcer when: WindowClosed send: #onWindowClosed to: self