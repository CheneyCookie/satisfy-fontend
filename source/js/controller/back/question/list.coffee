define [
  'angular'
  'angularResource'
  'angularRoute'
  'bootstrap'
  'ngTable'
  'service/restService'
], (angular) ->
  app = angular.module('questionListModule', ['restService', 'ngTable'])

  # app.config([
  #   'NgTableParamsProvider',
  #   (
  #     NgTableParamsProvider
  #   )
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

  app.controller('questionListController', [
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
      # ngTableSimpleMediumList
    ) ->

      vm = this
      vm.showDeleteTip = false
      vm.deleteId = 0

      initTableParams = () ->
        initialParams = {
          count: 5 # initial page size
          # initial sort order
          # sorting: { name: "asc" }
        };

        initialSettings = {
          # page size buttons (right set of buttons in demo)
          counts: [5, 10 ,20],
          # dataset: data
          getData: fetchQuestion
          # determines the pager buttons (left set of buttons in demo)
          # paginationMaxBlocks: 13,
          # paginationMinBlocks: 2,
        };
        vm.tableParams = new NgTableParams(initialParams, initialSettings);

      fetchQuestion = (ngTable) ->
        deferred = $q.defer()
        param =
          # pageInfo:
          pageNum: ngTable.page()
          pageSize: ngTable.count()
        restService.ajax('GET', 'question/list', param).then((data) ->
          # console.log data
          ngTable.total data.data.total
          deferred.resolve(data.data.list)
        )
        deferred.promise

      init = () ->
        initTableParams()

      init()

      vm.deleteQuestionTip = (id) ->
        vm.showDeleteTip = true
        vm.deleteId = id

      vm.deleteQuestion = () ->
        vm.showDeleteTip = false
        restService.ajax('GET', 'question/delete/' + vm.deleteId).then((data) ->
          console.log data
        )

      vm.cancelDelete = () ->
        vm.showDeleteTip = false

      vm
    ])
