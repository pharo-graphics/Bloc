"
I am a subclass of Color that implements the color standard of SVG as specified by W3C ( see https://www.w3.org/TR/SVG/types.html#ColorKeywords ).

I can be instanciated through 3 different ways:

	-> with a color keyword of the standard ( example: SVGColor navy )
	
	-> with a rgb triplet ( example: SVGColor fromRgbString:'rgb(0,0,255))' 
								SVGColor fromRgbString:'rgb(0%,0%,100%))'  )
						
	-> with a HexString with 6 or 3 characters ( example: SVGColor fromHexString:'0000FF' 
													SVGColor fromHexString:'00F'   )
													
My method ""fromString:"" allows me to choose myself the right instanciation method to use among the ones above.

	-> SVGColor fromString:'navy' <=> SVGColor navy
	
	-> SVGColor fromString:'rgb(0,0,255))'  <=> SVGColor fromRgbString:'rgb(0,0,255))' 
	     SVGColor fromString:'rgb(0%,0%,100%))' <=> SVGColor fromRgbString:'rgb(0%,0%,100%))'
	
	-> SVGColor fromString:'#0000FF' <=>  SVGColor fromHexString:'0000FF' 
	     SVGColor fromString:'#00F' <=> SVGColor fromHexString:'00F'

--------------------------------------------------------------------------------------------------------------------------------------------------

Not much to see on the instance side.
"
Class {
	#name : #BlSvgColor,
	#superclass : #Color,
	#classVars : [
		'SVGColorRegistry'
	],
	#category : #'Bloc-SVG-Converter'
}

{ #category : #defaults }
BlSvgColor class >> aliceblue [
	^ SVGColorRegistry at: #aliceblue
]

{ #category : #defaults }
BlSvgColor class >> antiquewhite [
	^ SVGColorRegistry at: #antiquewhite
]

{ #category : #defaults }
BlSvgColor class >> aqua [
	^ SVGColorRegistry at: #aqua
]

{ #category : #defaults }
BlSvgColor class >> aquamarine [
	^ SVGColorRegistry at: #aquamarine
]

{ #category : #defaults }
BlSvgColor class >> azure [
	^ SVGColorRegistry at: #azure
]

{ #category : #defaults }
BlSvgColor class >> beige [
	^ SVGColorRegistry at: #beige
]

{ #category : #defaults }
BlSvgColor class >> bisque [
	^ SVGColorRegistry at: #bisque
]

{ #category : #defaults }
BlSvgColor class >> black [
	^ SVGColorRegistry at: #black
]

{ #category : #defaults }
BlSvgColor class >> blanchedalmond [
	^ SVGColorRegistry at: #blanchedalmond
]

{ #category : #defaults }
BlSvgColor class >> blue [
	^ SVGColorRegistry at: #blue
]

{ #category : #defaults }
BlSvgColor class >> blueviolet [
	^ SVGColorRegistry at: #blueviolet
]

{ #category : #defaults }
BlSvgColor class >> brown [
	^ SVGColorRegistry at: #brown
]

{ #category : #defaults }
BlSvgColor class >> burlywood [
	^ SVGColorRegistry at: #burlywood
]

{ #category : #defaults }
BlSvgColor class >> cadetblue [
	^ SVGColorRegistry at: #cadetblue
]

{ #category : #defaults }
BlSvgColor class >> chartreuse [
	^ SVGColorRegistry at: #chartreuse
]

{ #category : #defaults }
BlSvgColor class >> chocolate [
	^ SVGColorRegistry at: #chocolate
]

{ #category : #'initialize-release' }
BlSvgColor class >> compileMethodforColor: colorName [
	|stream|
	stream := WriteStream with: colorName.
	stream nextPut: Character cr;
		nextPutAll: '	^ SVGColorRegistry at: #';
		nextPutAll: colorName.
	
	self class compile: stream contents classified: 'defaults'.
]

{ #category : #defaults }
BlSvgColor class >> coral [
	^ SVGColorRegistry at: #coral
]

{ #category : #defaults }
BlSvgColor class >> cornflowerblue [
	^ SVGColorRegistry at: #cornflowerblue
]

{ #category : #defaults }
BlSvgColor class >> cornsilk [
	^ SVGColorRegistry at: #cornsilk
]

{ #category : #defaults }
BlSvgColor class >> crimson [
	^ SVGColorRegistry at: #crimson
]

{ #category : #defaults }
BlSvgColor class >> cyan [
	^ SVGColorRegistry at: #cyan
]

{ #category : #defaults }
BlSvgColor class >> darkblue [
	^ SVGColorRegistry at: #darkblue
]

{ #category : #defaults }
BlSvgColor class >> darkcyan [
	^ SVGColorRegistry at: #darkcyan
]

{ #category : #defaults }
BlSvgColor class >> darkgoldenrod [
	^ SVGColorRegistry at: #darkgoldenrod
]

{ #category : #defaults }
BlSvgColor class >> darkgray [
	^ SVGColorRegistry at: #darkgray
]

{ #category : #defaults }
BlSvgColor class >> darkgreen [
	^ SVGColorRegistry at: #darkgreen
]

{ #category : #defaults }
BlSvgColor class >> darkgrey [
	^ SVGColorRegistry at: #darkgrey
]

{ #category : #defaults }
BlSvgColor class >> darkkhaki [
	^ SVGColorRegistry at: #darkkhaki
]

{ #category : #defaults }
BlSvgColor class >> darkmagenta [
	^ SVGColorRegistry at: #darkmagenta
]

{ #category : #defaults }
BlSvgColor class >> darkolivegreen [
	^ SVGColorRegistry at: #darkolivegreen
]

{ #category : #defaults }
BlSvgColor class >> darkorange [
	^ SVGColorRegistry at: #darkorange
]

{ #category : #defaults }
BlSvgColor class >> darkorchid [
	^ SVGColorRegistry at: #darkorchid
]

{ #category : #defaults }
BlSvgColor class >> darkred [
	^ SVGColorRegistry at: #darkred
]

{ #category : #defaults }
BlSvgColor class >> darksalmon [
	^ SVGColorRegistry at: #darksalmon
]

{ #category : #defaults }
BlSvgColor class >> darkseagreen [
	^ SVGColorRegistry at: #darkseagreen
]

{ #category : #defaults }
BlSvgColor class >> darkslateblue [
	^ SVGColorRegistry at: #darkslateblue
]

{ #category : #defaults }
BlSvgColor class >> darkslategray [
	^ SVGColorRegistry at: #darkslategray
]

{ #category : #defaults }
BlSvgColor class >> darkslategrey [
	^ SVGColorRegistry at: #darkslategrey
]

{ #category : #defaults }
BlSvgColor class >> darkturquoise [
	^ SVGColorRegistry at: #darkturquoise
]

{ #category : #defaults }
BlSvgColor class >> darkviolet [
	^ SVGColorRegistry at: #darkviolet
]

{ #category : #defaults }
BlSvgColor class >> deeppink [
	^ SVGColorRegistry at: #deeppink
]

{ #category : #defaults }
BlSvgColor class >> deepskyblue [
	^ SVGColorRegistry at: #deepskyblue
]

{ #category : #defaults }
BlSvgColor class >> dimgray [
	^ SVGColorRegistry at: #dimgray
]

{ #category : #defaults }
BlSvgColor class >> dimgrey [
	^ SVGColorRegistry at: #dimgrey
]

{ #category : #defaults }
BlSvgColor class >> dodgerblue [
	^ SVGColorRegistry at: #dodgerblue
]

{ #category : #defaults }
BlSvgColor class >> firebrick [
	^ SVGColorRegistry at: #firebrick
]

{ #category : #defaults }
BlSvgColor class >> floralwhite [
	^ SVGColorRegistry at: #floralwhite
]

{ #category : #defaults }
BlSvgColor class >> forestgreen [
	^ SVGColorRegistry at: #forestgreen
]

{ #category : #'instance creation' }
BlSvgColor class >> fromHexString: aColorHex [

	| stream |
	stream := WriteStream on: ''.
	aColorHex size = 3
		ifTrue: [
			aColorHex do: [ :character |
				2 timesRepeat: [ stream nextPut: character ] ] ]
		ifFalse: [ stream nextPutAll: aColorHex ].

	^ super fromHexString: stream contents
]

{ #category : #'instance creation' }
BlSvgColor class >> fromRgbString: aString [
	|array|
	array := ( ((aString withoutPrefix: 'rgb(') withoutSuffix: ')') substrings: ',' ) collect: [:stringValue |
		(stringValue endsWith: '%') ifTrue: [(stringValue withoutSuffix: '%') asNumber * 255 / 100 ]
											ifFalse: [stringValue asNumber]].
	
	^self fromRgbTripletOnBase256: array
]

{ #category : #'instance creation' }
BlSvgColor class >> fromRgbTripletOnBase256: array [
	^ self r: (array first / 255) g: (array second / 255) b: (array last / 255)
]

{ #category : #'instance creation' }
BlSvgColor class >> fromString: aString [
	aString='none' ifTrue:[^self transparent].
	"If aString is following the format: 'rgb(R,G,B)' or 'rgb(R%,G%,B%)':"
	(aString beginsWith: 'rgb(') ifTrue:[^self fromRgbString: aString].
	"If aString is following the format: '#RRGGBB' or '#RGB':"
	(aString beginsWith: '#') ifTrue:[^self fromHexString: aString allButFirst].
	"If aString is a color keyword"
	^super fromString:aString
]

{ #category : #defaults }
BlSvgColor class >> fuchsia [
	^ SVGColorRegistry at: #fuchsia
]

{ #category : #defaults }
BlSvgColor class >> gainsboro [
	^ SVGColorRegistry at: #gainsboro
]

{ #category : #defaults }
BlSvgColor class >> ghostwhite [
	^ SVGColorRegistry at: #ghostwhite
]

{ #category : #defaults }
BlSvgColor class >> gold [
	^ SVGColorRegistry at: #gold
]

{ #category : #defaults }
BlSvgColor class >> goldenrod [
	^ SVGColorRegistry at: #goldenrod
]

{ #category : #defaults }
BlSvgColor class >> gray [
	^ SVGColorRegistry at: #gray
]

{ #category : #defaults }
BlSvgColor class >> green [
	^ SVGColorRegistry at: #green
]

{ #category : #defaults }
BlSvgColor class >> greenyellow [
	^ SVGColorRegistry at: #greenyellow
]

{ #category : #defaults }
BlSvgColor class >> grey [
	^ SVGColorRegistry at: #grey
]

{ #category : #defaults }
BlSvgColor class >> honeydew [
	^ SVGColorRegistry at: #honeydew
]

{ #category : #defaults }
BlSvgColor class >> hotpink [
	^ SVGColorRegistry at: #hotpink
]

{ #category : #defaults }
BlSvgColor class >> indianred [
	^ SVGColorRegistry at: #indianred
]

{ #category : #defaults }
BlSvgColor class >> indigo [
	^ SVGColorRegistry at: #indigo
]

{ #category : #'initialize-release' }
BlSvgColor class >> initialize [
	self initializeColorRegistry.
]

{ #category : #'initialize-release' }
BlSvgColor class >> initializeColorRegistry [
	|values|
	SVGColorRegistry := IdentityDictionary new.
	values := self svgColors1 , self svgColors2.
	1 to: values size by: #(name r g b) size do:[:index|
		|  colorName red green blue color |
		colorName := values at: index.
		red := values at: index + 1.
		green := values at: index + 2.
		blue := values at: index +3.
		color := self fromRgbTripletOnBase256: {red. green. blue.}.
		self registerColor: color named: colorName.
		self compileMethodforColor: colorName].
	self registerColor: (self r: 0 g: 0 b: 0 alpha: 0.0) named: #transparent.
	self compileMethodforColor: 'transparent'
]

{ #category : #defaults }
BlSvgColor class >> ivory [
	^ SVGColorRegistry at: #ivory
]

{ #category : #defaults }
BlSvgColor class >> khaki [
	^ SVGColorRegistry at: #khaki
]

{ #category : #defaults }
BlSvgColor class >> lavender [
	^ SVGColorRegistry at: #lavender
]

{ #category : #defaults }
BlSvgColor class >> lavenderblush [
	^ SVGColorRegistry at: #lavenderblush
]

{ #category : #defaults }
BlSvgColor class >> lawngreen [
	^ SVGColorRegistry at: #lawngreen
]

{ #category : #defaults }
BlSvgColor class >> lemonchiffon [
	^ SVGColorRegistry at: #lemonchiffon
]

{ #category : #defaults }
BlSvgColor class >> lightblue [
	^ SVGColorRegistry at: #lightblue
]

{ #category : #defaults }
BlSvgColor class >> lightcoral [
	^ SVGColorRegistry at: #lightcoral
]

{ #category : #defaults }
BlSvgColor class >> lightcyan [
	^ SVGColorRegistry at: #lightcyan
]

{ #category : #defaults }
BlSvgColor class >> lightgoldenrodyellow [
	^ SVGColorRegistry at: #lightgoldenrodyellow
]

{ #category : #defaults }
BlSvgColor class >> lightgray [
	^ SVGColorRegistry at: #lightgray
]

{ #category : #defaults }
BlSvgColor class >> lightgreen [
	^ SVGColorRegistry at: #lightgreen
]

{ #category : #defaults }
BlSvgColor class >> lightgrey [
	^ SVGColorRegistry at: #lightgrey
]

{ #category : #defaults }
BlSvgColor class >> lightpink [
	^ SVGColorRegistry at: #lightpink
]

{ #category : #defaults }
BlSvgColor class >> lightsalmon [
	^ SVGColorRegistry at: #lightsalmon
]

{ #category : #defaults }
BlSvgColor class >> lightseagreen [
	^ SVGColorRegistry at: #lightseagreen
]

{ #category : #defaults }
BlSvgColor class >> lightskyblue [
	^ SVGColorRegistry at: #lightskyblue
]

{ #category : #defaults }
BlSvgColor class >> lightslategray [
	^ SVGColorRegistry at: #lightslategray
]

{ #category : #defaults }
BlSvgColor class >> lightslategrey [
	^ SVGColorRegistry at: #lightslategrey
]

{ #category : #defaults }
BlSvgColor class >> lightsteelblue [
	^ SVGColorRegistry at: #lightsteelblue
]

{ #category : #defaults }
BlSvgColor class >> lightyellow [
	^ SVGColorRegistry at: #lightyellow
]

{ #category : #defaults }
BlSvgColor class >> lime [
	^ SVGColorRegistry at: #lime
]

{ #category : #defaults }
BlSvgColor class >> limegreen [
	^ SVGColorRegistry at: #limegreen
]

{ #category : #defaults }
BlSvgColor class >> linen [
	^ SVGColorRegistry at: #linen
]

{ #category : #defaults }
BlSvgColor class >> magenta [
	^ SVGColorRegistry at: #magenta
]

{ #category : #defaults }
BlSvgColor class >> maroon [
	^ SVGColorRegistry at: #maroon
]

{ #category : #defaults }
BlSvgColor class >> mediumaquamarine [
	^ SVGColorRegistry at: #mediumaquamarine
]

{ #category : #defaults }
BlSvgColor class >> mediumblue [
	^ SVGColorRegistry at: #mediumblue
]

{ #category : #defaults }
BlSvgColor class >> mediumorchid [
	^ SVGColorRegistry at: #mediumorchid
]

{ #category : #defaults }
BlSvgColor class >> mediumpurple [
	^ SVGColorRegistry at: #mediumpurple
]

{ #category : #defaults }
BlSvgColor class >> mediumseagreen [
	^ SVGColorRegistry at: #mediumseagreen
]

{ #category : #defaults }
BlSvgColor class >> mediumslateblue [
	^ SVGColorRegistry at: #mediumslateblue
]

{ #category : #defaults }
BlSvgColor class >> mediumspringgreen [
	^ SVGColorRegistry at: #mediumspringgreen
]

{ #category : #defaults }
BlSvgColor class >> mediumturquoise [
	^ SVGColorRegistry at: #mediumturquoise
]

{ #category : #defaults }
BlSvgColor class >> mediumvioletred [
	^ SVGColorRegistry at: #mediumvioletred
]

{ #category : #defaults }
BlSvgColor class >> midnightblue [
	^ SVGColorRegistry at: #midnightblue
]

{ #category : #defaults }
BlSvgColor class >> mintcream [
	^ SVGColorRegistry at: #mintcream
]

{ #category : #defaults }
BlSvgColor class >> mistyrose [
	^ SVGColorRegistry at: #mistyrose
]

{ #category : #defaults }
BlSvgColor class >> moccasin [
	^ SVGColorRegistry at: #moccasin
]

{ #category : #accessing }
BlSvgColor class >> named: aColorName [
	^ SVGColorRegistry  at: aColorName asSymbol ifAbsent: nil 
]

{ #category : #defaults }
BlSvgColor class >> navajowhite [
	^ SVGColorRegistry at: #navajowhite
]

{ #category : #defaults }
BlSvgColor class >> navy [
	^ SVGColorRegistry at: #navy
]

{ #category : #defaults }
BlSvgColor class >> oldlace [
	^ SVGColorRegistry at: #oldlace
]

{ #category : #defaults }
BlSvgColor class >> olive [
	^ SVGColorRegistry at: #olive
]

{ #category : #defaults }
BlSvgColor class >> olivedrab [
	^ SVGColorRegistry at: #olivedrab
]

{ #category : #defaults }
BlSvgColor class >> orange [
	^ SVGColorRegistry at: #orange
]

{ #category : #defaults }
BlSvgColor class >> orangered [
	^ SVGColorRegistry at: #orangered
]

{ #category : #defaults }
BlSvgColor class >> orchid [
	^ SVGColorRegistry at: #orchid
]

{ #category : #defaults }
BlSvgColor class >> palegoldenrod [
	^ SVGColorRegistry at: #palegoldenrod
]

{ #category : #defaults }
BlSvgColor class >> palegreen [
	^ SVGColorRegistry at: #palegreen
]

{ #category : #defaults }
BlSvgColor class >> paleturquoise [
	^ SVGColorRegistry at: #paleturquoise
]

{ #category : #defaults }
BlSvgColor class >> palevioletred [
	^ SVGColorRegistry at: #palevioletred
]

{ #category : #defaults }
BlSvgColor class >> papayawhip [
	^ SVGColorRegistry at: #papayawhip
]

{ #category : #defaults }
BlSvgColor class >> peachpuff [
	^ SVGColorRegistry at: #peachpuff
]

{ #category : #defaults }
BlSvgColor class >> peru [
	^ SVGColorRegistry at: #peru
]

{ #category : #defaults }
BlSvgColor class >> pink [
	^ SVGColorRegistry at: #pink
]

{ #category : #defaults }
BlSvgColor class >> plum [
	^ SVGColorRegistry at: #plum
]

{ #category : #defaults }
BlSvgColor class >> powderblue [
	^ SVGColorRegistry at: #powderblue
]

{ #category : #defaults }
BlSvgColor class >> purple [
	^ SVGColorRegistry at: #purple
]

{ #category : #defaults }
BlSvgColor class >> red [
	^ SVGColorRegistry at: #red
]

{ #category : #'initialize-release' }
BlSvgColor class >> registerColor: aColor named: aName [
	SVGColorRegistry at: aName put: aColor.
]

{ #category : #accessing }
BlSvgColor class >> registeredColorNames [
	^ SVGColorRegistry keys collect: #asString 
]

{ #category : #accessing }
BlSvgColor class >> registeredNameOf: aColor [ 
	| colorName |
	colorName := #unnamed.
	SVGColorRegistry keysAndValuesDo: [:key :value|  value = aColor ifTrue: [ colorName := key ] ].
	^ colorName 
]

{ #category : #defaults }
BlSvgColor class >> rosybrown [
	^ SVGColorRegistry at: #rosybrown
]

{ #category : #defaults }
BlSvgColor class >> royalblue [
	^ SVGColorRegistry at: #royalblue
]

{ #category : #defaults }
BlSvgColor class >> saddlebrown [
	^ SVGColorRegistry at: #saddlebrown
]

{ #category : #defaults }
BlSvgColor class >> salmon [
	^ SVGColorRegistry at: #salmon
]

{ #category : #defaults }
BlSvgColor class >> sandybrown [
	^ SVGColorRegistry at: #sandybrown
]

{ #category : #defaults }
BlSvgColor class >> seagreen [
	^ SVGColorRegistry at: #seagreen
]

{ #category : #defaults }
BlSvgColor class >> seashell [
	^ SVGColorRegistry at: #seashell
]

{ #category : #defaults }
BlSvgColor class >> sienna [
	^ SVGColorRegistry at: #sienna
]

{ #category : #defaults }
BlSvgColor class >> silver [
	^ SVGColorRegistry at: #silver
]

{ #category : #defaults }
BlSvgColor class >> skyblue [
	^ SVGColorRegistry at: #skyblue
]

{ #category : #defaults }
BlSvgColor class >> slateblue [
	^ SVGColorRegistry at: #slateblue
]

{ #category : #defaults }
BlSvgColor class >> slategray [
	^ SVGColorRegistry at: #slategray
]

{ #category : #defaults }
BlSvgColor class >> slategrey [
	^ SVGColorRegistry at: #slategrey
]

{ #category : #defaults }
BlSvgColor class >> snow [
	^ SVGColorRegistry at: #snow
]

{ #category : #defaults }
BlSvgColor class >> springgreen [
	^ SVGColorRegistry at: #springgreen
]

{ #category : #defaults }
BlSvgColor class >> steelblue [
	^ SVGColorRegistry at: #steelblue
]

{ #category : #defaults }
BlSvgColor class >> svgColors1 [
	^{ #aliceblue. 240. 248. 255.
		#antiquewhite. 250. 235. 215.
		#aqua. 0. 255. 255.
		#aquamarine. 127. 255. 212.
		#azure. 240. 255. 255.
		#beige. 245. 245. 220.
		#bisque. 255. 228. 196.
		#black. 0. 0. 0.
		#blanchedalmond. 255. 235. 205.
		#blue. 0. 0. 255.
		#blueviolet. 138. 43. 226.
		#brown. 165. 42. 42.
		#burlywood. 222. 184. 135.
		#cadetblue. 95. 158. 160.
		#chartreuse. 127. 255. 0.
		#chocolate. 210. 105. 30.
		#coral. 255. 127. 80.
		#cornflowerblue. 100. 149. 237.
		#cornsilk. 255. 248. 220.
		#crimson. 220. 20. 60.
		#cyan. 0. 255. 255.
		#darkblue. 0. 0. 139.
		#darkcyan. 0. 139. 139.
		#darkgoldenrod. 184. 134. 11.
		#darkgray. 169. 169. 169.
		#darkgreen. 0. 100. 0.
		#darkgrey. 169. 169. 169.
		#darkkhaki. 189. 183. 107.
		#darkmagenta. 139. 0. 139.
		#darkolivegreen. 85. 107. 47.
		#darkorange. 255. 140. 0.
		#darkorchid. 153. 50. 204.
		#darkred. 139. 0. 0.
		#darksalmon. 233. 150. 122.
		#darkseagreen. 143. 188. 143.
		#darkslateblue. 72. 61. 139.
		#darkslategray. 47. 79. 79.
		#darkslategrey. 47. 79. 79.
		#darkturquoise. 0. 206. 209.
		#darkviolet. 148. 0. 211.
		#deeppink. 255. 20. 147.
		#deepskyblue. 0. 191. 255.
		#dimgray. 105. 105. 105.
		#dimgrey. 105. 105. 105.
		#dodgerblue. 30. 144. 255.
		#firebrick. 178. 34. 34.
		#floralwhite. 255. 250. 240.
		#forestgreen. 34. 139. 34.
		#fuchsia. 255. 0. 255.
		#gainsboro. 220. 220. 220.
		#ghostwhite. 248. 248. 255.
		#gold. 255. 215. 0.
		#goldenrod. 218. 165. 32.
		#gray. 128. 128. 128.
		#grey. 128. 128. 128.
		#green. 0. 128. 0.
		#greenyellow. 173. 255. 47.
		#honeydew. 240. 255. 240.
		#hotpink. 255. 105. 180.
		#indianred. 205. 92. 92.
		#indigo. 75. 0. 130.
		#ivory. 255. 255. 240.
		#khaki. 240. 230. 140.
		#lavender. 230. 230. 250.
		#lavenderblush. 255. 240. 245.
		#lawngreen. 124. 252. 0.
		#lemonchiffon. 255. 250. 205.
		#lightblue. 173. 216. 230.
		#lightcoral. 240. 128. 128.
		#lightcyan. 224. 255. 255.
		#lightgoldenrodyellow. 250. 250. 210.
		#lightgray. 211. 211. 211.
		#lightgreen. 144. 238. 144.
		#lightgrey. 211. 211. 211.
		}
]

{ #category : #defaults }
BlSvgColor class >> svgColors2 [
	^{ #lightpink. 255. 182. 193.
		#lightsalmon. 255. 160. 122.
		#lightseagreen. 32. 178. 170.
		#lightskyblue. 135. 206. 250.
		#lightslategray. 119. 136. 153.
		#lightslategrey. 119. 136. 153.
		#lightsteelblue. 176. 196. 222.
		#lightyellow. 255. 255. 224.
		#lime. 0. 255. 0.
		#limegreen. 50. 205. 50.
		#linen. 250. 240. 230.
		#magenta. 255. 0. 255.
		#maroon. 128. 0. 0.
		#mediumaquamarine. 102. 205. 170.
		#mediumblue. 0. 0. 205.
		#mediumorchid. 186. 85. 211.
		#mediumpurple. 147. 112. 219.
		#mediumseagreen. 60. 179. 113.
		#mediumslateblue. 123. 104. 238.
		#mediumspringgreen. 0. 250. 154.
		#mediumturquoise. 72. 209. 204.
		#mediumvioletred. 199. 21. 133.
		#midnightblue. 25. 25. 112.
		#mintcream. 245. 255. 250.
		#mistyrose. 255. 228. 225.
		#moccasin. 255. 228. 181.
		#navajowhite. 255. 222. 173.
		#navy. 0. 0. 128.
		#oldlace. 253. 245. 230.
		#olive. 128. 128. 0.
		#olivedrab. 107. 142. 35.
		#orange. 255. 165. 0.
		#orangered. 255. 69. 0.
		#orchid. 218. 112. 214.
		#palegoldenrod. 238. 232. 170.
		#palegreen. 152. 251. 152.
		#paleturquoise. 175. 238. 238.
		#palevioletred. 219. 112. 147.
		#papayawhip. 255. 239. 213.
		#peachpuff. 255. 218. 185.
		#peru. 205. 133. 63.
		#pink. 255. 192. 203.
		#plum. 221. 160. 221.
		#powderblue. 176. 224. 230.
		#purple. 128. 0. 128.
		#red. 255. 0. 0.
		#rosybrown. 188. 143. 143.
		#royalblue. 65. 105. 225.
		#saddlebrown. 139. 69. 19.
		#salmon. 250. 128. 114.
		#sandybrown. 244. 164. 96.
		#seagreen. 46. 139. 87.
		#seashell. 255. 245. 238.
		#sienna. 160. 82. 45.
		#silver. 192. 192. 192.
		#skyblue. 135. 206. 235.
		#slateblue. 106. 90. 205.
		#slategray. 112. 128. 144.
		#slategrey. 112. 128. 144.
		#snow. 255. 250. 250.
		#springgreen. 0. 255. 127.
		#steelblue. 70. 130. 180.
		#tan. 210. 180. 140.
		#teal. 0. 128. 128.
		#thistle. 216. 191. 216.
		#tomato. 255. 99. 71.
		#turquoise. 64. 224. 208.
		#violet. 238. 130. 238.
		#wheat. 245. 222. 179.
		#white. 255. 255. 255.
		#whitesmoke. 245. 245. 245.
		#yellow. 255. 255. 0.
		#yellowgreen. 154. 205. 50.
		}
]

{ #category : #defaults }
BlSvgColor class >> tan [
	^ SVGColorRegistry at: #tan
]

{ #category : #defaults }
BlSvgColor class >> teal [
	^ SVGColorRegistry at: #teal
]

{ #category : #defaults }
BlSvgColor class >> thistle [
	^ SVGColorRegistry at: #thistle
]

{ #category : #defaults }
BlSvgColor class >> tomato [
	^ SVGColorRegistry at: #tomato
]

{ #category : #defaults }
BlSvgColor class >> transparent [
	^ SVGColorRegistry at: #transparent
]

{ #category : #defaults }
BlSvgColor class >> turquoise [
	^ SVGColorRegistry at: #turquoise
]

{ #category : #accessing }
BlSvgColor class >> unregisterColorNamed: aName [
	SVGColorRegistry removeKey: aName ifAbsent: nil
]

{ #category : #defaults }
BlSvgColor class >> violet [
	^ SVGColorRegistry at: #violet
]

{ #category : #defaults }
BlSvgColor class >> wheat [
	^ SVGColorRegistry at: #wheat
]

{ #category : #defaults }
BlSvgColor class >> white [
	^ SVGColorRegistry at: #white
]

{ #category : #defaults }
BlSvgColor class >> whitesmoke [
	^ SVGColorRegistry at: #whitesmoke
]

{ #category : #defaults }
BlSvgColor class >> yellow [
	^ SVGColorRegistry at: #yellow
]

{ #category : #defaults }
BlSvgColor class >> yellowgreen [
	^ SVGColorRegistry at: #yellowgreen
]
