!classDefinition: #TusLibrosTest category: #TusLibros!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'book1 cartWithOneBook1 emptyCatalog catalogWithOneBook emptyCartWithCatalogWithOneBook emptyCartWithEmptyCatalog priceListWithThreeItems cartWithFiveOneBooks book2 catalogWithMultipleBooks cartWithMultipleBooks salesBook merchantProcessor storeTestFactory merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator expiredCard validCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:44:06'!
setUp
	storeTestFactory _ StoreTestFactory new.
	
	salesBook _ storeTestFactory createSalesBook.
	
	emptyCatalog := Set new.
	emptyCartWithEmptyCatalog := Cart with: emptyCatalog.
	
	book1 := 'Un libro'.
	book2 := 'Dos libro'.

	catalogWithOneBook := Set new.
	catalogWithOneBook add: book1.

	catalogWithMultipleBooks := Set new.
	catalogWithMultipleBooks add: book1.
	catalogWithMultipleBooks add: book2.

	emptyCartWithCatalogWithOneBook := Cart with: catalogWithOneBook.
	
	cartWithOneBook1 := Cart with: catalogWithOneBook.
	cartWithOneBook1 add: book1.
	
	priceListWithThreeItems := storeTestFactory createPriceListWithThreeItems.
	
	cartWithFiveOneBooks := Cart with: catalogWithOneBook.
	cartWithFiveOneBooks add: book1 withAmount: 5.
	
	cartWithMultipleBooks := Cart with: catalogWithMultipleBooks.
	cartWithMultipleBooks add: book1 withAmount: 3.
	cartWithMultipleBooks add: book2 withAmount: 4.

	validCard := CreditCard withName: 'Juan Perez' withNumber: 1000000000000000 withExpirationDate: Date tomorrow.
	expiredCard := CreditCard withName: 'Juan Perez' withNumber: 1000000000000000 withExpirationDate: Date yesterday.
	
	merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator := storeTestFactory createMerchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator
! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:13:22'!
testCannotCreateACreditCardWithAnEmptyName
	self should: [CreditCard withName: '' 
		                                   withNumber: 12345 
		                                   withExpirationDate: (Date newDay: 01 month: 05 year: 2012)]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'Name cannot be empty'].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:13:42'!
testCannotCreateACreditCardWithAPositiveNumberLessThanSixteenLength
	self should: [CreditCard withName: 'Juan Perez' 
		                                   withNumber: 999999999999999 
		                                   withExpirationDate: (Date newDay: 01 month: 05 year: 2012)]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'Number must have at least 16 numbers'].! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/24/2017 19:14:06'!
testACreditCardWithAnExpirationDateLessThanADayIsExpired
	|creditCard|
	
	creditCard := CreditCard withName: 'Juan Perez' 
	                                         withNumber: 1000000000000000 
	                                         withExpirationDate: (Date newDay: 01 month: 05 year: 2012).
	
	self assert: (creditCard isExpiredOn: (Date newDay: 12 month: 5 year: 2012)).	
	self assert: (creditCard isExpiredOn: (Date newDay: 12 month: 8 year: 2012)).
	self assert: (creditCard isExpiredOn: (Date newDay: 1 month: 1 year: 2017)).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:28:13'!
testCannotCreateACashierWithACreditcardExpired
	self should: [Cashier withPriceList: priceListWithThreeItems 
		                             withCart: cartWithFiveOneBooks 
		                             withCreditCard: expiredCard 
		                             withPaymentTimestamp: DateAndTime now
		                             withSalesBook: salesBook
		                             withMerchantProcessor: merchantProcessor]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Expired credit card'.]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:26:21'!
testACashierCannotDoCheckoutWithAStolenCreditCard
	|cashier merchantProcessor| 
	
	merchantProcessor := MerchantProcessorSimulator withIsStolenCard: true withCreditAmount: 500.
	
	cashier := Cashier withPriceList: priceListWithThreeItems 
	                              withCart: cartWithFiveOneBooks 
	                              withCreditCard: validCard 
	                              withPaymentTimestamp: DateAndTime now
	                              withSalesBook: salesBook
	                              withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkout] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'The credit card was stolen'.
		self assert: cashier salesBook isEmpty.
		self deny: merchantProcessor merchantProcessorWasCalled]
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'PEP 6/26/2017 00:26:25'!
testACashierCannotDoCheckoutWithACreditCardWithoutEnoughCredit
	|cashier merchantProcessor| 
	
	merchantProcessor := MerchantProcessorSimulator withIsStolenCard: false withCreditAmount: 2.
	
	cashier := Cashier withPriceList: priceListWithThreeItems
	                              withCart: cartWithFiveOneBooks 
	                              withCreditCard: validCard 
	                              withPaymentTimestamp: DateAndTime now
	                              withSalesBook: salesBook
	                              withMerchantProcessor: merchantProcessor.
	
	self should: [cashier checkout] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: 'The credit card does not have enough credit'.
		self assert: cashier salesBook isEmpty.
		self deny: merchantProcessor merchantProcessorWasCalled]
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:10:06'!
testCreateACartWithAValidUser
	|store cartId|
	
	store _ storeTestFactory createAStore.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	
	self assert: (store listCartWith: cartId) isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:09:46'!
testCreateACartWithAInvalidUserClientId
	|store|
	
	store _ storeTestFactory createAStore.
	
	self should: [store createCartFor: 'clientId' authenticatedWith: 'password']
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: anError messageText equals: 'Client id is invalid']! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:10:13'!
testCreateACartWithAInvalidUserPassword
	|store|
	
	store _ storeTestFactory createAStore.
	
	self should: [store createCartFor: 'clientId1' authenticatedWith: 'password']
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError | 
		self assert: anError messageText equals: 'Client id is invalid']! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:10:09'!
testAddingABookFromTheStoreToCartTheCartShouldIncludeIt
	|store cartId cartOrder |
	
	store _ storeTestFactory createAStore.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 5.

	cartOrder _ (store listCartWith: cartId).
	self deny: cartOrder isEmpty.
	self assert: (cartOrder content includes: 'Un libro').
	self assert: 5 equals: (cartOrder content occurrencesOf: 'Un libro').
	self assert: store salesBook isEmpty! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:10:01'!
testAddingANonExtingBookInStoreShouldNotBeAddedToCart
	|store cartId |
	
	store _ storeTestFactory createAStore.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	
	self should: [store addToCartWith: cartId withBookISBN: 'Un libro2' withBookAmount: 1] 
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: 'Cannot add a book outside the catalog'.
		self assert: (store listCartWith: cartId) isEmpty.
		self assert: store salesBook isEmpty]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:10:16'!
testStoreCanDoCheckoutWithValidCardAnOneBookAddedToCart
	|store cartId |
	
	store _ storeTestFactory createAStore.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.
	
	store checkoutWith: cartId withCreditCard: validCard.
 	self deny: store salesBook isEmpty! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:09:58'!
testStoreCannotDoCheckoutWithExpiredCard
	|store cartId |
	
	store _ storeTestFactory createAStore.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.
	
	self should: [store checkoutWith: cartId withCreditCard: expiredCard.]
	raise: Error - MessageNotUnderstood 
 	withExceptionDo: [:anError |
		self assert: anError messageText equals: 'Expired credit card'.]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:12:00'!
testStoreCannotAddToCartWithACartOrderCreatedAfterTimeoutExceeded
	|store cartId dateTimeSimulator |
	
	dateTimeSimulator _ storeTestFactory createDateTimeSimulator.
	store _ storeTestFactory createAStoreWithDateTime: dateTimeSimulator.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.

	dateTimeSimulator advanceDurationToDateTimeNow: storeTestFactory cartOrderValidDuration.
	
	self should: [store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.]
	raise: Error - MessageNotUnderstood 
 	withExceptionDo: [:anError |
		self assert: anError messageText equals: 'The cart order is expired'.]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:11:56'!
testStoreCannotDoCheckoutWithACartOrderCreatedAfterTimeoutExceeded
	|store cartId dateTimeSimulator |
	
	dateTimeSimulator _ storeTestFactory createDateTimeSimulator.
	store _ storeTestFactory createAStoreWithDateTime: dateTimeSimulator.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.
	
	dateTimeSimulator advanceDurationToDateTimeNow: storeTestFactory cartOrderValidDuration.
	
	self should: [store checkoutWith: cartId withCreditCard: validCard.]
	raise: Error - MessageNotUnderstood 
 	withExceptionDo: [:anError |
		self assert: anError messageText equals: 'The cart order is expired'.]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:12:03'!
testStoreCannotListCartACartOrderCreatedAfterTimeoutExceeded
	|store cartId dateTimeSimulator |
	
	dateTimeSimulator _ storeTestFactory createDateTimeSimulator.
	store _ storeTestFactory createAStoreWithDateTime: dateTimeSimulator.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.
		
	dateTimeSimulator advanceDurationToDateTimeNow: storeTestFactory cartOrderValidDuration.
	
	self should: [store listCartWith: cartId.]
	raise: Error - MessageNotUnderstood 
 	withExceptionDo: [:anError |
		self assert: anError messageText equals: 'The cart order is expired'.]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:12:06'!
testListCartOrderItemsFromAValidOrder
	|store cartId dateTimeSimulator cartOrderItems |
	
	dateTimeSimulator _ storeTestFactory createDateTimeSimulator.
	store _ storeTestFactory createAStoreWithDateTime: dateTimeSimulator.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.

	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.

	cartOrderItems _ store listCartWith: cartId.
	self deny: cartOrderItems isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:11:47'!
testCannotListPurchasesFromANonExistingClientId
	|store dateTimeSimulator |
	
	dateTimeSimulator _ storeTestFactory createDateTimeSimulator.
	store _ storeTestFactory createAStoreWithDateTime: dateTimeSimulator.
	store createCartFor: 'clientId1' authenticatedWith: 'password1'.

	self should: [store listPurchacesFor: 'clientId12' authenticatedWith: 'password1'.] 
	raise: Error -	MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: 'Client id is invalid']! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:12:19'!
testCannotListPurchasesFromAUserPasswordInvalidForAnExistingClientId
	|store dateTimeSimulator |
	
	dateTimeSimulator _ storeTestFactory createDateTimeSimulator.
	store _ storeTestFactory createAStoreWithDateTime: dateTimeSimulator.
	store createCartFor: 'clientId1' authenticatedWith: 'password1'.

	self should: [store listPurchacesFor: 'clientId1' authenticatedWith: 'password2'.] 
	raise: Error -	MessageNotUnderstood 
	withExceptionDo: [:anError |
		self assert: anError messageText equals: 'Client id is invalid']! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:12:16'!
testListPurchacesFromAnExistingUser
	|store cartId dateTimeSimulator cartOrder |
	
	dateTimeSimulator _ storeTestFactory createDateTimeSimulator.
	store _ storeTestFactory createAStoreWithDateTime: dateTimeSimulator.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.

	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.
	store checkoutWith: cartId withCreditCard: validCard.

	cartOrder _ store listPurchacesFor: 'clientId1' authenticatedWith: 'password1'.
	self deny: cartOrder isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:12:10'!
testStoreCannotAddToCartWithACartOrderAccededAfterTimeoutExceeded
	|store cartId dateTimeSimulator |
	
	dateTimeSimulator _ storeTestFactory createDateTimeSimulator.
	store _ storeTestFactory createAStoreWithDateTime: dateTimeSimulator.
	cartId _ store createCartFor: 'clientId1' authenticatedWith: 'password1'.

	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.
	
	dateTimeSimulator advanceDurationToDateTimeNow: (Duration minutes: 26).
	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.
	
	dateTimeSimulator advanceDurationToDateTimeNow: (Duration minutes: 16).
	store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.

	dateTimeSimulator advanceDurationToDateTimeNow: storeTestFactory cartOrderValidDuration.
	
	self should: [store addToCartWith: cartId withBookISBN: 'Un libro' withBookAmount: 1.]
	raise: Error - MessageNotUnderstood 
 	withExceptionDo: [:anError |
		self assert: anError messageText equals: 'The cart order is expired'.]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:51:15'!
testACashierDoCheckoutWithACartWithMultipleBooks
	|cashier| 
	
	cashier := Cashier withPriceList: priceListWithThreeItems 
	                              withCart: cartWithMultipleBooks 
	                              withCreditCard:  validCard 
	                              withPaymentTimestamp: DateAndTime now
	                              withSalesBook: salesBook
	                              withMerchantProcessor: merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator.
	
	self assert: 11 equals: (cashier checkout).
	self deny: cashier salesBook isEmpty.
	self assert: merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator merchantProcessorWasCalled.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:51:09'!
testACashierDoCheckoutWithAnCartWithFiveOneBook
	|cashier| 
	
	cashier := Cashier withPriceList: priceListWithThreeItems 
	                              withCart: cartWithFiveOneBooks 
	                              withCreditCard: validCard 
		                         withPaymentTimestamp: DateAndTime now
	                              withSalesBook: salesBook
						    withMerchantProcessor: merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator.
	
	self assert: 5 equals: (cashier checkout).
	self deny: cashier salesBook isEmpty.
	self assert: merchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator merchantProcessorWasCalled.
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:49:20'!
testANewCartIsEmpty
	self assert: emptyCartWithEmptyCatalog isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:49:42'!
testAfterAddingABookACartIsNotEmpty
	emptyCartWithCatalogWithOneBook add: book1.
	self deny: emptyCartWithCatalogWithOneBook isEmpty.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:49:56'!
testAfterAddingABookTheCartContainsOneBook1
	self assert: (cartWithOneBook1 includes: book1).
	self assert: (cartWithOneBook1 quantityOf: book1) equals: 1! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:50:03'!
testBeforeAddingABookTheCartDoesNotContainsIt
	self deny: (emptyCartWithEmptyCatalog includes: book1).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:50:56'!
testCannotAddABookThatIsNotFromTheCatalog
	self should: [emptyCartWithEmptyCatalog add: book1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add a book outside the catalog'.
		self assert: emptyCartWithEmptyCatalog isEmpty]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:50:51'!
testCannotAddABookWithANonIntegerQuantity
	self should: [emptyCartWithCatalogWithOneBook add: book1 withAmount: 1.1]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add a non integer quantity'.
		self assert: emptyCartWithCatalogWithOneBook isEmpty]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:50:12'!
testCannotAddABookWithQuantityLessThanOne
	self should: [emptyCartWithCatalogWithOneBook add: book1 withAmount: 0]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot add quantity less than one'.
		self assert: emptyCartWithCatalogWithOneBook isEmpty]
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'masch 6/27/2017 08:51:02'!
testCannotCreateACashierWithAnEmptyCart	
	self should: [Cashier withPriceList: priceListWithThreeItems 
		                             withCart: emptyCartWithCatalogWithOneBook 
		                             withCreditCard: validCard 
		                             withPaymentTimestamp: DateAndTime now
		                             withSalesBook: salesBook
		                             withMerchantProcessor: merchantProcessor]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [ :anError |
		self assert: anError messageText equals: 'Cannot create a cashier with an empty cart']
	
	! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'content catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'inspecting' stamp: 'PEP 6/12/2017 22:15:34'!
isEmpty
	^content isEmpty! !


!Cart methodsFor: 'adding' stamp: 'DHS 6/13/2017 21:00:47'!
add: aCartItem
	self add: aCartItem withAmount: 1! !

!Cart methodsFor: 'adding' stamp: 'masch 6/14/2017 07:10:45'!
add: aBook withAmount: aQuantity 
	self validateQuantity: aQuantity.
	self validateCatalog: aBook.
	content add: aBook withOccurrences: aQuantity.
	^aBook! !


!Cart methodsFor: 'evaluating' stamp: 'PEP 6/13/2017 00:04:43'!
includes: aBook
	^content includes: aBook! !

!Cart methodsFor: 'evaluating' stamp: 'masch 6/25/2017 17:30:57'!
occurrencesOf: aBookISBN
	^content occurrencesOf: aBookISBN ! !

!Cart methodsFor: 'evaluating' stamp: 'masch 6/14/2017 07:09:56'!
quantityOf: aBook 
	^content occurrencesOf: aBook! !


!Cart methodsFor: 'initializing' stamp: 'masch 6/27/2017 08:18:29'!
initialize
	content := Bag new! !


!Cart methodsFor: 'validating' stamp: 'masch 6/14/2017 07:11:37'!
validateCatalog: aBook
	(catalog includes: aBook) ifFalse: [self error: 'Cannot add a book outside the catalog'].! !

!Cart methodsFor: 'validating' stamp: 'masch 6/14/2017 07:08:42'!
validateQuantity: aQuantity.
	aQuantity strictlyPositive ifFalse: [self error: 'Cannot add quantity less than one'].
	aQuantity isInteger ifFalse: [self error: 'Cannot add a non integer quantity'].! !


!Cart methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:18:18'!
catalog: aCatalog
	catalog := aCatalog.! !

!Cart methodsFor: 'accessing' stamp: 'masch 6/21/2017 07:01:11'!
content
	^content! !

!Cart methodsFor: 'accessing' stamp: 'PEP 6/25/2017 14:35:28'!
totalPrice: aPricesList 
	|totalPrice|
		
	totalPrice := 0.
	content asSet do: [ :contentItem |
		totalPrice := (aPricesList at: contentItem) * (content occurrencesOf: contentItem) + totalPrice].
	
	^totalPrice.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'masch 6/21/2017 06:03:56'!
with: aCatalog
	^self new catalog: aCatalog; yourself ! !


!classDefinition: #CartOrder category: #TusLibros!
Object subclass: #CartOrder
	instanceVariableNames: 'id content creationTimeStamp clientId lastAccededTimeStamp datime timeoutDuration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartOrder methodsFor: 'evaluating' stamp: 'masch 6/27/2017 08:17:00'!
isExpired
	^(datime now substractDateAndtime: lastAccededTimeStamp) > timeoutDuration! !


!CartOrder methodsFor: 'adding' stamp: 'masch 6/25/2017 16:43:18'!
add: anISBN
	content add: anISBN! !

!CartOrder methodsFor: 'adding' stamp: 'masch 6/27/2017 07:37:33'!
add: anISBN withAmount: anAmount
	content add: anISBN withAmount: anAmount.! !


!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:14:12'!
clientId
	^clientId! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:14:37'!
clientId: aClientId
	clientId _ aClientId ! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:14:53'!
content
	^content ! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:14:45'!
content: aContent 
	content _ aContent! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:15:00'!
creationTimeStamp
	^creationTimeStamp ! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:15:07'!
creationTimeStamp: aTimeStamp 
	creationTimeStamp _ aTimeStamp ! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:15:15'!
dateTime: aDateTime 
	datime _ aDateTime! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:15:33'!
id  
	^id! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:15:23'!
id: anId 
	id _ anId! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:16:13'!
isEmpty
	^content isEmpty! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:15:40'!
lastAccededTimeStamp
	^lastAccededTimeStamp ! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:15:57'!
lastAccededTimeStamp: aTimeStamp
	lastAccededTimeStamp _ aTimeStamp ! !

!CartOrder methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:15:47'!
timeoutDuration: aDuration 
	timeoutDuration _ aDuration ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartOrder class' category: #TusLibros!
CartOrder class
	instanceVariableNames: ''!

!CartOrder class methodsFor: 'instance creation' stamp: 'masch 6/27/2017 07:53:19'!
withId: anId withCart: aCart withOwner: aClientId withDateTime: aDateTime withTimeOutDuration: aTimeOutDuration
	^self new id: anId; content: aCart; creationTimeStamp: aDateTime now; lastAccededTimeStamp: aDateTime now; clientId: aClientId;  dateTime: aDateTime; timeoutDuration: aTimeOutDuration; yourself! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'priceList cart salesBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'executing' stamp: 'masch 6/27/2017 08:21:18'!
checkout
	|salePrice|
	
	salePrice := cart totalPrice: priceList.
	merchantProcessor debitFrom: cart withAmount: salePrice.
		
	salesBook addSale: salePrice.
	^salePrice! !


!Cashier methodsFor: 'accessing' stamp: 'masch 6/24/2017 18:18:28'!
cart: aCart 
	cart := aCart ! !

!Cashier methodsFor: 'accessing' stamp: 'masch 6/25/2017 07:23:28'!
merchantProcessor: aMerchantProcessor 
	merchantProcessor := aMerchantProcessor ! !

!Cashier methodsFor: 'accessing' stamp: 'masch 6/21/2017 06:24:57'!
priceList: aPriceList
	priceList := aPriceList ! !

!Cashier methodsFor: 'accessing' stamp: 'masch 6/24/2017 19:08:58'!
salesBook
	^salesBook.! !

!Cashier methodsFor: 'accessing' stamp: 'masch 6/24/2017 19:05:25'!
salesBook: aSalesBook
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'instance creation' stamp: 'masch 6/27/2017 08:38:40'!
withPriceList: aPriceList withCart: aCart withCreditCard: aCreditCard withPaymentTimestamp: aPaymentTimestamp withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor

	self validateCart: aCart.
	self validateCardOn: aCreditCard withPaymentDay: aPaymentTimestamp date.

	^ self new priceList: aPriceList; cart: aCart; salesBook: aSalesBook; merchantProcessor: aMerchantProcessor; yourself! !


!Cashier class methodsFor: 'validating' stamp: 'PEP 6/26/2017 00:21:57'!
validateCardOn: aCreditCard withPaymentDay: aPaymentDay 
	(aCreditCard isExpiredOn: aPaymentDay) ifTrue: [self error: 'Expired credit card'].! !

!Cashier class methodsFor: 'validating' stamp: 'masch 6/24/2017 18:25:48'!
validateCart: aCart 
	(aCart isEmpty) ifTrue: [self error: 'Cannot create a cashier with an empty cart'].! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'name number expirationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'evaluating' stamp: 'masch 6/27/2017 08:21:54'!
isExpiredOn: aDateFrom 
	^expirationDate < aDateFrom! !


!CreditCard methodsFor: 'accessing' stamp: 'masch 6/24/2017 15:36:47'!
expirationDate: anExpirationDate 
	expirationDate := anExpirationDate! !

!CreditCard methodsFor: 'accessing' stamp: 'masch 6/24/2017 15:28:40'!
name: aName 
	name := aName ! !

!CreditCard methodsFor: 'accessing' stamp: 'masch 6/24/2017 15:32:29'!
number: aNumber 
	number := aNumber! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'validating' stamp: 'masch 6/24/2017 16:20:16'!
validateName: aName
	(aName isEmpty) ifTrue: [ self error: 'Name cannot be empty'].! !

!CreditCard class methodsFor: 'validating' stamp: 'masch 6/24/2017 16:29:24'!
validateNumber: aNumber 
	(aNumber < 1000000000000000) ifTrue: [self error: 'Number must have at least 16 numbers'].! !


!CreditCard class methodsFor: 'instance creation' stamp: 'masch 6/27/2017 08:40:55'!
withName: aName withNumber: aNumber withExpirationDate: aExpirationDate
	self validateName: aName.
	self validateNumber: aNumber.
	
	^self new name: aName; number: aNumber; expirationDate: aExpirationDate; yourself! !


!classDefinition: #DateTime category: #TusLibros!
Object subclass: #DateTime
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!DateTime methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:23:45'!
now
	self shouldBeImplemented ! !


!classDefinition: #DateTimeSimulator category: #TusLibros!
DateTime subclass: #DateTimeSimulator
	instanceVariableNames: 'dateTimeNow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!DateTimeSimulator methodsFor: 'initializing' stamp: 'masch 6/27/2017 08:25:34'!
initialize
	dateTimeNow _ DateAndTime now.! !


!DateTimeSimulator methodsFor: 'accessing' stamp: 'masch 6/27/2017 06:13:43'!
advanceDurationToDateTimeNow: aDuration
	dateTimeNow _ dateTimeNow substractDuration: aDuration negated.
! !

!DateTimeSimulator methodsFor: 'accessing' stamp: 'masch 6/26/2017 06:49:35'!
now
	^dateTimeNow! !

!DateTimeSimulator methodsFor: 'accessing' stamp: 'masch 6/26/2017 06:50:51'!
now: aDateAndTime
	dateTimeNow _ aDateAndTime ! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'external' stamp: 'masch 6/25/2017 08:54:31'!
debitFrom: aCart withAmount: anAmount
	self shouldBeImplemented ! !

!MerchantProcessor methodsFor: 'external' stamp: 'masch 6/25/2017 09:09:31'!
numberCallsToMerchantProcessor
	self shouldBeImplemented! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
MerchantProcessor subclass: #MerchantProcessorSimulator
	instanceVariableNames: 'isStolenCard creditAmount numberCallsToMerchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'simulating' stamp: 'masch 6/27/2017 08:27:48'!
isStoleCard: aIsStolenCard
	isStolenCard := aIsStolenCard! !

!MerchantProcessorSimulator methodsFor: 'simulating' stamp: 'masch 6/27/2017 08:27:56'!
merchantProcessorWasCalled
	^numberCallsToMerchantProcessor > 0! !

!MerchantProcessorSimulator methodsFor: 'simulating' stamp: 'masch 6/27/2017 08:28:03'!
numberCallsToMerchantProcessor: aNumberCallsToMerchantProcessor
	numberCallsToMerchantProcessor _ aNumberCallsToMerchantProcessor! !


!MerchantProcessorSimulator methodsFor: 'external' stamp: 'masch 6/25/2017 08:59:42'!
creditAmount: aCreditAmount 
	creditAmount := aCreditAmount! !

!MerchantProcessorSimulator methodsFor: 'external' stamp: 'masch 6/25/2017 09:18:55'!
debitFrom: aCart withAmount: anAmount
	(isStolenCard) ifTrue: [ self error: 'The credit card was stolen'].
	(creditAmount < anAmount) ifTrue: [self error: 'The credit card does not have enough credit'].
	numberCallsToMerchantProcessor _ numberCallsToMerchantProcessor + 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'instance creation' stamp: 'masch 6/27/2017 08:41:18'!
withIsStolenCard: aIsStolenCard withCreditAmount: aCreditAmount
	^self new isStoleCard: aIsStolenCard; creditAmount: aCreditAmount; numberCallsToMerchantProcessor: 0; yourself.! !


!classDefinition: #SalesBook category: #TusLibros!
Object subclass: #SalesBook
	instanceVariableNames: 'salesCollectionBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SalesBook methodsFor: 'initializing' stamp: 'masch 6/27/2017 08:30:06'!
initialize
	salesCollectionBook _ OrderedCollection new.! !


!SalesBook methodsFor: 'adding' stamp: 'masch 6/24/2017 19:00:15'!
addSale: aSalePrice
	^salesCollectionBook add: aSalePrice! !


!SalesBook methodsFor: 'evaluating' stamp: 'masch 6/27/2017 08:28:33'!
isEmpty
	^salesCollectionBook isEmpty.! !


!classDefinition: #Store category: #TusLibros!
Object subclass: #Store
	instanceVariableNames: 'cartsOrdersList validsUsers catalog pricesList salesBook merchantProcessor dateTime usersPurchaces cartOrderTimeOutDuration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'modifying' stamp: 'masch 6/27/2017 08:30:57'!
addToCartWith: aCartId withBookISBN: anISBN withBookAmount: anAmount
	| cartOrder |
	
	cartOrder _ self listCartWith: aCartId.
	self validateCartOrderIsExpired: cartOrder.
	cartOrder add: anISBN withAmount: anAmount.! !

!Store methodsFor: 'modifying' stamp: 'masch 6/27/2017 08:31:25'!
checkoutWith: aCartOrderId withCreditCard: aCreditCard 
	| cartOrder cashier |

	cartOrder _ cartsOrdersList at: aCartOrderId.
	self validateCartOrderIsExpired: cartOrder.
		
	cashier := Cashier withPriceList: pricesList 
	                              withCart: cartOrder content
	                              withCreditCard: aCreditCard 
	                              withPaymentTimestamp: dateTime now
	                              withSalesBook: salesBook 
						    withMerchantProcessor: merchantProcessor.
						
	cashier checkout.
	
	self registerPurchase: cartOrder.
	
	! !

!Store methodsFor: 'modifying' stamp: 'masch 6/27/2017 08:32:02'!
createCartFor: aClientId authenticatedWith: aPassword
	| cartOrder |
	
	self validateUserFor: aClientId authenticatedWith: aPassword.
	
	cartOrder _ self createCartOrderFor: aClientId.
	self registerCartOrder: cartOrder.
	
	^cartOrder id! !

!Store methodsFor: 'modifying' stamp: 'masch 6/27/2017 08:32:09'!
createCartOrderFor: aClientId
	| cartOrderId cart |
	
	cartOrderId _ cartsOrdersList size.
	cart _ Cart with: catalog.
	
	^CartOrder withId: cartOrderId withCart: cart withOwner: aClientId withDateTime: dateTime withTimeOutDuration: cartOrderTimeOutDuration ! !

!Store methodsFor: 'modifying' stamp: 'masch 6/27/2017 08:33:24'!
registerCartOrder: aCartOrder 
	cartsOrdersList add: (Association key: aCartOrder id value: aCartOrder).
! !

!Store methodsFor: 'modifying' stamp: 'masch 6/27/2017 08:33:39'!
registerPurchase: aCartOrder
	usersPurchaces add: (Association key: (aCartOrder clientId) value: aCartOrder).
! !


!Store methodsFor: 'initializing' stamp: 'masch 6/27/2017 08:32:48'!
initialize
	cartsOrdersList _ Dictionary new.
	usersPurchaces _ Dictionary new.! !


!Store methodsFor: 'accessing' stamp: 'masch 6/27/2017 08:01:56'!
cartOrderTimeOutDuration: aDuration 
	cartOrderTimeOutDuration _ aDuration ! !

!Store methodsFor: 'accessing' stamp: 'masch 6/25/2017 16:34:06'!
catalog: aCatalog 
	catalog _ aCatalog! !

!Store methodsFor: 'accessing' stamp: 'masch 6/26/2017 06:37:27'!
dateTime: aDateTime
	dateTime _ aDateTime ! !

!Store methodsFor: 'accessing' stamp: 'masch 6/26/2017 07:40:54'!
listCartWith: anCartId
	^cartsOrdersList at: anCartId 
	ifPresent:[ :cartOrder | self validateCartOrderIsExpired: cartOrder. ^cartOrder]
	ifAbsent: [self error: 'Cart id is invalid']! !

!Store methodsFor: 'accessing' stamp: 'masch 6/27/2017 06:52:37'!
listPurchacesFor: aClientId authenticatedWith: aPassword
	self validateUserFor: aClientId authenticatedWith: aPassword.
	^usersPurchaces at: aClientId ! !

!Store methodsFor: 'accessing' stamp: 'masch 6/25/2017 18:08:49'!
merchantProcessor: aMerchantProcessor 
	merchantProcessor _ aMerchantProcessor! !

!Store methodsFor: 'accessing' stamp: 'masch 6/25/2017 17:46:11'!
pricesList: aPricesList
	pricesList _ aPricesList! !

!Store methodsFor: 'accessing' stamp: 'masch 6/25/2017 18:13:47'!
salesBook
	^salesBook! !

!Store methodsFor: 'accessing' stamp: 'masch 6/25/2017 17:59:24'!
salesBook: aSalesBook 
	salesBook _ aSalesBook ! !

!Store methodsFor: 'accessing' stamp: 'masch 6/27/2017 07:48:24'!
validateCartOrderIsExpired: aCartOrder
	aCartOrder isExpired ifTrue: [self error: 'The cart order is expired'].
	aCartOrder lastAccededTimeStamp: (dateTime now).
! !

!Store methodsFor: 'accessing' stamp: 'masch 6/27/2017 06:41:09'!
validateUserFor: aClientId authenticatedWith: aPassword
	| user |
	
	user _ validsUsers at: aClientId ifAbsent: [self error: 'Client id is invalid'].
	(user = aPassword) ifFalse: [self error: 'Client id is invalid'].! !

!Store methodsFor: 'accessing' stamp: 'masch 6/25/2017 11:05:36'!
validsUsers: aValidsUsers
	validsUsers _ aValidsUsers! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: #TusLibros!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'instance creation' stamp: 'masch 6/27/2017 07:58:51'!
withValidUsers: aValidsUsers withCatalog: aCatalog withPricesList: aPricesList withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor withDateTime: aDateTime withCartOrderTimeOutDuration: aCartOrderTimeOutDuration 
	^self new validsUsers: aValidsUsers; catalog: aCatalog; pricesList: aPricesList; salesBook: aSalesBook; merchantProcessor: aMerchantProcessor; dateTime: aDateTime; cartOrderTimeOutDuration: aCartOrderTimeOutDuration; yourself! !


!classDefinition: #StoreTestFactory category: #TusLibros!
Object subclass: #StoreTestFactory
	instanceVariableNames: 'validsUsers cartOrderValidDuration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestFactory methodsFor: 'creating' stamp: 'masch 6/27/2017 06:17:29'!
cartOrderValidDuration
	^cartOrderValidDuration! !

!StoreTestFactory methodsFor: 'creating' stamp: 'masch 6/27/2017 08:12:25'!
createAStore
	^ self createAStoreWithDateTime: self createDateTimeSimulator.

! !

!StoreTestFactory methodsFor: 'creating' stamp: 'masch 6/27/2017 08:11:16'!
createAStoreWithDateTime: aDateTime

	| book1 book2 catalogWithMultipleBooks |
	
	book1 := 'Un libro'.
	book2 := 'Dos libro'.

	catalogWithMultipleBooks := Set new.
	catalogWithMultipleBooks add: book1.
	catalogWithMultipleBooks add: book2.

	^Store withValidUsers: validsUsers 
	             withCatalog: catalogWithMultipleBooks 
	             withPricesList: self createPriceListWithThreeItems 
	             withSalesBook: self createSalesBook 
	             withMerchantProcessor: self createMerchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator
	             withDateTime: aDateTime
	             withCartOrderTimeOutDuration: (Duration minutes: 30).! !

!StoreTestFactory methodsFor: 'creating' stamp: 'masch 6/26/2017 06:35:29'!
createDateTimeSimulator
	
	^DateTimeSimulator new.
! !

!StoreTestFactory methodsFor: 'creating' stamp: 'masch 6/25/2017 18:04:25'!
createMerchantProcessorWithANonStolenCreditcardAnd100CreditAmountSimulator
	
	^MerchantProcessorSimulator withIsStolenCard: false withCreditAmount: 100.
! !

!StoreTestFactory methodsFor: 'creating' stamp: 'masch 6/25/2017 17:42:17'!
createPriceListWithThreeItems

	| priceListWithThreeItems |
	
	priceListWithThreeItems := Dictionary new.
	priceListWithThreeItems add: (Association key: 'Un libro' value: 1).
	priceListWithThreeItems add: (Association key: 'Dos libro' value: 2).
	priceListWithThreeItems add: (Association key: 'Tres libro' value: 3).
	
	^priceListWithThreeItems
! !

!StoreTestFactory methodsFor: 'creating' stamp: 'masch 6/25/2017 17:55:16'!
createSalesBook
	^SalesBook new.
! !

!StoreTestFactory methodsFor: 'creating' stamp: 'masch 6/27/2017 08:05:17'!
initialize
	validsUsers _ Dictionary new.
	validsUsers add: (Association key: 'clientId1' value: 'password1').
	cartOrderValidDuration _ (Duration minutes: 31).! !
