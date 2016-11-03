*Bloc-Athens-experimental
cacheOnAthensCanvas: anAthensCanvas
	"(self isVisible and: [ self isInDirtyAreas ])
		ifFalse: [ ^ self ].
		
	(paintCache isNil or:[self dirty]) ifTrue: [ 
		surfaceCache drawDuring: [ :aCanvasCache | 
			surfaceCache clear.
			self effect applyEffectOn: aCanvasCache for: self around: [ 
				aCanvasCache clipByPath: (self clip) during: [ 
					self drawOn: aCanvasCache ]]].
		paintCache := surfaceCache asAthensPaintOn: nil].	
		
		
	anAthensCanvas pathTransform restoreAfter: [ 
			anAthensCanvas pathTransform multiplyBy: self transform.
			anAthensCanvas preservingClipByLocal: self boundsInLocal global: self boundsInSpace during: [
						
				paintCache athensFillRectangle: self boundsInLocal on: anAthensCanvas.
				self dirty: false.
				]]."
	