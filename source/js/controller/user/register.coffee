define [
  'angular'
  'angularResource'
  'angularRoute'
  'bootstrap'
  'service/restService'
], (angular) ->
  app = angular.module('register', ['restService'])

  app.controller('registerController', [
    '$scope'
    'restService'
    (
      $scope,
      restService
    ) ->

      vm = this
      vm.email = ''
      vm.password = ''
      vm.rePassword = ''
      vm.emailError = ''
      vm.passwordError = ''
      vm.rePasswordError= ''
      vm.canSubmit = false

      init = () ->
        console.log 222
      init()

      vm.validateEmailInput = () ->
        vm.emailError = ''
        if vm.email is undefined or vm.email is ''
          vm.canSubmit = false
          vm.emailError = '邮箱不能为空'
        else
          vm.canSubmit = true

      vm.validateLeaveEmail = () ->
        vm.emailError = ''
        reg = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
        if not reg.test vm.email
          vm.canSubmit = false
          vm.emailError = '请输入正确的邮箱'
        else
          param =
            emailOrName: vm.email
          if vm.email isnt undefined and vm.email isnt ''
            restService.ajax('GET', 'user/emailOrName', param).then((data) ->
              if data.data is true
                vm.canSubmit = false
                vm.emailError = '邮箱已存在'
              else
                vm.canSubmit = true
            )

      vm.validatePasswprdInput = () ->
        vm.passwordError = ''
        if vm.password is undefined or vm.password is ''
          vm.canSubmit = false
          vm.passwordError = '密码不能为空'
        else
          vm.canSubmit = true

      vm.validateLeavePassword = () ->
        vm.passwordError = ''
        if vm.password.length < 8 or vm.password.length > 16
          vm.canSubmit = false
          vm.passwordError = '密码长度为8~16位'
        else
          vm.canSubmit = true


      vm.validateRePasswprdInput = () ->
        vm.rePasswordError = ''
        if vm.rePassword is undefined or vm.rePassword is ''
          vm.canSubmit = false
          vm.rePasswordError = '重复密码不能为空'
        else
          vm.canSubmit = true

      vm.validateLeaveRePasswprd = () ->
        vm.rePasswordError = ''
        if vm.rePassword isnt vm.password
            vm.canSubmit = false
            vm.rePasswordError = '重复密码不一致'
          else
            vm.canSubmit = true

      vm.register = () ->
        validateSelection
        if vm.canSubmit
          params =
            email: vm.email
            password: vm.password
          restService.ajax('POST', 'user/register', params).then((data) ->
            if data.data
              window.location.href = "http://www.satisfy.com/page/user/login"
          )


      validateSelection = () ->
        vm.validateEmailInput()
        vm.validatePasswprdInput()
        vm.validateRePasswprdInput()

      vm
    ])
