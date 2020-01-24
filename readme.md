This program is provided for the checkout process of e-commerce system.

https://github.com/textmaster/tm-ruby-checkout

Instructions to run the application :

Requirements :

Ruby 2.6

To run the code :

ruby checkout.rb ==> You will get the result of added default products.

You can set any combination of products to get and test the different scenarios on the calling method just below the checkout.rb file.

Like : Checkout.checkout(['FR', 'FR', 'CF'])

Offers Added :

currently added three offers i.e. buy one get one free, item price reduced over a limit and discount on total price.
We can add many dynamic offer rules as well.

To run the test suit :
rspec spec
