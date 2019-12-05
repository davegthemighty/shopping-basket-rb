# Shopping Basket API Demo

## Overview

## Server Running Instructions - Vagrant

Requires Vagrant and a Virtualisation Engine

https://www.vagrantup.com/downloads.html
https://www.virtualbox.org/wiki/Downloads

Once installed, you can navigate to the root directory of this project (with the VagrantFile), and run
```
vagrant up
```

This will provision a vagrant server with ubuntu 18.04, ruby/rails, sqlite, and apache. It will also create the database, and bring in the gem dependencies.

There will be a lot of commands executed, with information shown in red or green. There shouldn't be anything to worry about, but the check is whether you reach the 'Vagrant Up' message, and there are no exit codes reported.

All being well, it will allow you to browse to the site and start making requests. Further instructions can be found below.

## Server Running Instructions - Other

To set this up without vagrant requires a few hoops to create the expected environment. If necessary these steps can be determined from the VagrantFile.

## Source

This app was created, largely based on the following tutorial: https://guides.rubyonrails.org/getting_started.html

It may be a fairly basic approach, but it felt better to produce something simple than attempt and fail at something more complex.

## Limitations / Further Work

As mentioned, as ruby isn't my first language, and this was done to a tight schedule, there will always be areas to improve following a review.

Compared to the PHP version it lacks the ability to supply the quantity of items to add/remove.

It also does not remove a basket line if the item is removed (quantity 0)

## Server Running Instructions

To SSH onto the running server, from the directory root use:

```
vagrant ssh
```

The URL is 192.168.50.53

On the server, the code is situated in /vagrant/api

## Running Instructions

### API Running Instructions

Baskets

_GET all_

```
curl "http://192.168.50.53/baskets"
```

_GET by ID_

```
curl "http://192.168.50.53/baskets/1"

```

_POST New_

```
curl -X POST http://192.168.50.53/baskets
```

Items

_GET all_

```
curl "http://192.168.50.53/items"
```

_GET by ID_

```
curl "http://192.168.50.53/items/1"
```

Basket Lines

_Add one Item to a Basket_
```
curl -X PUT http://192.168.50.53/baskets/2/items/1

```

_Delete one Item from the Basket_
```
curl -X DELETE http://192.168.50.53/baskets/2/items/1
```

_Add a quantity of Items to a Basket (Not Implemented)_
```
curl "http://192.168.50.53/baskets/2/items/1?quantity=3" \
     --request PUT
```

_Delete a quantity of Items from the Basket (Not Implemented)_
```
curl "http://192.168.50.53/baskets/2/items/1?quantity=3" \
     --request DELETE
```

### Running the Tests

```
vagrant ssh
cd /vagrant/api
bin/rails test
```
