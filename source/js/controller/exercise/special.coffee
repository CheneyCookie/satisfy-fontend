define [
  'angular'
  'angularResource'
  'angularRoute'
  'bootstrap'
  'service/restService'
], (angular) ->
  app = angular.module('special', ['restService'])

  app.factory('Http401Interceptor', ($q) ->
    return {
      responseError: (response) ->
        if response.status is 401
          location.href = 'http://www.satisfy.com/page/user/login';
        return $q.reject(response);
    });

  app.config([
    '$httpProvider',
    '$locationProvider'
    ($httpProvider, $locationProvider) ->
      $httpProvider.interceptors.push('Http401Interceptor')
      $locationProvider.html5Mode({
        enabled: true
        requireBase: false
      })
  ])

  app.filter('NumberToEngilsh', ()->
    (number) ->
      return String.fromCharCode(64 + parseInt(number))
  )

  app.controller('specialController', [
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
      vm.generateExam = true
      vm.index = 0
      vm.total = 0
      vm.paper = {}
      vm.questions = []
      vm.currentQuestion = {}
      vm.currentQuestion.choiceAnswer = ''
      vm.lastQuestion = false
      vm.hasSubmit = false

      init = () ->
        id = $location.search().id
        if id isnt undefined or ''
          restService.ajax('GET', 'paper/' + id).then((data) ->
            console.log data.data
            vm.paper = data.data
            vm.questions = data.data.questions
            vm.total = data.data.questions.length
            vm.currentQuestion = vm.questions[vm.index]
          )

      init()

      vm.nextQuestion = () ->
        vm.index = vm.index + 1
        if vm.index < vm.total
          vm.currentQuestion = vm.questions[vm.index]
          # angular.element('.click-active').removeClass 'click-active'
          # angular.element(angular.element('.card-span')[vm.index]).addClass 'click-active'
        else
          vm.index = vm.index - 1

      vm.changeQuestion = (index, event) ->
        vm.index = index
        vm.currentQuestion = vm.questions[vm.index]
        # angular.element('.click-active').removeClass 'click-active'
        # angular.element(event.target).addClass 'click-active'

      vm.submit = () ->
        vm.hasSubmit = true
        vm.index = 0
        vm.currentQuestion = vm.questions[vm.index]

      vm.addColor = (event) ->
        angular.element(event.target).addClass 'on-active'

      vm.removeColor = (event) ->
        angular.element(event.target).removeClass 'on-active'

      vm
    ])
