require.config

  urlArgs: "bust=" + (new Date()).getTime()
  baseUrl: '../../../js'

  paths:
    jquery: 'lib/jquery/dist/jquery.min'
    angular: 'lib/angular/angular'
    angularRoute: 'lib/angular-route/angular-route.min'
    angularResource: 'lib/angular-resource/angular-resource.min'
    bootstrap: 'lib/bootstrap/dist/js/bootstrap.min'
    ngTable: 'lib/ng-table/dist/ng-table'

  shim:
    jquery:
      exports: 'jquery'
    angular:
      exports: 'angular'
    bootstrap: ['jquery']
    angularRoute: ['angular']
    angularResource: ['angular']
    ngTable: ['jquery', 'angular']

define [
  'angular'
  'jquery'
  'bootstrap'
  'ngTable'
  'controller/back/exam/list'
], (angular, $) ->
  angular.bootstrap(document, ['examListModule'])
