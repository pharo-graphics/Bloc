"
I am a dynamic element transformation in the sense that my transformation matrix may actually depend on some element properties such as #extent or #position.

It means that matrix computation is performed only when requested taking owner element into account.
This also means that the matrix dimension (2D or 3D) should be determined dynamically based on inner transformations.

"
Class {
	#name : #BlElementDynamicTransformation,
	#superclass : #BlElementTransformation,
	#category : #'Bloc-Basic-Transformations'
}
