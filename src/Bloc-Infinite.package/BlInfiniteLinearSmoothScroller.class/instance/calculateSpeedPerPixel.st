physics
calculateSpeedPerPixel
	"Calculate the time (in ms) it should take for each pixel. For instance,
	if returned value is 2 ms, it means scrolling 1000 pixels with LinearInterpolation should take 2 seconds"
	<return: #Duration>
	| aDpi |

	aDpi := infiniteElement isAttachedToSceneGraph
		ifTrue: [ infiniteElement space densityDpi ]
		"not attached to space, can only guess.."
		ifFalse: [ 96.0 ].
	
	^ self millisecondsPerInch / aDpi