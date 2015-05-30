'use strict'

###*
 # @ngdoc service
 # @name testApp.customersManager
 # @description
 # # customersManager
 # Factory in the testApp.
###
angular.module('testApp')
  .factory 'customersManager', ['$http', '$q', 'Customers',
  ($http, $q, Customers)->

    customersManager =
      _pool: {}

      _retrieveInstance: (customerData) ->
        instance = @_pool[customerData.id]

        if instance
          instance = customerData
        else
          instance = new Customers(customerData)
          @_pool[customerData.id] = instance

        instance

      fetchCustomers: (id)->
        deferred = $q.defer()
        scope = this

        Customers.query {id: id}, (customersArray)->
          customers = []

          customersArray.forEach (customerData) ->
            customer = scope._retrieveInstance(customerData)
            customers.push customer

          deferred.resolve customers

        deferred.promise

      getCustomers: (id)->
        if (id) then @_pool[id] else @_pool

      createCustomer: (customerData) ->
        deferred = $q.defer()
        scope = this

        Customers.create customerData, ->
          customer = scope._retrieveInstance(customerData)
          deferred.resolve customer

        deferred.promise

    customersManager
  ]
