!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'DHS 6/10/2017 19:44:58'!
test01ANewCartIsEmpty
	| cart |
	cart := Cart new.
	
	self assert: cart empty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/11/2017 21:58:54'!
test02AfterAddingABookACartIsNotEmpty
	| cart cartItem book |
	cart := Cart new.
	
	book := Book new.
	
	cartItem := CartItem withBook: book withQuantity: 1.
	
	cart add: cartItem.
	
	self deny: cart empty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/11/2017 22:00:10'!
test03AfterAddingABookTheCartContainsIt
	| cart cartItem book |
	cart := Cart new.
	
	book := Book new.
	
	cartItem := CartItem withBook: book withQuantity: 1.
	
	cart add: cartItem.
	
	self assert: (cart includes: cartItem).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/11/2017 22:00:58'!
test04BeforeAddingABookTheCartDoesNotContainsIt
	| cart cartItem book |
	cart := Cart new.
	
	book := Book new.
	
	cartItem := CartItem withBook: book withQuantity: 1.
	
	self deny: (cart includes: cartItem).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/11/2017 22:26:48'!
test05CannotAddABookWithQuantityLessThanOne
	| cart book |
	cart := Cart new.
	
	book := Book new.
	
	self should: [cart add: (CartItem withBook: book withQuantity: 0)]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add quantity less than one']
	
	! !


!classDefinition: #Book category: #TusLibros!
Object subclass: #Book
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'inspecting' stamp: 'DHS 6/10/2017 19:59:48'!
empty
	^content isEmpty! !

!Cart methodsFor: 'inspecting' stamp: 'DHS 6/10/2017 19:57:11'!
initialize
	content := Bag new! !


!Cart methodsFor: 'adding' stamp: 'masch 6/11/2017 22:28:37'!
add: aCartItem
	content add: aCartItem! !


!Cart methodsFor: 'evaluating' stamp: 'masch 6/11/2017 22:28:20'!
includes: aCartItem
	^content includes: aCartItem! !


!classDefinition: #CartItem category: #TusLibros!
Object subclass: #CartItem
	instanceVariableNames: 'book quantity'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartItem methodsFor: 'modifying' stamp: 'masch 6/11/2017 21:57:45'!
book: aBook 
	book := aBook! !

!CartItem methodsFor: 'modifying' stamp: 'masch 6/11/2017 21:58:17'!
quantity: aQuantity 
	quantity := aQuantity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartItem class' category: #TusLibros!
CartItem class
	instanceVariableNames: ''!

!CartItem class methodsFor: 'instance creation' stamp: 'masch 6/11/2017 22:32:59'!
withBook: aBook withQuantity: aQuantity
	
	(aQuantity < 1) ifTrue: [self error: 'Cannot add quantity less than one'].
	
	^self new book: aBook; quantity: aQuantity; yourself! !
