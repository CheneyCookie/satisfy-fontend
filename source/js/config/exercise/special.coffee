require.config
  baseUrl: "/js"
  urlArgs: "bust=" + (new Date()).getTime()

  paths:
    jquery: 'lib/jquery/dist/jquery.min'
    angular: 'lib/angular/angular'
    angularRoute: 'lib/angular-route/angular-route.min'
    angularResource: 'lib/angular-resource/angular-resource.min'
    bootstrap: 'lib/bootstrap/dist/js/bootstrap.min'

  shim:
    jquery:
      exports: 'jquery'
    angular:
      exports: 'angular'
    bootstrap: ['jquery']
    angularRoute: ['angular']
    angularResource: ['angular']

define [
  'angular'
  'jquery'
  'bootstrap'
  'controller/exercise/special'
], (angular, $) ->
  angular.bootstrap(document, ['special'])
