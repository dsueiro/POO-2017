!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'masch 5/8/2017 06:29:49'!
test01StackShouldBeEmptyWhenCreated

	| temp1 |

	temp1 _ OOStack new.
	self assert: temp1 isEmpty.! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'top'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'modifying' stamp: 'masch 5/8/2017 07:10:04'!
pop

	| anObject |

	anObject := top value.
	top := top next.

	^ anObject
		! !

!OOStack methodsFor: 'modifying' stamp: 'masch 5/8/2017 07:10:13'!
push: anObject
	
	top := OOStackNotEmptyNode new value: anObject withNext: top.! !


!OOStack methodsFor: 'initialization' stamp: 'masch 5/8/2017 07:08:08'!
initialize

	top := OOStackEmptyNode new.! !


!OOStack methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:09:36'!
isEmpty

	^ top isEmpty.! !

!OOStack methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:08:25'!
size

	^ top size.! !

!OOStack methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:08:57'!
top

	^ top value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackNode category: #'Stack-Exercise'!
Object subclass: #OOStackNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNode methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:05:40'!
isEmpty

	self subClassResponsability.! !

!OOStackNode methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:05:43'!
next

	self subClassResponsability.! !

!OOStackNode methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:05:48'!
size

	self subClassResponsability.! !


!OOStackNode methodsFor: 'evaluating' stamp: 'masch 5/8/2017 07:05:52'!
value

	self subClassResponsability.! !


!classDefinition: #OOStackEmptyNode category: #'Stack-Exercise'!
OOStackNode subclass: #OOStackEmptyNode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackEmptyNode methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:07:24'!
next

	self error: OOStack stackEmptyErrorDescription.! !

!OOStackEmptyNode methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:07:35'!
size

	^ 0.! !


!OOStackEmptyNode methodsFor: 'evaluating' stamp: 'masch 5/8/2017 07:07:45'!
value

	self error: OOStack stackEmptyErrorDescription.! !


!OOStackEmptyNode methodsFor: 'testing' stamp: 'masch 5/8/2017 07:07:15'!
isEmpty

	^ true.! !


!classDefinition: #OOStackNotEmptyNode category: #'Stack-Exercise'!
OOStackNode subclass: #OOStackNotEmptyNode
	instanceVariableNames: 'value next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackNotEmptyNode methodsFor: 'modifying' stamp: 'masch 5/8/2017 06:52:13'!
value: anObject withNext: aNextObject

	value := anObject.
	next := aNextObject.! !


!OOStackNotEmptyNode methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:04:56'!
isEmpty
	
	^ false.! !

!OOStackNotEmptyNode methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:05:05'!
next

	^ next.! !

!OOStackNotEmptyNode methodsFor: 'accessing' stamp: 'masch 5/8/2017 07:02:31'!
size

	^ 1 + next size.! !


!OOStackNotEmptyNode methodsFor: 'evaluating' stamp: 'masch 5/8/2017 07:05:17'!
value

	^ value.! !
