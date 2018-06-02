define [
  'angular'
  'angularResource'
  'angularRoute'
  'bootstrap'
  'service/restService'
], (angular) ->
  app = angular.module('generate', ['restService'])

  app.factory('Http401Interceptor', ($q) ->
    return {
      responseError: (response) ->
        if response.status is 401
          location.href = 'http://www.satisfy.com/page/user/login';
        return $q.reject(response);
    });

  app.config([
    '$httpProvider',
    ($httpProvider) ->
      $httpProvider.interceptors.push('Http401Interceptor');
  ])

  app.controller('generateController', [
    '$scope'
    '$http'
    '$window'
    '$location'
    'restService'
    (
      $scope,
      $http,
      $window,
      $location,
      restService
    ) ->

      vm = this

      vm.tags = ['Java', '数据结构', '算法', 'C/C++', 'ASP.NET', 'Python']
      vm.tag = vm.tags[0]
      vm.number = 10

      init = () ->
        restService.ajax('GET', 'user/500').then((data) ->
          console.log data.data.id
        )

      init()

      vm.generate = () ->
        param =
          number: vm.number
        restService.ajax('POST', 'paper/special', param).then((data) ->
          console.log data.data.id
          $window.location.href = '/page/exercise/special?id=' + data.data.id
        )

      vm
    ])
