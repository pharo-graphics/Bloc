examples - instance creation
pannableWithForm
	| form element pannable |
	form := PolymorphSystemSettings pharoLogoForm.
	element := BlElement new.
	element size: form extent.
	element background: (BlImageBackground new image: form).
	pannable := BlPannableElement new.
	pannable
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical matchParent ].
	pannable contentElement: element.
	^ pannable