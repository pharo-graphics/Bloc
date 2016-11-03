as yet unclassified
defaultStylesheet
	^ DefaultStylesheet
		ifNil: [ DefaultStylesheet := BlStylesheet origin: BlStyleOrigin AUTHOR ]