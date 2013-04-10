$ ->
  $('.btn.colinear').click ->
    fill_form_with(default_points.colinear)

  $('.btn.noncolinear').click ->
    fill_form_with(default_points.noncolinear)

  $('.btn.clear-points').click ->
    clear_points()

  $('.points-form').on 'ajax:success', 'form', (e, response) ->
    append_messages(response.messages)
    if !response.colinear
      console.log response.p5

fill_form_with = (points) ->
  clear_points()

  for point, i in points
    for coordinate, j in point
      input = $('.point-inputs').eq(i).find('input').eq(j)
      input.val(coordinate)

  $('.points-form form').submit()

clear_points = ->
  $('.point-inputs input').val('')
  $('.messages').hide(300)

append_messages = (messages) ->
  $('.messages').hide()
  ul = $('.messages ul')
  ul.html('')
  for message in messages
    li = $('<li/>')
    li.html(message)
    ul.append(li)
  $('.messages').show(500)
