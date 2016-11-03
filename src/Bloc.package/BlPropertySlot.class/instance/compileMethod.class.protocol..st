as yet unclassified
compileMethod: aMethodString class: aClass protocol: aProtocol
	(aClass slots includes: self)
		ifFalse: [ ^ self ].
	aClass compile: aMethodString classified: aProtocol