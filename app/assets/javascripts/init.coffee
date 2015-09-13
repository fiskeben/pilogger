window.App ||= {};

App.init = (uri) ->
  if $('.users.show').length == 1
    userId = App.entityId(uri)
    initChart(userId)

App.entityId = (uri) ->
  index = uri.lastIndexOf '/'
  return unless index > 0
  return uri.substring(index + 1)

$(document).on 'page:change', (event) ->
  App.init(event.target.baseURI)
