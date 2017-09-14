gradients & patterns
stopFrom: node
	| offsetString offset color |
	
	offsetString := node attributeAt: 'offset'.
	(offsetString beginsWith: '.')
		ifTrue: [ offsetString := '0' , offsetString ].
	offset := (offsetString endsWith: '%')
		ifTrue: [ (offsetString withoutSuffix: '%') asNumber / 100 ]
		ifFalse: [ offsetString asNumber ].
		
	color := SvgColor fromString: (node attributeAt: 'stop-color').
	
	^ (offset asFloat -> color)