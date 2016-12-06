measurement - testing
shouldReMeasureChild: anElement spec: anExtentSpec
	"Return true of a child element should be re-measured, false otherwise.
	If measurement cache is enabled we check if child's measured dimensions
	are up-to-date"
	<return: #Boolean>
	
	^ (self measurementCacheEnabled and: [
			(self
				isMeasurementUpToDate: anElement measuredWidth
				spec: anExtentSpec widthSpec
				resizer: anElement constraints horizontal resizer) and: [ 
					self
						isMeasurementUpToDate: anElement measuredHeight
						spec: anExtentSpec heightSpec
						resizer: anElement constraints vertical resizer ] ]) not