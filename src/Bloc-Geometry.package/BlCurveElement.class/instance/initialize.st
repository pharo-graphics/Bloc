initialization
initialize
	super initialize.
	
	fromAnchor := self defaultFromAnchor.
	toAnchor := self defaultToAnchor.
	
	fromHead := BlElement new.
	fromHead size: 0@0.
	fromHead background: (Color gray alpha: 0.5).
	fromHead constraints ignoreByLayout.
	"self addChild: fromHead."

	self wantsMouse: false