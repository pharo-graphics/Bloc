"
combination rules noted on Form class side: 

1: And ""Answer the integer denoting the logical 'and' combination rule.""
3: over ""Answer the integer denoting mode over.""
4: erase ""Answer the integer denoting mode erase.""
6: reverse 	""Answer the integer denoting mode reverse.""
7: under 	""Answer the integer denoting mode under.""
16: oldPaint ""Answer the integer denoting the 'paint' combination rule.""
17: oldErase1bitShape ""Answer the integer denoting mode erase.""

24: Blend ""Answer the integer denoting BitBlt's alpha blend combination rule.""
25: paint ""Answer the integer denoting the 'paint' combination rule.""
26: erase1bitShape 	""Answer the integer denoting mode erase.""
30: blendAlpha ""Answer the integer denoting BitBlt's blend-with-constant-alpha rule.""
31: paintAlpha 	""Answer the integer denoting BitBlt's paint-with-constant-alpha rule.""

--------------------------------------------------------------
The combination rule whose value is 0 through 15 programs the transfer to produce 1 or 0 according to its 4-bit representation as follows:
8:	if source is 0 and destination is 0
4:	if source is 0 and destination is 1
2:	if source is 1 and destination is 0
1:	if source is 1 and destination is 1.
At each pixel the corresponding bits of the source and destination pixel values determine one of these conditions;  
if the combination rule has a 1 in the corresponding bit position, then the new destination value will be 1, otherwise it will be zero.  
Forms may be of different depths, see the comment in class Form.

00: 0000 -> always return 0 (CR_clearWord)
01: 0001 -> source is 1 and destination is 1 => 1 (CR_bitAnd) - And ""Answer the integer denoting the logical 'and' combination rule.""
02: 0010 -> source is 1 and destination is 0 => 1 (CR_bitAndInvert)
03: 0011 -> source is 1 and dest is 0 or 1 (CR_sourceWord) - over ""Answer the integer denoting mode over.""
04: 0100 -> source is 0 and destination is 1 => 1 (CR_bitInvertAnd) - erase ""Answer the integer denoting mode erase.""
05: 0101 -> source is 0 or 1 and destination is 1 (CR_destinationWord)
06: 0110 -> source is 0 and destination is 1, or source is 1 and destination is 0 (CR_bitXor) - reverse 	""Answer the integer denoting mode reverse.""
07: 0111 -> source is 1, and destination is 0 or 1, or source is 0 and destination is 1 (CR_bitOr) - under 	""Answer the integer denoting mode under.""
08: 1000 -> source is 0 and destination is 0 => 1 (CR_bitInvertAndInvert)
09: 1001 -> source is 0 and destination is 0 or source is 1 and destination is 1 (CR_bitInvertXor)
10: 1010 -> source is 0 and destination is 0, or source is 1 and destination is 0 (CR_bitInvertDestination)
11: 1011 -> source is 0 and destination is 0, or source is 1 and destination is either 0 or 1 (CR_bitOrInvert)
12: 1100 -> source is 0 and destination is 0 or 1 (CR_bitInvertSource)
13: 1101 -> source is 0 and destination is 0 or 1, or source is 1 and destination is 1 (CR_bitInvertOr)
14: 1110 -> source is 0 and destination is 0 or 1, or source is 1 and destination is 0 (CR_bitInvertOrInvert)
15: 1111 -> always return destination color (CR_destinationWord_alt1)

In addition to the original 16 combination rules, this BitBlt supports
16:	 fails (to simulate paint bits) - (CR_destinationWord_alt2) - oldPaint ""Answer the integer denoting the 'paint' combination rule.""
17:	 fails (to simulate erase bits) - CR_destinationWord_alt3) - oldErase1bitShape ""Answer the integer denoting mode erase.""
18:	 sourceWord + destinationWord - (CR_addWord)
19:	 sourceWord - destinationWord - (CR_subWord)
20:	 rgbAdd: sourceWord with: destinationWord.  Sum of color components - (CR_rgbAdd)
21:	 rgbSub: sourceWord with: destinationWord.  Difference of color components - (CR_rgbSub)
22:	 OLDrgbDiff: sourceWord with: destinationWord.  Sum of abs of differences in components - (CR_OLDrgbDiff)
23:	 OLDtallyIntoMap: destinationWord.  Tallies pixValues into a colorMap. these old versions don't do bitwise dest clipping.  Use 32 and 33 now. - (CR_OLDtallyIntoMap)
24:	 alphaBlend: sourceWord with: destinationWord.  32-bit source and dest only - (CR_alphaBlend)
25:	 pixPaint: sourceWord with: destinationWord.  Wherever the sourceForm is non-zero, it replaces the destination.  Can be used with a 1-bit source color mapped to (0, FFFFFFFF), and a fillColor to fill the dest with that color wherever the source is 1. - (CR_pixPaint)
26:	 pixMask: sourceWord with: destinationWord.  Like pixPaint, but fills with 0. - (CR_pixMask)
27:	 rgbMax: sourceWord with: destinationWord.  Max of each color component. - (CR_rgbMax)
28:	 rgbMin: sourceWord with: destinationWord.  Min of each color component. - (CR_rgbMin)
29:	 rgbMin: sourceWord bitInvert32 with: destinationWord.  Min with (max-source) - (CR_rgbMinInvert)
30:	 alphaBlendConst: sourceWord with: destinationWord.  alpha is an arg. works in 16 bits. (CR_alphaBlendConst)
31: alphaPaintConst: sourceWord with: destinationWord.  alpha is an arg. works in 16 bits. (CR_alphaPaintConst)
32: rgbDiff: sourceWord with: destinationWord.  Sum of abs of differences in components (CR_rgbDiff)
33: tallyIntoMap: destinationWord.  Tallies pixValues into a colorMap (CR_tallyIntoMap)
34: alphaBlendScaled: srcWord with: dstWord. Alpha blend of scaled srcWord and destWord. (CR_alphaBlendScaled)
Blend sourceWord with destinationWord using the alpha value from sourceWord. Alpha is encoded as 0 meaning 0.0, and 255 meaning 1.0.
In contrast to alphaBlend:with: the color produced is srcColor + (1-srcAlpha) * dstColor. e.g., it is assumed that the source color is already scaled.

miss in documentation: 
35: CR_alphaBlendScaled_alt1
36: CR_alphaBlendScaled_alt2
37: CR_rgbMul -  Multiply RGB or RGBA components of the pixel
38: CR_pixSwap - Swap the pixels in destWord
39: CR_pixClear - Clear all pixels in destinationWord for which the pixels of sourceWord	have the same values. Used to clear areas of some constant color to zero.
40: CR_fixAlpha - For any non-zero pixel value in destinationWord with zero alpha channel take the alpha from sourceWord and fill it in. Intended for fixing alpha 	channels left at zero during 16->32 bpp conversions.
41: CR_rgbComponentAlpha
componentAlphaModeColor is the color, sourceWord contains an alpha value for each component of RGB, each of which is encoded as0 meaning 0.0 and 255 meaning 1.0 . the rule is...
	
	color = componentAlphaModeColor.
	colorAlpha = componentAlphaModeAlpha.
	mask = sourceWord.
	dst.A = colorAlpha + (1 - colorAlpha) * dst.A
	dst.R = color.R * mask.R * colorAlpha + (1 - (mask.R * colorAlpha)) *
	dst.R dst.G = color.G * mask.G * colorAlpha + (1 - (mask.G* colorAlpha)) *
	dst.G dst.B = color.B * mask.B * colorAlpha + (1 - (mask.B* colorAlpha)) *
	dst.B
	
enum combination_rule_t taken From BitBltDispatch.h source code:


"
Class {
	#name : #BitBltExperiment,
	#superclass : #Object,
	#category : #'BookletGraphicsBloc-bitblt'
}

{ #category : #tests }
BitBltExperiment >> test1 [

	<bookExample>
	| initForm destForm blt |
	initForm := (Form extent: 3 @ 3 depth: 32) initFromArray:
		            #( 16rffff0000 16rff000000 16rff0000ff 16rff000000
		               16rffffffff 16rff000000 16rff00ff00 16rff000000
		               16rffffff00 ). "red" "black" "blue" "black" "white" "black" "green" "black" "yello"

	destForm := Form extent: 3 @ 3 depth: 32.

	blt := BitBlt toForm: destForm.

	blt
		sourceForm: initForm;
		destOrigin: 0 @ 0;
		sourceOrigin: 0 @ 0;
		halftoneForm: nil;
		combinationRule: 18;
		width: initForm width;
		height: initForm height;
		copyBits.

	^ destForm magnifyBy: 15
]

{ #category : #tests }
BitBltExperiment >> test2 [
<bookExample>

|initForm destForm halfForm blt|

initForm := (Form extent: 3@3 depth: 32)
 initFromArray: #( 16rffff0000 "red" 	 16rff000000 "black" 16rff0000ff "blue"
						 16rff000000 "black" 16rffffffff "white" 16rff000000 "black" 
						 16rff00ff00 "green" 16rff000000 "black" 16rffffff00 "yello").
						
halfForm := (Form extent: 3@3 depth: 32)
 initFromArray: #( 16rffffff00 	 16rffffff00  16rffffff00
						 16rffffff00 16rffffff00 16rffffff00 
						 16rffffff00  16rffffff00 16rffffff00 ).
						
destForm := Form extent: 3@3 depth: 32.
						
blt := BitBlt toForm: destForm .

blt
		sourceForm: initForm;
		destOrigin: 0@0;
		sourceOrigin: 0@0;
		halftoneForm: halfForm;
		combinationRule: 18;
		width: initForm width;
		height: initForm height;
		copyBits .
		
^destForm magnifyBy: 15
]

{ #category : #tests }
BitBltExperiment >> testCombinationRule0To15 [
	<bookExample>
	| initForm destForm blt |
	initForm := (Form extent: 32 @ 1 depth: 1) initFromArray:
		            #( 2r10101010101010101010101010101010 ).

	destForm := (Form extent: 32 @ 16 depth: 1) initFromArray:
		            #( 2r10011001100110011001100110011001 "0: always return 0"
		               2r10011001100110011001100110011001 "1: source is 1 and destination is 1 - logical AND"
		               2r10011001100110011001100110011001 "2: source is 1 and destination is 0"
		               2r10011001100110011001100110011001 "3: source is 1 and dest is 0 or 1"
		               2r10011001100110011001100110011001 "4: source is 0 and destination is 1"
		               2r10011001100110011001100110011001 "5: source is 0 or 1 and destination is 1"
		               2r10011001100110011001100110011001 "6: source is 0 and destination is 1, or source is 1 and destination is 0"
		               2r10011001100110011001100110011001 "7: source is 1, and destination is 0 or 1, or source is 0 and destination is 1"
		               2r10011001100110011001100110011001 "8: source is 0 and destination is 0"
		               2r10011001100110011001100110011001 "9: source is 0 and destination is 0 or source is 1 and destination is 1"
		               2r10011001100110011001100110011001 "10: source is 0 and destination is 0, or source is 1 and destination is 0"
		               2r10011001100110011001100110011001 "11: source is 0 and destination is 0, or source is 1 and destination is either 0 or 1"
		               2r10011001100110011001100110011001 "12: source is 0 and destination is 0 or 1"
		               2r10011001100110011001100110011001 "13: source is 0 and destination is 0 or 1, or source is 1 and destination is 1"
		               2r10011001100110011001100110011001 "14: source is 0 and destination is 0 or 1, or source is 1 and destination is 0"
		               2r10011001100110011001100110011001 "15: source is 0 or 1, and destination is 0 or 1 -> always return destination color").

	blt := BitBlt toForm: destForm.
	0 to: 15 do: [ :i | 	blt
		sourceForm: initForm;
		destOrigin: 0 @ i;
		sourceOrigin: 0 @ 0;
		halftoneForm: nil;
		combinationRule: i;
		width: initForm width;
		height: initForm height;
		copyBits ].


	^ destForm magnifyBy: 15
]

{ #category : #tests }
BitBltExperiment >> testCombinationRule0To15v2 [
	<bookExample>
	| initForm destForm halfForm blt |
	initForm := (Form extent: 32 @ 1 depth: 1) initFromArray:
		            #( 2r10101010101010101010101010101010 ).

	destForm := Form extent: 32 @ 16 depth: 1.
	halfForm := (Form extent: 32 @ 16 depth: 1) initFromArray:
		            #( 2r10011001100110011001100110011001 "0: always return 0"
		               2r10011001100110011001100110011001 "1: source is 1 and destination is 1 - logical AND"
		               2r10011001100110011001100110011001 "2: source is 1 and destination is 0"
		               2r10011001100110011001100110011001 "3: source is 1 and dest is 0 or 1"
		               2r10011001100110011001100110011001 "4: source is 0 and destination is 1"
		               2r10011001100110011001100110011001 "5: source is 0 or 1 and destination is 1"
		               2r10011001100110011001100110011001 "6: source is 0 and destination is 1, or source is 1 and destination is 0"
		               2r10011001100110011001100110011001 "7: source is 1, and destination is 0 or 1, or source is 0 and destination is 1"
		               2r10011001100110011001100110011001 "8: source is 0 and destination is 0"
		               2r10011001100110011001100110011001 "9: source is 0 and destination is 0 or source is 1 and destination is 1"
		               2r10011001100110011001100110011001 "10: source is 0 and destination is 0, or source is 1 and destination is 0"
		               2r10011001100110011001100110011001 "11: source is 0 and destination is 0, or source is 1 and destination is either 0 or 1"
		               2r10011001100110011001100110011001 "12: source is 0 and destination is 0 or 1"
		               2r10011001100110011001100110011001 "13: source is 0 and destination is 0 or 1, or source is 1 and destination is 1"
		               2r10011001100110011001100110011001 "14: source is 0 and destination is 0 or 1, or source is 1 and destination is 0"
		               2r10011001100110011001100110011001 "15: source is 0 or 1, and destination is 0 or 1 -> always return destination color").

	blt := BitBlt toForm: destForm.
	0 to: 15 do: [ :i | 	blt
		sourceForm: initForm;
		destOrigin: 0 @ i;
		sourceOrigin: 0 @ 0;
		halftoneForm: halfForm;
		combinationRule: i;
		width: initForm width;
		height: initForm height;
		copyBits ].


	^ destForm magnifyBy: 15
]
