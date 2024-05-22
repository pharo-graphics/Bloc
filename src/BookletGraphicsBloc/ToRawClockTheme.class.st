"
Extension of Raw Theme to include clock element that can be customized.

"
Class {
	#name : #ToRawClockTheme,
	#superclass : #ToRawTheme,
	#category : #'BookletGraphicsBloc-Clock'
}

{ #category : #accessing }
ToRawClockTheme class >> defaultTokenProperties [

	^ super defaultTokenProperties , {
		  (ToTokenProperty
			   name: #'clock-background-color'
			   value: Color lightYellow ).
		  (ToTokenProperty name: #'clock-border-width' value: 4).
		  (ToTokenProperty name: #'clock-border-color' value: Color lightMagenta ).
		  (ToTokenProperty name: #'clock-border-quarterWidth' value: 8).
		  (ToTokenProperty name: #'clock-border-hourWidth' value: 6).
		  (ToTokenProperty
			   name: #'clock-hour-needle-color'
			   value: Color black).
		  (ToTokenProperty name: #'clock-hour-needle-width' value: 5).
		  (ToTokenProperty
			   name: #'clock-minute-needle-color'
			   value: Color black).
		  (ToTokenProperty name: #'clock-minute-needle-width' value: 5).
		  (ToTokenProperty
			   name: #'clock-minute-needle-color'
			   value: Color black).
		  (ToTokenProperty name: #'clock-minute-needle-width' value: 5).
		  (ToTokenProperty
			   name: #'clock-second-needle-color'
			   value: Color red).
		  (ToTokenProperty name: #'clock-second-needle-width' value: 3).

		  (ToTokenProperty
			   name: #'clock-background-color-hover'
			   value: Color blue) }
]
