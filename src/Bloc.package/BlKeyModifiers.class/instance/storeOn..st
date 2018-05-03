printing
storeOn: aStream
	aStream nextPutAll: '('.
	aStream nextPutAll: self class name.
	aStream nextPutAll: ' shift: '.
	aStream store: self isShift.
	aStream nextPutAll: ' ctrl: '.
	aStream store: self isCtrl.
	aStream nextPutAll: ' alt: '.
	aStream store: self isAlt.
	aStream nextPutAll: ' cmd: '.
	aStream store: self isCmd.
	aStream nextPutAll: ' capsLock: '.
	aStream store: self isCapsLock.
	aStream nextPutAll: ' numLock: '.
	aStream store: self isNumLock.
	aStream nextPutAll: ')'