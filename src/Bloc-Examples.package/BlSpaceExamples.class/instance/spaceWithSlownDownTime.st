examples - time
spaceWithSlownDownTime
	<gtExample>
	| aTime aSpace |

	aTime := BlFastForwardedTime new.
	aTime speed: 0.2.

	aSpace := BlSpace new.
	aSpace time: aTime.
	
	^ aSpace