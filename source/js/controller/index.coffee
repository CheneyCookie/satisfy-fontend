define [
  'angular'
  'angularResource'
  'angularRoute'
  'bootstrap'
], (angular) ->
  app = angular.module('indexMoudel',['ngRoute'])

  # app.config([
  #   '$routeProvider',
  #   (
  #     $routeProvider
  #   ) ->

  #      $routeProvider.when('/index', {
  #           templateUrl: '/page/index.html',
  #           controller: 'indexController'
  #       }).otherwise({ redirectTo: '/index' });
  # ])

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

  app.controller('indexController', [
    '$scope'
    (
      $scope
    ) ->

      vm = this
      init = () ->
        console.log 111

      init
    ])
