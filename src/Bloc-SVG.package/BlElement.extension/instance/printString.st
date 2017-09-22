*Bloc-SVG
printString
	^self userData at:#svgName ifAbsent:[super printString].