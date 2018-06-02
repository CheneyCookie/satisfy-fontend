define [
  'angular'
  'angularResource'
  'angularRoute'
  'bootstrap'
  'ngTable'
  'service/restService'
], (angular) ->
  app = angular.module('examListModule', ['restService', 'ngTable'])

  app.controller('examListController', [
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
          count: 5 # initial page size
        };

        initialSettings = {
          counts: [5, 10 ,20],
          getData: fetchExam
        };
        vm.tableParams = new NgTableParams(initialParams, initialSettings);

      fetchExam = (ngTable) ->
        deferred = $q.defer()
        param =
          pageNum: ngTable.page()
          pageSize: ngTable.count()
        restService.ajax('GET', 'exam/list', param).then((data) ->
          ngTable.total data.data.total
          deferred.resolve(data.data.list)
        )
        deferred.promise

      init = () ->
        initTableParams()

      init()

      vm
    ])
