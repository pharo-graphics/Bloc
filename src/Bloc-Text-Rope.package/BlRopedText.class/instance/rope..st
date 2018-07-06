accessing
rope: aBrRope

	locked ifTrue: [ BlTextLockedError signal: 'Can not modify locked text!' ].

	rope := aBrRope