
# main.js这个文件完成的事情简单来说就是：载入所有文件，然后在document上运行Angular并将ng-app属性设置为’app’。
# 这些文件因为是由RequireJS异步载入，因此我们需要来“手动启动”Angular应用。


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
  'controller/user/login'
], (angular, $) ->
  angular.bootstrap(document, ['login'])
