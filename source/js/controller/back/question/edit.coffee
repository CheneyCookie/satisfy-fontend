define [
  'angular'
  'angularResource'
  'angularRoute'
  'bootstrap'
  'service/restService'
], (angular) ->
  app = angular.module('questionEditModule', ['restService'])

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

  app.controller('questionEditController', [
    '$scope'
    '$http'
    '$q'
    '$window'
    '$location'
    'restService'
    (
      $scope,
      $http,
      $q,
      $window,
      $location,
      restService
    ) ->

      vm = this
      vm.question = {}
      vm.question.questionType = '选择题'
      vm.question.answers = new Array()
      vm.answerA = ''
      vm.answerB = ''
      vm.answerC = ''
      vm.answerD = ''
      vm.a = false
      vm.b = false
      vm.c = false
      vm.d = false
      vm.canSubmit = false
      vm.isCreate = true
      vm.tags = ['Java', '数据结构', '算法', 'C/C++', 'ASP.NET', 'Python']
      vm.tag = vm.tags[0]



      init = () ->
        id = $location.search().id
        if id isnt undefined or ''
          vm.isCreate = false
          restService.ajax('GET', 'question/' + id).then((data) ->
            console.log data.data
            vm.question = data.data
            vm.answerA = data.data.answers[0].content
            vm.answerB = data.data.answers[1].content
            vm.answerC = data.data.answers[2].content
            vm.answerD = data.data.answers[3].content
            vm.a = data.data.answers[0].rightAnswer
            vm.b = data.data.answers[1].rightAnswer
            vm.c = data.data.answers[2].rightAnswer
            vm.d = data.data.answers[3].rightAnswer
          )


      init()

      vm.changeSelect = () ->
        vm.question.questionType = '选择题'

      vm.changeObject = () ->
        vm.question.questionType = '主观题'

      vm.saveSelectQuestion = () ->
        if vm.question.questionType is '选择题' or vm.question.questionType is 'select'
          vm.validateSelection()
          answerA =
            id: vm.question.answers[0].id if vm.question.answers[0]
            content: vm.answerA
            rightAnswer: vm.a

          answerB =
            id: vm.question.answers[1].id if vm.question.answers[1]
            content: vm.answerB
            rightAnswer: vm.b
          answerC =
            id: vm.question.answers[2].id if vm.question.answers[2]
            content: vm.answerC
            rightAnswer: vm.c
          answerD =
            id: vm.question.answers[3].id if vm.question.answers[3]
            content: vm.answerD
            rightAnswer: vm.d
          vm.question.answers = [answerA, answerB, answerC, answerD]
          console.log vm.question

          if vm.canSubmit
            if vm.isCreate
              restService.ajax('POST', 'question', vm.question).then((data) ->
                alert '创建成功'
                vm.question = {}
                vm.answerA = ''
                vm.answerB = ''
                vm.answerC = ''
                vm.answerD = ''
                vm.a = false
                vm.b = false
                vm.c = false
                vm.d = false
              )
            else
              restService.ajax('PUT', 'question', vm.question).then((data) ->
                console.log data.data
                window.location.href = 'http://www.satisfy.com/page/back/question/list'
              )
        else
          console.log '主观题'

      vm.cancel = () ->
        $window.location.href = '/page/back/question/list'

      vm.validateTitle = () ->
        vm.titleError = ''
        if vm.question.title is undefined or vm.question.title is ''
          vm.canSubmit = false
          vm.titleError = '题目不能为空'
        else
          vm.canSubmit = true

      vm.validateAnswerA = () ->
        vm.answerAError = ''
        if vm.answerA is undefined or vm.answerA is ''
          vm.canSubmit = false
          vm.answerAError = '选项不能为空'
        else
          vm.canSubmit = true

      vm.validateAnswerB = () ->
        vm.answerBError = ''
        if vm.answerB is undefined or vm.answerB is ''
          vm.canSubmit = false
          vm.answerBError = '选项不能为空'
        else
          vm.canSubmit = true

      vm.validateAnswerC = () ->
        vm.answerCError = ''
        if vm.answerC is undefined or vm.answerC is ''
          vm.canSubmit = false
          vm.answerCError = '选项不能为空'
        else
          vm.canSubmit = true

      vm.validateAnswerD = () ->
        vm.answerDError = ''
        if vm.answerD is undefined or vm.answerD is ''
          vm.canSubmit = false
          vm.answerDError = '选项不能为空'
        else
          vm.canSubmit = true

      vm.validateSelection = () ->
        vm.validateTitle()
        vm.validateAnswerA()
        vm.validateAnswerB()
        vm.validateAnswerC()
        vm.validateAnswerD()

      vm
    ])
