accessing
rope: aBrRope

	locked ifTrue: [ BrTextLockedError signal: 'Can not modify locked text!' ].

	rope := aBrRope