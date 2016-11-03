initialize-release
initialize
	super initialize.
	rules := OrderedCollection new.
	medias := OrderedCollection new.
	origin := BlStyleOrigin USER