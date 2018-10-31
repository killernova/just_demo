$(document).on 'turbolinks:load', ->
  if $('.articles').length
    if $('#article-content').length
      quill = new Quill('#article-content', {
        modules: {
          toolbar: [
            [{ header: [1, 2, 3, 4, 5, false] }],
            ['bold', 'italic', 'underline'],
            ['code-block']
          ]
        }
        placeholder: 'Compose an epic...',
        theme: 'snow'
      })

    $('#article_published_at').datetimepicker({
      format: 'yyyy-mm-dd hh:ii',
      autoclose: true,
      minView: 'day',
      startView: 'month'
    })

    $('.submit-button').on 'click', ->
      content = quill.getText()
      console.log content
      $(this).parents('form').find('#article_body').val(content)
      $(this).parents('form').submit()