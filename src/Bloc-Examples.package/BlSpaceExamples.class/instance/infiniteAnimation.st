private - instance creation
infiniteAnimation
	<gtExample>
	| anAnimation |

	anAnimation := BlSequentialAnimation new.
	anAnimation add: (BlTransformAnimation scale: 2) absolute.
	anAnimation add: (BlTransformAnimation scale: 0.5) absolute.
	anAnimation beInfinite.
	
	^ anAnimation