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
	#name : #SvgColor,
	#superclass : #Color,
	#classVars : [
		'SVGColorRegistry'
	],
	#category : 'Bloc-SVG-Element'
}

{ #category : #defaults }
SvgColor class >> aliceblue [
	^ SVGColorRegistry at: #aliceblue
]

{ #category : #defaults }
SvgColor class >> antiquewhite [
	^ SVGColorRegistry at: #antiquewhite
]

{ #category : #defaults }
SvgColor class >> aqua [
	^ SVGColorRegistry at: #aqua
]

{ #category : #defaults }
SvgColor class >> aquamarine [
	^ SVGColorRegistry at: #aquamarine
]

{ #category : #defaults }
SvgColor class >> azure [
	^ SVGColorRegistry at: #azure
]

{ #category : #defaults }
SvgColor class >> beige [
	^ SVGColorRegistry at: #beige
]

{ #category : #defaults }
SvgColor class >> bisque [
	^ SVGColorRegistry at: #bisque
]

{ #category : #defaults }
SvgColor class >> black [
	^ SVGColorRegistry at: #black
]

{ #category : #defaults }
SvgColor class >> blanchedalmond [
	^ SVGColorRegistry at: #blanchedalmond
]

{ #category : #defaults }
SvgColor class >> blue [
	^ SVGColorRegistry at: #blue
]

{ #category : #defaults }
SvgColor class >> blueviolet [
	^ SVGColorRegistry at: #blueviolet
]

{ #category : #defaults }
SvgColor class >> brown [
	^ SVGColorRegistry at: #brown
]

{ #category : #defaults }
SvgColor class >> burlywood [
	^ SVGColorRegistry at: #burlywood
]

{ #category : #defaults }
SvgColor class >> cadetblue [
	^ SVGColorRegistry at: #cadetblue
]

{ #category : #defaults }
SvgColor class >> chartreuse [
	^ SVGColorRegistry at: #chartreuse
]

{ #category : #defaults }
SvgColor class >> chocolate [
	^ SVGColorRegistry at: #chocolate
]

{ #category : #'initialize-release' }
SvgColor class >> compileMethodforColor: colorName [
	|stream|
	stream := WriteStream with: colorName.
	stream nextPut: Character cr;
		nextPutAll: '	^ SVGColorRegistry at: #';
		nextPutAll: colorName.
	
	self class compile: stream contents classified: 'defaults'.
]

{ #category : #defaults }
SvgColor class >> coral [
	^ SVGColorRegistry at: #coral
]

{ #category : #defaults }
SvgColor class >> cornflowerblue [
	^ SVGColorRegistry at: #cornflowerblue
]

{ #category : #defaults }
SvgColor class >> cornsilk [
	^ SVGColorRegistry at: #cornsilk
]

{ #category : #defaults }
SvgColor class >> crimson [
	^ SVGColorRegistry at: #crimson
]

{ #category : #defaults }
SvgColor class >> cyan [
	^ SVGColorRegistry at: #cyan
]

{ #category : #defaults }
SvgColor class >> darkblue [
	^ SVGColorRegistry at: #darkblue
]

{ #category : #defaults }
SvgColor class >> darkcyan [
	^ SVGColorRegistry at: #darkcyan
]

{ #category : #defaults }
SvgColor class >> darkgoldenrod [
	^ SVGColorRegistry at: #darkgoldenrod
]

{ #category : #defaults }
SvgColor class >> darkgray [
	^ SVGColorRegistry at: #darkgray
]

{ #category : #defaults }
SvgColor class >> darkgreen [
	^ SVGColorRegistry at: #darkgreen
]

{ #category : #defaults }
SvgColor class >> darkgrey [
	^ SVGColorRegistry at: #darkgrey
]

{ #category : #defaults }
SvgColor class >> darkkhaki [
	^ SVGColorRegistry at: #darkkhaki
]

{ #category : #defaults }
SvgColor class >> darkmagenta [
	^ SVGColorRegistry at: #darkmagenta
]

{ #category : #defaults }
SvgColor class >> darkolivegreen [
	^ SVGColorRegistry at: #darkolivegreen
]

{ #category : #defaults }
SvgColor class >> darkorange [
	^ SVGColorRegistry at: #darkorange
]

{ #category : #defaults }
SvgColor class >> darkorchid [
	^ SVGColorRegistry at: #darkorchid
]

{ #category : #defaults }
SvgColor class >> darkred [
	^ SVGColorRegistry at: #darkred
]

{ #category : #defaults }
SvgColor class >> darksalmon [
	^ SVGColorRegistry at: #darksalmon
]

{ #category : #defaults }
SvgColor class >> darkseagreen [
	^ SVGColorRegistry at: #darkseagreen
]

{ #category : #defaults }
SvgColor class >> darkslateblue [
	^ SVGColorRegistry at: #darkslateblue
]

{ #category : #defaults }
SvgColor class >> darkslategray [
	^ SVGColorRegistry at: #darkslategray
]

{ #category : #defaults }
SvgColor class >> darkslategrey [
	^ SVGColorRegistry at: #darkslategrey
]

{ #category : #defaults }
SvgColor class >> darkturquoise [
	^ SVGColorRegistry at: #darkturquoise
]

{ #category : #defaults }
SvgColor class >> darkviolet [
	^ SVGColorRegistry at: #darkviolet
]

{ #category : #defaults }
SvgColor class >> deeppink [
	^ SVGColorRegistry at: #deeppink
]

{ #category : #defaults }
SvgColor class >> deepskyblue [
	^ SVGColorRegistry at: #deepskyblue
]

{ #category : #defaults }
SvgColor class >> dimgray [
	^ SVGColorRegistry at: #dimgray
]

{ #category : #defaults }
SvgColor class >> dimgrey [
	^ SVGColorRegistry at: #dimgrey
]

{ #category : #defaults }
SvgColor class >> dodgerblue [
	^ SVGColorRegistry at: #dodgerblue
]

{ #category : #defaults }
SvgColor class >> firebrick [
	^ SVGColorRegistry at: #firebrick
]

{ #category : #defaults }
SvgColor class >> floralwhite [
	^ SVGColorRegistry at: #floralwhite
]

{ #category : #defaults }
SvgColor class >> forestgreen [
	^ SVGColorRegistry at: #forestgreen
]

{ #category : #'instance creation' }
SvgColor class >> fromHexString: aColorHex [
	|stream|
	stream := WriteStream on:''.
	aColorHex size = 3 ifTrue:[ aColorHex do: [:character | 2 timesRepeat: [stream nextPut:character] ]]
							ifFalse:[ stream nextPutAll: aColorHex ].
	
	^super fromHexString: stream contents.
]

{ #category : #'instance creation' }
SvgColor class >> fromRgbString: aString [
	|array|
	array := ( ((aString withoutPrefix: 'rgb(') withoutSuffix: ')') substrings: ',' ) collect: [:stringValue |
		(stringValue endsWith: '%') ifTrue: [(stringValue withoutSuffix: '%') asNumber * 255 / 100 ]
											ifFalse: [stringValue asNumber]].
	
	^self fromRgbTripletOnBase256: array
]

{ #category : #'instance creation' }
SvgColor class >> fromRgbTripletOnBase256: array [
	^ self r: (array first / 255) g: (array second / 255) b: (array last / 255)
]

{ #category : #'instance creation' }
SvgColor class >> fromString: aString [
	aString='none' ifTrue:[^self transparent].
	"If aString is following the format: 'rgb(R,G,B)' or 'rgb(R%,G%,B%)':"
	(aString beginsWith: 'rgb(') ifTrue:[^self fromRgbString: aString].
	"If aString is following the format: '#RRGGBB' or '#RGB':"
	(aString beginsWith: '#') ifTrue:[^self fromHexString: aString allButFirst].
	"If aString is a color keyword"
	^super fromString:aString
]

{ #category : #defaults }
SvgColor class >> fuchsia [
	^ SVGColorRegistry at: #fuchsia
]

{ #category : #defaults }
SvgColor class >> gainsboro [
	^ SVGColorRegistry at: #gainsboro
]

{ #category : #defaults }
SvgColor class >> ghostwhite [
	^ SVGColorRegistry at: #ghostwhite
]

{ #category : #defaults }
SvgColor class >> gold [
	^ SVGColorRegistry at: #gold
]

{ #category : #defaults }
SvgColor class >> goldenrod [
	^ SVGColorRegistry at: #goldenrod
]

{ #category : #defaults }
SvgColor class >> gray [
	^ SVGColorRegistry at: #gray
]

{ #category : #defaults }
SvgColor class >> green [
	^ SVGColorRegistry at: #green
]

{ #category : #defaults }
SvgColor class >> greenyellow [
	^ SVGColorRegistry at: #greenyellow
]

{ #category : #defaults }
SvgColor class >> grey [
	^ SVGColorRegistry at: #grey
]

{ #category : #defaults }
SvgColor class >> honeydew [
	^ SVGColorRegistry at: #honeydew
]

{ #category : #defaults }
SvgColor class >> hotpink [
	^ SVGColorRegistry at: #hotpink
]

{ #category : #defaults }
SvgColor class >> indianred [
	^ SVGColorRegistry at: #indianred
]

{ #category : #defaults }
SvgColor class >> indigo [
	^ SVGColorRegistry at: #indigo
]

{ #category : #'initialize-release' }
SvgColor class >> initialize [
	self initializeColorRegistry.
]

{ #category : #'initialize-release' }
SvgColor class >> initializeColorRegistry [
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
SvgColor class >> ivory [
	^ SVGColorRegistry at: #ivory
]

{ #category : #defaults }
SvgColor class >> khaki [
	^ SVGColorRegistry at: #khaki
]

{ #category : #defaults }
SvgColor class >> lavender [
	^ SVGColorRegistry at: #lavender
]

{ #category : #defaults }
SvgColor class >> lavenderblush [
	^ SVGColorRegistry at: #lavenderblush
]

{ #category : #defaults }
SvgColor class >> lawngreen [
	^ SVGColorRegistry at: #lawngreen
]

{ #category : #defaults }
SvgColor class >> lemonchiffon [
	^ SVGColorRegistry at: #lemonchiffon
]

{ #category : #defaults }
SvgColor class >> lightblue [
	^ SVGColorRegistry at: #lightblue
]

{ #category : #defaults }
SvgColor class >> lightcoral [
	^ SVGColorRegistry at: #lightcoral
]

{ #category : #defaults }
SvgColor class >> lightcyan [
	^ SVGColorRegistry at: #lightcyan
]

{ #category : #defaults }
SvgColor class >> lightgoldenrodyellow [
	^ SVGColorRegistry at: #lightgoldenrodyellow
]

{ #category : #defaults }
SvgColor class >> lightgray [
	^ SVGColorRegistry at: #lightgray
]

{ #category : #defaults }
SvgColor class >> lightgreen [
	^ SVGColorRegistry at: #lightgreen
]

{ #category : #defaults }
SvgColor class >> lightgrey [
	^ SVGColorRegistry at: #lightgrey
]

{ #category : #defaults }
SvgColor class >> lightpink [
	^ SVGColorRegistry at: #lightpink
]

{ #category : #defaults }
SvgColor class >> lightsalmon [
	^ SVGColorRegistry at: #lightsalmon
]

{ #category : #defaults }
SvgColor class >> lightseagreen [
	^ SVGColorRegistry at: #lightseagreen
]

{ #category : #defaults }
SvgColor class >> lightskyblue [
	^ SVGColorRegistry at: #lightskyblue
]

{ #category : #defaults }
SvgColor class >> lightslategray [
	^ SVGColorRegistry at: #lightslategray
]

{ #category : #defaults }
SvgColor class >> lightslategrey [
	^ SVGColorRegistry at: #lightslategrey
]

{ #category : #defaults }
SvgColor class >> lightsteelblue [
	^ SVGColorRegistry at: #lightsteelblue
]

{ #category : #defaults }
SvgColor class >> lightyellow [
	^ SVGColorRegistry at: #lightyellow
]

{ #category : #defaults }
SvgColor class >> lime [
	^ SVGColorRegistry at: #lime
]

{ #category : #defaults }
SvgColor class >> limegreen [
	^ SVGColorRegistry at: #limegreen
]

{ #category : #defaults }
SvgColor class >> linen [
	^ SVGColorRegistry at: #linen
]

{ #category : #defaults }
SvgColor class >> magenta [
	^ SVGColorRegistry at: #magenta
]

{ #category : #defaults }
SvgColor class >> maroon [
	^ SVGColorRegistry at: #maroon
]

{ #category : #defaults }
SvgColor class >> mediumaquamarine [
	^ SVGColorRegistry at: #mediumaquamarine
]

{ #category : #defaults }
SvgColor class >> mediumblue [
	^ SVGColorRegistry at: #mediumblue
]

{ #category : #defaults }
SvgColor class >> mediumorchid [
	^ SVGColorRegistry at: #mediumorchid
]

{ #category : #defaults }
SvgColor class >> mediumpurple [
	^ SVGColorRegistry at: #mediumpurple
]

{ #category : #defaults }
SvgColor class >> mediumseagreen [
	^ SVGColorRegistry at: #mediumseagreen
]

{ #category : #defaults }
SvgColor class >> mediumslateblue [
	^ SVGColorRegistry at: #mediumslateblue
]

{ #category : #defaults }
SvgColor class >> mediumspringgreen [
	^ SVGColorRegistry at: #mediumspringgreen
]

{ #category : #defaults }
SvgColor class >> mediumturquoise [
	^ SVGColorRegistry at: #mediumturquoise
]

{ #category : #defaults }
SvgColor class >> mediumvioletred [
	^ SVGColorRegistry at: #mediumvioletred
]

{ #category : #defaults }
SvgColor class >> midnightblue [
	^ SVGColorRegistry at: #midnightblue
]

{ #category : #defaults }
SvgColor class >> mintcream [
	^ SVGColorRegistry at: #mintcream
]

{ #category : #defaults }
SvgColor class >> mistyrose [
	^ SVGColorRegistry at: #mistyrose
]

{ #category : #defaults }
SvgColor class >> moccasin [
	^ SVGColorRegistry at: #moccasin
]

{ #category : #accessing }
SvgColor class >> named: aColorName [
	^ SVGColorRegistry  at: aColorName asSymbol ifAbsent: nil 
]

{ #category : #defaults }
SvgColor class >> navajowhite [
	^ SVGColorRegistry at: #navajowhite
]

{ #category : #defaults }
SvgColor class >> navy [
	^ SVGColorRegistry at: #navy
]

{ #category : #defaults }
SvgColor class >> oldlace [
	^ SVGColorRegistry at: #oldlace
]

{ #category : #defaults }
SvgColor class >> olive [
	^ SVGColorRegistry at: #olive
]

{ #category : #defaults }
SvgColor class >> olivedrab [
	^ SVGColorRegistry at: #olivedrab
]

{ #category : #defaults }
SvgColor class >> orange [
	^ SVGColorRegistry at: #orange
]

{ #category : #defaults }
SvgColor class >> orangered [
	^ SVGColorRegistry at: #orangered
]

{ #category : #defaults }
SvgColor class >> orchid [
	^ SVGColorRegistry at: #orchid
]

{ #category : #defaults }
SvgColor class >> palegoldenrod [
	^ SVGColorRegistry at: #palegoldenrod
]

{ #category : #defaults }
SvgColor class >> palegreen [
	^ SVGColorRegistry at: #palegreen
]

{ #category : #defaults }
SvgColor class >> paleturquoise [
	^ SVGColorRegistry at: #paleturquoise
]

{ #category : #defaults }
SvgColor class >> palevioletred [
	^ SVGColorRegistry at: #palevioletred
]

{ #category : #defaults }
SvgColor class >> papayawhip [
	^ SVGColorRegistry at: #papayawhip
]

{ #category : #defaults }
SvgColor class >> peachpuff [
	^ SVGColorRegistry at: #peachpuff
]

{ #category : #defaults }
SvgColor class >> peru [
	^ SVGColorRegistry at: #peru
]

{ #category : #defaults }
SvgColor class >> pink [
	^ SVGColorRegistry at: #pink
]

{ #category : #defaults }
SvgColor class >> plum [
	^ SVGColorRegistry at: #plum
]

{ #category : #defaults }
SvgColor class >> powderblue [
	^ SVGColorRegistry at: #powderblue
]

{ #category : #defaults }
SvgColor class >> purple [
	^ SVGColorRegistry at: #purple
]

{ #category : #defaults }
SvgColor class >> red [
	^ SVGColorRegistry at: #red
]

{ #category : #'initialize-release' }
SvgColor class >> registerColor: aColor named: aName [
	SVGColorRegistry at: aName put: aColor.
]

{ #category : #accessing }
SvgColor class >> registeredColorNames [
	^ SVGColorRegistry keys collect: #asString 
]

{ #category : #accessing }
SvgColor class >> registeredNameOf: aColor [ 
	| colorName |
	colorName := #unnamed.
	SVGColorRegistry keysAndValuesDo: [:key :value|  value = aColor ifTrue: [ colorName := key ] ].
	^ colorName 
]

{ #category : #defaults }
SvgColor class >> rosybrown [
	^ SVGColorRegistry at: #rosybrown
]

{ #category : #defaults }
SvgColor class >> royalblue [
	^ SVGColorRegistry at: #royalblue
]

{ #category : #defaults }
SvgColor class >> saddlebrown [
	^ SVGColorRegistry at: #saddlebrown
]

{ #category : #defaults }
SvgColor class >> salmon [
	^ SVGColorRegistry at: #salmon
]

{ #category : #defaults }
SvgColor class >> sandybrown [
	^ SVGColorRegistry at: #sandybrown
]

{ #category : #defaults }
SvgColor class >> seagreen [
	^ SVGColorRegistry at: #seagreen
]

{ #category : #defaults }
SvgColor class >> seashell [
	^ SVGColorRegistry at: #seashell
]

{ #category : #defaults }
SvgColor class >> sienna [
	^ SVGColorRegistry at: #sienna
]

{ #category : #defaults }
SvgColor class >> silver [
	^ SVGColorRegistry at: #silver
]

{ #category : #defaults }
SvgColor class >> skyblue [
	^ SVGColorRegistry at: #skyblue
]

{ #category : #defaults }
SvgColor class >> slateblue [
	^ SVGColorRegistry at: #slateblue
]

{ #category : #defaults }
SvgColor class >> slategray [
	^ SVGColorRegistry at: #slategray
]

{ #category : #defaults }
SvgColor class >> slategrey [
	^ SVGColorRegistry at: #slategrey
]

{ #category : #defaults }
SvgColor class >> snow [
	^ SVGColorRegistry at: #snow
]

{ #category : #defaults }
SvgColor class >> springgreen [
	^ SVGColorRegistry at: #springgreen
]

{ #category : #defaults }
SvgColor class >> steelblue [
	^ SVGColorRegistry at: #steelblue
]

{ #category : #defaults }
SvgColor class >> svgColors1 [
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
SvgColor class >> svgColors2 [
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
SvgColor class >> tan [
	^ SVGColorRegistry at: #tan
]

{ #category : #defaults }
SvgColor class >> teal [
	^ SVGColorRegistry at: #teal
]

{ #category : #defaults }
SvgColor class >> thistle [
	^ SVGColorRegistry at: #thistle
]

{ #category : #defaults }
SvgColor class >> tomato [
	^ SVGColorRegistry at: #tomato
]

{ #category : #defaults }
SvgColor class >> transparent [
	^ SVGColorRegistry at: #transparent
]

{ #category : #defaults }
SvgColor class >> turquoise [
	^ SVGColorRegistry at: #turquoise
]

{ #category : #accessing }
SvgColor class >> unregisterColorNamed: aName [
	SVGColorRegistry removeKey: aName ifAbsent: nil
]

{ #category : #defaults }
SvgColor class >> violet [
	^ SVGColorRegistry at: #violet
]

{ #category : #defaults }
SvgColor class >> wheat [
	^ SVGColorRegistry at: #wheat
]

{ #category : #defaults }
SvgColor class >> white [
	^ SVGColorRegistry at: #white
]

{ #category : #defaults }
SvgColor class >> whitesmoke [
	^ SVGColorRegistry at: #whitesmoke
]

{ #category : #defaults }
SvgColor class >> yellow [
	^ SVGColorRegistry at: #yellow
]

{ #category : #defaults }
SvgColor class >> yellowgreen [
	^ SVGColorRegistry at: #yellowgreen
]
