$(document).on 'turbolinks:load', ->
  if $('.sessions').length

    checkEmail = (obj) ->
      if obj.length < 1
        return true
      email = obj.val().trim()
      result = validateEmail(email)
      if result.code == 'error'
        obj.val('')
        displayError(obj, result.message)
        return false
      true

    $('.email-input').on 'change', ->
      clearError($(this))
      checkEmail($(this))

    checkPassword = (obj) ->
      if obj.length < 1
        return true
      pwd = obj.val().trim()
      if pwd.length < 6
        obj.val('')
        displayError(obj, '请输入正确的密码(至少6位)')
        return false
      true

    $('.password-input').on 'change', ->
      clearError($(this))
      checkPassword($(this))

    checkPasswordConfirmation = (pwdObj, pwdConfirmObj) ->
      if pwdConfirmObj.length < 1
        return true
      pwd = pwdObj.val().trim()
      pwdConfirm = pwdConfirmObj.val().trim()
      if pwd != pwdConfirm
        pwdConfirmObj.val('')
        displayError(pwdConfirmObj, '两次输入的密码不一致')
        return false
      true

    $('.password-confirmation-input').on 'change', ->
      clearError($(this))
      pwdObj = $(this).parents('form').find('.password-input')
      checkPasswordConfirmation(pwdObj, $(this))

    checkVerificationCode = (obj) ->
      if obj.length < 1
        return true
      code = obj.val().trim()
      if code.length != 6
        obj.val('')
        displayError(obj, '请输入正确的验证码(6位)')
        return false
      true


    $('input[placeholder]').on 'keyup', ->
      clearError($(this))

    # Submit the form
    $('.submit-button').on 'click', (e) ->
      that = $(this)
      form = that.parents('form')

      # Check input value
      m = checkEmail(form.find('.email-input'))
      p = checkPassword(form.find('.password-input'))
      c = checkPasswordConfirmation(form.find('.password-input'), form.find('.password-confirmation-input'))
      if m && p && c
        console.log form.find('.hidden-submit-button')
        #        form.find('.hidden-submit-button').click()
        form.submit()
      else
        console.log 'failed'

    # switch login box
    $('.switch-login').on 'click', ->
      box = $(this).parents('.login-box')
      box.fadeOut('slow', ->
        box.siblings('.login-box').fadeIn('slow')
      )

    # Switch to sign up
    $('.register').on 'click', ->
      box = $(this).parents('.login-box')
      box.fadeOut('slow', ->
        box.siblings('#register-box').fadeIn('slow')
      )

    # Switch to sign in
    $('.login-link').on 'click', ->
      box = $(this).parents('#register-box')
      box.fadeOut('slow', ->
        box.siblings('.login-box:first').fadeIn('slow')
      )

    $('.switch-link').on 'mouseover', ->
      $(this).css({"color": "blue"})

    $('.switch-link').on 'mouseout', ->
      $(this).css({"color": "#ADADAD"})


displayError = (obj, message) ->
  obj.parents('.form-item').addClass('form-item-error')
  obj.parents('.form-item').next().removeClass('hidden')
  obj.parents('.form-item').next().find('.error-message').text(message)

clearError = (obj) ->
  obj.parents('.form-item').removeClass('form-item-error')
  obj.parents('.form-item').next().addClass('hidden')
  obj.parents('.form-item').next().find('.error-message').text('')


