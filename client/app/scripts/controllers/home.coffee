'use strict'

###*
 # @ngdoc function
 # @name testApp.controller:HomeCtrl
 # @description
 # # HomeCtrl
 # Controller of the testApp
###
angular.module('testApp')
  .controller 'HomeCtrl', ($scope, customersManager) ->
    customersManager.fetchCustomers()
    customersManager.fetchCustomers(1)

    setTimeout ->
      console.log customersManager.getCustomers(1)
    , 1000
