examples - fling up
_2_flingUp500_flingUp500
	<gtExample>
	| aScrollPane theScrollPositions aScrollerY |
	
	aScrollPane := self _1_flingUp500_first205ms.
	
	aScrollPane flingBy: (0@500) negated.
	
	aScrollerY := aScrollPane scrollFlinger scroller scrollerY.
	
	self assert: (aScrollerY currentVelocity closeTo: -667).
	self assert: aScrollerY currentPosition equals: -65.
	self assert: aScrollerY currentStep equals: BlSplineOverScrollerStep spline.
	self assert: aScrollerY deceleration equals: 0.
	self assert: aScrollerY duration equals: 600 milliSeconds.
	self assert: aScrollerY finalPosition equals: -205.
	self assert: aScrollerY isFinished not.
	self assert: aScrollerY friction equals: 0.015.
	self assert: aScrollerY overshotDistance equals: 50.
	self assert: aScrollerY splineDistance equals: -140.
	self assert: aScrollerY splineDuration equals: 600 milliSeconds.
	self assert: aScrollerY startPosition equals: -65.
	self assert: aScrollerY startTime equals: self simulatedDate + 200 milliSeconds.
	self assert: aScrollerY startVelocity equals: -667.

	self assert: aScrollPane scrollState equals: #settling.
	self assert: aScrollPane scrollFlinger lastFlingPosition equals: 0@65 negated.
	
	theScrollPositions := OrderedCollection new.
	
	aScrollPane space time
		every: 5 milliSeconds
		during: 610 milliSeconds
		do: [
			aScrollPane space pulse.
			theScrollPositions add: aScrollPane scrollPosition y ].

	self assert: theScrollPositions asArray equals: {-65. -68. -72. -75. -78. -82. -85. -88. -91. -94. -97. -100. -103. -106. -109. -112. -115. -117. -120. -123. -125. -127. -130. -132. -134. -137. -139. -141. -143. -145. -147. -149. -150. -152. -154. -156. -157. -159. -160. -162. -163. -165. -166. -167. -169. -170. -171. -172. -174. -175. -176. -177. -178. -179. -180. -181. -182. -183. -183. -184. -185. -186. -187. -188. -188. -189. -190. -190. -191. -192. -192. -193. -193. -194. -194. -195. -195. -196. -196. -197. -197. -198. -198. -199. -199. -199. -200. -200. -200. -201. -201. -201. -202. -202. -202. -202. -202. -203. -203. -203. -203. -203. -204. -204. -204. -204. -204. -204. -204. -205. -205. -205. -205. -205. -205. -205. -205. -205. -205. -205. -205. -205}.

	^ aScrollPane