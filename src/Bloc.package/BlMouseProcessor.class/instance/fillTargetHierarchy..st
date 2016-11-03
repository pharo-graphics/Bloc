event processing
fillTargetHierarchy: aTarget
	| p arr |
	arr := Array new.
	arr := arr copyWith: aTarget.
	p := aTarget parent.
	[ p isNotNil ] whileTrue: [
			arr := arr copyWith: p.
			p := p parent. ].
	^ arr