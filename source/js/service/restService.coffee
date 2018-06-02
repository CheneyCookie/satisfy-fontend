define [
  'angular'
  'angularResource'
  'angularRoute'
  'bootstrap'
], (angular) ->
  restService = angular.module("restService", [])
  restService.factory('restService', [
    '$http'
    '$q'
    (
    $http,
    $q
    ) ->
      obj = {}
      baseUrl = '/api/'
      obj.ajax = (method, url, params) ->
        defer = $q.defer()
        if method is 'GET'
          $http({
            url: baseUrl + url,
            method: "GET",
            # params: JSON.stringify(data),
            params: params,
            headers:{"Content-Type": "application/json"}
          }).then((data) ->
            defer.resolve(data)
          )
        else
          $http({
            url: baseUrl + url,
            method: method,
            # params: JSON.stringify(data),
            data: params,
            headers:{"Content-Type": "application/json"}
          }).then((data) ->
            defer.resolve(data)
          )
        defer.promise
      return obj


        # $http({
        #   url: url,
        #   method: method,
        #   data: JSON.stringify(data),
        #   headers:{"Content-Type":"application/json"}
        # }).then(
        #   (data)->
        #     promise.resolve(data)
        # )

  ])
