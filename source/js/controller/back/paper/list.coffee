define [
  'angular'
  'angularResource'
  'angularRoute'
  'bootstrap'
  'ngTable'
  'service/restService'
], (angular) ->
  app = angular.module('paperListModule', ['restService', 'ngTable'])

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

  app.controller('paperListController', [
    '$scope'
    '$http'
    '$q'
    '$location'
    'restService'
    'NgTableParams'
    (
      $scope,
      $http,
      $q,
      $location,
      restService,
      NgTableParams
    ) ->

      vm = this

      initTableParams = () ->
        initialParams = {
          count: 5
        };

        initialSettings = {
          counts: [5, 10 ,20],
          getData: fetchPaper
        };
        vm.tableParams = new NgTableParams(initialParams, initialSettings);

      fetchPaper = (ngTable) ->
        deferred = $q.defer()
        param =
          pageNum: ngTable.page()
          pageSize: ngTable.count()
        restService.ajax('GET', 'paper/list', param).then((data) ->
          console.log data
          ngTable.total data.data.total
          deferred.resolve(data.data.list)
        )
        deferred.promise

      init = () ->
        initTableParams()

      init()

      vm
    ])
