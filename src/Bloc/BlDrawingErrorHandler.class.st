"
I handle errors happened during rendering phase.

To not completely break the UI thread we should catch the error and prevent the element from further rendering
"
Class {
	#name : #BlDrawingErrorHandler,
	#superclass : #BlErrorHandler,
	#category : #'Bloc-Basic-Errors'
}
