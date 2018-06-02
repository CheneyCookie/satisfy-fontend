define [
  'angular'
  'angularResource'
  'angularRoute'
  'bootstrap'
  'service/restService'
], (angular) ->
  app = angular.module('login', ['restService'])

  app.controller('loginController', [
    '$scope'
    '$http'
    '$window'
    'restService'
    (
      $scope,
      $http,
      $window,
      restService
    ) ->

      vm = this

      init = () ->

      init()

      vm.login = () ->
        param =
          username: vm.username
          password: vm.password
        restService.ajax('POST', 'user/login', param).then((data) ->
          console.log data
          if data.data
            if data.data.role.id is 1
              $window.location.href = '/page/back/question/list'
            if data.data.role.id is 2
              $window.location.href = 'http://www.satisfy.com'
        )


      vm
    ])
